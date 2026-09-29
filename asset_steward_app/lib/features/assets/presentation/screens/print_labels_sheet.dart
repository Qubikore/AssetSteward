import 'dart:convert';

import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintLabelsSheet extends HookConsumerWidget {
  final int? assetId;
  const PrintLabelsSheet({super.key, this.assetId});

  static Future<void> show(BuildContext context, {int? assetId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => PrintLabelsSheet(assetId: assetId),
    );
  }

  Future<void> _generatePdf(List<AssetLabelResponse> labels, String orgName, String fileName, double pdfWidth) async {
    final doc = pw.Document();

    pw.Font? font;
    pw.Font? fontBold;
    try {
      font = await PdfGoogleFonts.outfitRegular();
      fontBold = await PdfGoogleFonts.outfitBold();
    } catch (e) {
      font = pw.Font.helvetica();
      fontBold = pw.Font.helveticaBold();
    }

    final format = PdfPageFormat(pdfWidth, PdfPageFormat.a4.height, marginAll: 16);

    doc.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) {
          return [
            pw.Wrap(
              spacing: 8,
              runSpacing: 8,
              children: labels.map((label) {
                final qrData = jsonEncode({'id': label.id, 'name': label.name, 'assetCode': label.assetCode});

                return pw.Container(
                  width: 200,
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Text(
                        orgName,
                        style: pw.TextStyle(font: fontBold, fontSize: 14),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        label.name,
                        style: pw.TextStyle(font: font, fontSize: 12),
                        textAlign: pw.TextAlign.center,
                        maxLines: 2,
                      ),
                      pw.SizedBox(height: 8),
                      pw.BarcodeWidget(barcode: pw.Barcode.qrCode(), data: qrData, width: 100, height: 100),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        label.assetCode,
                        style: pw.TextStyle(font: fontBold, fontSize: 12),
                        textAlign: pw.TextAlign.center,
                      ),
                      if (label.expireDate != null) ...[
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Exp: ${label.expireDate}',
                          style: pw.TextStyle(font: font, fontSize: 10),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ];
        },
      ),
    );

    final bytes = await doc.save();

    await FilePicker.saveFile(
      bytes: bytes,
      dialogTitle: 'Save Asset Labels PDF',
      fileName: '$fileName.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final pdfWidth = useState<double>(595.0); // Standard A4 width

    final org = ref.watch(organizationCtrlProvider).value;
    final orgName = org?.name ?? 'Asset Steward';

    void onPrint() async {
      isLoading.value = true;
      try {
        final labels = assetId == null
            ? await ref.read(assetsCtrlProvider().notifier).getAssetLabels()
            : [await ref.read(assetDetailsCtrlProvider(assetId!).notifier).getAssetLabel()];
        if (labels.isEmpty) {
          if (context.mounted) Toast.showError('No labels found to print');
          return;
        }

        await _generatePdf(
          labels,
          orgName,
          assetId == null ? 'asset_labels_${DateTime.now().toIso8601String()}' : 'asset_label_$assetId',
          pdfWidth.value,
        );
        if (context.mounted) context.pop();
      } catch (e, s) {
        if (context.mounted) Toast.showError('Failed to generate PDF: $e');
        Chirp.error('message', error: e, stackTrace: s);
      } finally {
        isLoading.value = false;
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(HIStroke.printer, size: 28),
                  const Gap(12),
                  Text('Print Asset Labels', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(HIStroke.informationCircle, color: context.colors.primary, size: 15),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        'This will fetch the asset label(s) and generate a printable PDF. You can adjust the PDF page width to fit your printer',
                        style: context.text.labelSmall?.copyWith(color: context.colors.outline),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              Text('Page Width: ${pdfWidth.value.toInt()} px', style: context.text.titleMedium),
              const Gap(8),
              Row(
                children: [
                  const Text('220', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      value: pdfWidth.value,
                      min: 220,
                      max: 1200,
                      divisions: 98,
                      label: '${pdfWidth.value.toInt()}',
                      onChanged: (val) => pdfWidth.value = val,
                    ),
                  ),
                  const Text('1200', style: TextStyle(fontSize: 12)),
                ],
              ),
              Text(
                'Each label has a fixed width of 200px. The PDF will wrap labels horizontally to fit the page width.',
                style: context.text.bodySmall?.copyWith(color: context.colors.outline),
                textAlign: TextAlign.center,
              ),
              const Gap(32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isLoading.value ? null : () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isLoading.value ? null : onPrint,
                      icon: isLoading.value
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(HIStroke.printer),
                      label: Text(isLoading.value ? 'Generating...' : 'Print PDF'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
