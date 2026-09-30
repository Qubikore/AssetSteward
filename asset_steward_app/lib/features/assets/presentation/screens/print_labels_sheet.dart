import 'dart:convert';
import 'dart:typed_data';

import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/asset_details_controller.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:open_filex/open_filex.dart';
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

  Future<Uint8List> _generatePdf(List<AssetLabelResponse> labels, String orgName, double pdfWidth) async {
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

    return await doc.save();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final pdfWidth = useState<double>(21.0); // Standard A4 width in cm

    final org = ref.watch(organizationCtrlProvider).value;
    final orgName = org?.name ?? 'Asset Steward';

    Future<Uint8List?> generateBytes() async {
      isLoading.value = true;
      try {
        final labels = assetId == null
            ? await ref.read(assetsCtrlProvider().notifier).getAssetLabels()
            : [await ref.read(assetDetailsCtrlProvider(assetId!).notifier).getAssetLabel()];
        if (labels.isEmpty) {
          if (context.mounted) Toast.showError('No labels found to print');
          return null;
        }
        return await _generatePdf(labels, orgName, pdfWidth.value * 28.346);
      } catch (e, s) {
        if (context.mounted) Toast.showError('Failed to generate PDF: $e');
        Chirp.error('message', error: e, stackTrace: s);
        return null;
      } finally {
        isLoading.value = false;
      }
    }

    void onDownload() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      final fileName = assetId == null
          ? 'asset_labels_${DateTime.now().toIso8601String().replaceAll(':', '-')}'
          : 'asset_label_$assetId';
      final savedPath = await FilePicker.saveFile(
        bytes: bytes,
        dialogTitle: 'Save Asset Labels PDF',
        fileName: '$fileName.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (context.mounted) context.pop();

      if (savedPath != null) {
        Toast.showSuccess(
          'PDF saved successfully',
          actionLabel: 'Open',
          action: () async {
            String cleanPath = savedPath.toString();
            if (cleanPath.startsWith('/document/raw:')) {
              cleanPath = cleanPath.replaceFirst('/document/raw:', '');
            } else if (cleanPath.startsWith('/document/primary:')) {
              cleanPath = cleanPath.replaceFirst('/document/primary:', '/storage/emulated/0/');
            }
            cleanPath = Uri.decodeFull(cleanPath);

            final a = await OpenFilex.open(cleanPath);
            if (a.type != ResultType.done) {
              Chirp.error('Failed to open file: ${a.message}');
            }
          },
        );
      }
    }

    void onPrint() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      await Printing.layoutPdf(onLayout: (_) async => bytes, name: 'Asset Labels');
      if (context.mounted) context.pop();
    }

    void onShare() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      final fileName = assetId == null ? 'asset_labels_${DateTime.now().toIso8601String()}' : 'asset_label_$assetId';
      await Printing.sharePdf(bytes: bytes, filename: '$fileName.pdf');
      if (context.mounted) context.pop();
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
                  Expanded(
                    child: Text(
                      'Print Asset Labels',
                      style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isLoading.value)
                    const Loader(size: 18, strokeWidth: 2)
                  else
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: context.colors.primary.op2,
                        foregroundColor: context.colors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: isLoading.value ? null : () => context.nPop(),
                      icon: const Icon(HIStroke.cancel01, size: 20),
                    ),
                ],
              ),

              const Gap(24),
              Text('Page Width: ${pdfWidth.value.toStringAsFixed(1)} cm', style: context.text.titleMedium),
              const Gap(8),
              Row(
                children: [
                  const Text('5.0', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      value: pdfWidth.value,
                      min: 5.0,
                      max: 30.0,
                      divisions: 250,
                      label: '${pdfWidth.value.toStringAsFixed(1)} cm',
                      onChanged: (val) => pdfWidth.value = val,
                    ),
                  ),
                  const Text('30.0', style: TextStyle(fontSize: 12)),
                ],
              ),
              const Gap(8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _PresetChip(
                      label: '2" Roll',
                      width: 5.0,
                      current: pdfWidth.value,
                      onSelect: (w) => pdfWidth.value = w,
                    ),
                    const Gap(8),
                    _PresetChip(
                      label: '62mm',
                      width: 6.2,
                      current: pdfWidth.value,
                      onSelect: (w) => pdfWidth.value = w,
                    ),
                    const Gap(8),
                    _PresetChip(
                      label: '3" Roll',
                      width: 7.6,
                      current: pdfWidth.value,
                      onSelect: (w) => pdfWidth.value = w,
                    ),
                    const Gap(8),
                    _PresetChip(
                      label: '4" Roll',
                      width: 10.1,
                      current: pdfWidth.value,
                      onSelect: (w) => pdfWidth.value = w,
                    ),
                    const Gap(8),
                    _PresetChip(label: 'A4', width: 21.0, current: pdfWidth.value, onSelect: (w) => pdfWidth.value = w),
                    const Gap(8),
                    _PresetChip(
                      label: 'Letter',
                      width: 21.6,
                      current: pdfWidth.value,
                      onSelect: (w) => pdfWidth.value = w,
                    ),
                  ],
                ),
              ),
              const Gap(16),
              Text(
                'Each label has a fixed width of ~7cm (200pt). The PDF will wrap labels horizontally to fit the page width.',
                style: context.text.bodySmall?.copyWith(color: context.colors.outline),
                textAlign: TextAlign.center,
              ),
              const Gap(32),
              Row(
                children: [
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: context.colors.primary.op2,
                      foregroundColor: context.colors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: isLoading.value ? null : onShare,
                    icon: const Icon(HIStroke.share03, size: 20),
                  ),
                  const Gap(6),
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: context.colors.primary.op2,
                        foregroundColor: context.colors.primary,
                      ),
                      onPressed: isLoading.value ? null : onPrint,
                      icon: const Icon(HIStroke.printer),
                      label: const Text('Print'),
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isLoading.value ? null : onDownload,
                      icon: const Icon(HIStroke.download01),
                      label: const Text('Download'),
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

class _PresetChip extends StatelessWidget {
  final String label;
  final double width;
  final double current;
  final ValueChanged<double> onSelect;

  const _PresetChip({required this.label, required this.width, required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isSelected = (current - width).abs() < 0.05;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (_) => onSelect(width),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      showCheckmark: false,
      selectedColor: context.colors.primaryContainer,
    );
  }
}
