import 'dart:typed_data';

import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:recase/recase.dart';

enum ReportGroup { none, category, department, location, status, purchaseYear, purchaseMonth, purchaseDay }

class StockReportSheet extends HookConsumerWidget {
  const StockReportSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => const StockReportSheet(),
    );
  }

  Future<Uint8List> _generatePdf({
    required List<AssetModel> assets,
    required String orgName,
    required String creatorName,
    required ReportGroup groupBy,
    required bool showCode,
    required bool showSerial,
    required bool showCategory,
    required bool showDepartment,
    required bool showLocation,
    required bool showStatus,
    required bool showQty,
    required bool showPrice,
  }) async {
    final doc = pw.Document();
    pw.Font? font;
    pw.Font? fontBold;
    pw.Font? fallbackFont;
    try {
      font = await PdfGoogleFonts.outfitRegular();
      fontBold = await PdfGoogleFonts.outfitBold();
      fallbackFont = await PdfGoogleFonts.notoSansBengaliRegular();
    } catch (e) {
      font = pw.Font.helvetica();
      fontBold = pw.Font.helveticaBold();
      fallbackFont = font;
    }

    final Map<String, List<AssetModel>> groupedAssets = {};
    if (groupBy == ReportGroup.none) {
      groupedAssets['All Assets'] = assets;
    } else {
      for (var asset in assets) {
        String key = 'Unknown';
        switch (groupBy) {
          case ReportGroup.category:
            key = asset.category?.name ?? 'Uncategorized';
            break;
          case ReportGroup.department:
            key = asset.department?.name ?? 'Unassigned';
            break;
          case ReportGroup.location:
            key = asset.location?.name ?? 'Unlocated';
            break;
          case ReportGroup.status:
            key = asset.status.name.titleCase;
            break;
          case ReportGroup.purchaseYear:
            final date = DateTime.tryParse(asset.purchaseDate);
            key = date?.year.toString() ?? 'Unknown Date';
            break;
          case ReportGroup.purchaseMonth:
            final date = DateTime.tryParse(asset.purchaseDate);
            key = date != null ? DateFormat.yMMMM().format(date) : 'Unknown Date';
            break;
          case ReportGroup.purchaseDay:
            final date = DateTime.tryParse(asset.purchaseDate);
            key = date != null ? DateFormat.yMMMd().format(date) : 'Unknown Date';
            break;
          case ReportGroup.none:
            break;
        }
        groupedAssets.putIfAbsent(key, () => []).add(asset);
      }
    }

    final headers = [
      'Name',
      if (showCode) 'Asset Code',
      if (showSerial) 'Serial No.',
      if (showCategory && groupBy != ReportGroup.category) 'Category',
      if (showDepartment && groupBy != ReportGroup.department) 'Dept.',
      if (showLocation && groupBy != ReportGroup.location) 'Location',
      if (showStatus && groupBy != ReportGroup.status) 'Status',
      if (showQty) 'Qty',
      if (showPrice) 'Unit Price',
      if (showQty && showPrice) 'Total Value',
    ];

    double overallTotalValue = 0;
    int overallTotalQty = 0;

    doc.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font, bold: fontBold, fontFallback: [fallbackFont]),
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(32),
        header: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    orgName,
                    style: pw.TextStyle(font: fontBold, fontSize: 24, color: PdfColors.blue900),
                  ),
                  pw.Text(
                    'STOCK REPORT',
                    style: pw.TextStyle(font: fontBold, fontSize: 20, color: PdfColors.grey700),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Generated by: $creatorName', style: pw.TextStyle(font: font, fontSize: 10)),
                  pw.Text(
                    'Date: ${DateFormat.yMMMd().add_jm().format(DateTime.now())}',
                    style: pw.TextStyle(font: font, fontSize: 10),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Divider(thickness: 1, color: PdfColors.grey300),
              pw.SizedBox(height: 16),
            ],
          );
        },
        footer: (context) {
          return pw.Column(
            children: [
              pw.Divider(thickness: 1, color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Asset Steward - $orgName',
                    style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey600),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey600),
                  ),
                ],
              ),
            ],
          );
        },
        build: (pw.Context context) {
          final List<pw.Widget> elements = [];

          final keys = groupedAssets.keys.toList()..sort();

          for (final key in keys) {
            final group = groupedAssets[key]!;
            if (groupBy != ReportGroup.none) {
              elements.add(
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 16, bottom: 8),
                  child: pw.Text(
                    '${groupBy.name.titleCase}: $key',
                    style: pw.TextStyle(font: fontBold, fontSize: 14, color: PdfColors.blue800),
                  ),
                ),
              );
            }

            double groupValue = 0;
            int groupQty = 0;

            final List<List<dynamic>> data = [];
            for (final asset in group) {
              final qty = asset.quantity;
              final price = asset.purchasePrice;
              final val = qty * price;
              groupQty += qty;
              groupValue += val;
              overallTotalQty += qty;
              overallTotalValue += val;

              data.add([
                asset.name,
                if (showCode) asset.assetCode,
                if (showSerial) asset.serialNumber ?? '-',
                if (showCategory && groupBy != ReportGroup.category) asset.category?.name ?? '-',
                if (showDepartment && groupBy != ReportGroup.department) asset.department?.name ?? '-',
                if (showLocation && groupBy != ReportGroup.location) asset.location?.name ?? '-',
                if (showStatus && groupBy != ReportGroup.status) asset.status.name.titleCase,
                if (showQty) qty.toString(),
                if (showPrice) price.currency(),
                if (showQty && showPrice) val.currency(),
              ]);
            }

            if (groupBy != ReportGroup.none && (showQty || showPrice)) {
              final subtotalRow = List<dynamic>.filled(headers.length, '');
              subtotalRow[0] = pw.Text('SUBTOTAL', style: pw.TextStyle(font: fontBold, fontSize: 9));
              if (showQty) {
                subtotalRow[headers.indexOf('Qty')] = pw.Text(
                  groupQty.toString(),
                  style: pw.TextStyle(font: fontBold, fontSize: 9),
                );
              }
              if (showQty && showPrice) {
                subtotalRow[headers.indexOf('Total Value')] = pw.Text(
                  groupValue.currency(),
                  style: pw.TextStyle(font: fontBold, fontSize: 9),
                );
              }
              data.add(subtotalRow);
            }

            final Map<int, pw.TableColumnWidth> tableColumnWidths = {
              0: const pw.FlexColumnWidth(2.5),
              for (int i = 1; i < headers.length; i++) i: const pw.FlexColumnWidth(),
            };

            elements.add(
              pw.TableHelper.fromTextArray(
                headers: headers,
                data: data,
                columnWidths: tableColumnWidths,
                headerStyle: pw.TextStyle(font: fontBold, fontSize: 10, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.blue800),
                cellStyle: pw.TextStyle(font: font, fontSize: 9),
                cellPadding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  for (int i = 1; i < headers.length; i++) i: pw.Alignment.center,
                  if (showPrice) headers.indexOf('Unit Price'): pw.Alignment.centerRight,
                  if (showQty && showPrice) headers.indexOf('Total Value'): pw.Alignment.centerRight,
                },
              ),
            );
          }

          if (showQty || showPrice) {
            elements.add(pw.SizedBox(height: 24));

            final grandTotalRow = List<dynamic>.filled(headers.length, '');
            grandTotalRow[0] = pw.Text(
              'GRAND TOTAL',
              style: pw.TextStyle(font: fontBold, fontSize: 11, color: PdfColors.blue900),
            );
            if (showQty) {
              grandTotalRow[headers.indexOf('Qty')] = pw.Text(
                overallTotalQty.toString(),
                style: pw.TextStyle(font: fontBold, fontSize: 11),
              );
            }
            if (showQty && showPrice) {
              grandTotalRow[headers.indexOf('Total Value')] = pw.Text(
                overallTotalValue.currency(),
                style: pw.TextStyle(font: fontBold, fontSize: 11),
              );
            }

            final Map<int, pw.TableColumnWidth> tableColumnWidths = {
              0: const pw.FlexColumnWidth(2.5),
              for (int i = 1; i < headers.length; i++) i: const pw.FlexColumnWidth(),
            };

            elements.add(
              pw.Container(
                color: PdfColors.blue50,
                child: pw.Table(
                  columnWidths: tableColumnWidths,
                  children: [
                    pw.TableRow(
                      children: List.generate(grandTotalRow.length, (i) {
                        final cell = grandTotalRow[i];
                        pw.Alignment align = pw.Alignment.center;
                        if (i == 0) align = pw.Alignment.centerLeft;
                        if (showPrice && i == headers.indexOf('Unit Price')) align = pw.Alignment.centerRight;
                        if (showQty && showPrice && i == headers.indexOf('Total Value')) {
                          align = pw.Alignment.centerRight;
                        }
                        return pw.Container(
                          alignment: align,
                          padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                          child: cell is pw.Widget ? cell : pw.Text(cell.toString()),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }

          return elements;
        },
      ),
    );

    return await doc.save();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    final storage = di<KeyValueStorage>();

    final groupByState = useState(
      ReportGroup.values.tryByName(storage.getString(PrefsKey.reportGroupBy)) ?? ReportGroup.none,
    );
    final showCode = useState(storage.getBool(PrefsKey.reportShowCode) ?? true);
    final showSerial = useState(storage.getBool(PrefsKey.reportShowSerial) ?? false);
    final showCategory = useState(storage.getBool(PrefsKey.reportShowCategory) ?? true);
    final showDepartment = useState(storage.getBool(PrefsKey.reportShowDepartment) ?? true);
    final showLocation = useState(storage.getBool(PrefsKey.reportShowLocation) ?? true);
    final showStatus = useState(storage.getBool(PrefsKey.reportShowStatus) ?? true);
    final showQty = useState(storage.getBool(PrefsKey.reportShowQty) ?? true);
    final showPrice = useState(storage.getBool(PrefsKey.reportShowPrice) ?? true);

    useEffect(
      () {
        storage.saveString(PrefsKey.reportGroupBy, groupByState.value.name);
        storage.saveBool(PrefsKey.reportShowCode, showCode.value);
        storage.saveBool(PrefsKey.reportShowSerial, showSerial.value);
        storage.saveBool(PrefsKey.reportShowCategory, showCategory.value);
        storage.saveBool(PrefsKey.reportShowDepartment, showDepartment.value);
        storage.saveBool(PrefsKey.reportShowLocation, showLocation.value);
        storage.saveBool(PrefsKey.reportShowStatus, showStatus.value);
        storage.saveBool(PrefsKey.reportShowQty, showQty.value);
        storage.saveBool(PrefsKey.reportShowPrice, showPrice.value);
        return null;
      },
      [
        groupByState.value,
        showCode.value,
        showSerial.value,
        showCategory.value,
        showDepartment.value,
        showLocation.value,
        showStatus.value,
        showQty.value,
        showPrice.value,
      ],
    );

    final org = ref.watch(organizationCtrlProvider).value;
    final orgName = org?.name ?? 'Asset Steward';
    final profile = ref.watch(profileCtrlProvider).value;
    final creatorName = profile != null ? '${profile.firstname} ${profile.lastname}' : 'Admin';

    Future<Uint8List?> generateBytes() async {
      isLoading.value = true;
      try {
        final assets = await ref.read(assetsCtrlProvider().future);
        if (assets.isEmpty) {
          if (context.mounted) Toast.showError('No assets found for the report');
          return null;
        }
        return await _generatePdf(
          assets: assets,
          orgName: orgName,
          creatorName: creatorName,
          groupBy: groupByState.value,
          showCode: showCode.value,
          showSerial: showSerial.value,
          showCategory: showCategory.value,
          showDepartment: showDepartment.value,
          showLocation: showLocation.value,
          showStatus: showStatus.value,
          showQty: showQty.value,
          showPrice: showPrice.value,
        );
      } catch (e, s) {
        if (context.mounted) Toast.showError('Failed to generate report: $e');
        Chirp.error('Failed to generate report', error: e, stackTrace: s);
        return null;
      } finally {
        isLoading.value = false;
      }
    }

    void onDownload() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      final fileName = 'Stock_Report_${DateTime.now().toIso8601String().replaceAll(':', '-')}';

      if (context.mounted) context.pop();

      await FileStorageService.instance.saveAndPrompt(
        bytes: bytes,
        fileName: fileName,
        extension: 'pdf',
        mimeType: 'application/pdf',
        successMessage: 'Report saved successfully',
      );
    }

    void onPrint() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      await Printing.layoutPdf(onLayout: (_) async => bytes, name: 'Stock Report');
      if (context.mounted) context.pop();
    }

    void onShare() async {
      final bytes = await generateBytes();
      if (bytes == null) return;
      final fileName = 'Stock_Report_${DateTime.now().toIso8601String().replaceAll(':', '-')}';
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
                  const Icon(HIStroke.documentAttachment, size: 28),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Asset Stock Report',
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
              const Gap(12),

              Text('Grouping', style: context.text.titleMedium),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ReportGroup.values.map((g) {
                  return _ToggleChip(
                    label: g.name.titleCase,
                    value: groupByState.value == g,
                    onChanged: (v) {
                      if (v) groupByState.value = g;
                    },
                  );
                }).toList(),
              ),

              const Gap(16),
              Text('Columns to Include', style: context.text.titleMedium),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ToggleChip(label: 'Asset Code', value: showCode.value, onChanged: (v) => showCode.value = v),
                  _ToggleChip(label: 'Serial No.', value: showSerial.value, onChanged: (v) => showSerial.value = v),
                  _ToggleChip(label: 'Category', value: showCategory.value, onChanged: (v) => showCategory.value = v),
                  _ToggleChip(
                    label: 'Department',
                    value: showDepartment.value,
                    onChanged: (v) => showDepartment.value = v,
                  ),
                  _ToggleChip(label: 'Location', value: showLocation.value, onChanged: (v) => showLocation.value = v),
                  _ToggleChip(label: 'Status', value: showStatus.value, onChanged: (v) => showStatus.value = v),
                  _ToggleChip(label: 'Quantity', value: showQty.value, onChanged: (v) => showQty.value = v),
                  _ToggleChip(label: 'Unit Price', value: showPrice.value, onChanged: (v) => showPrice.value = v),
                ],
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

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleChip({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: value,
      onSelected: onChanged,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      selectedColor: context.colors.primaryContainer,
    );
  }
}
