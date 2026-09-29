
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';

Future<void> generateLabelPdf(List<AssetLabelResponse> labels, String orgName, double pdfWidth) async {
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
              final qrData = jsonEncode({
                'id': label.id,
                'name': label.name,
                'assetCode': label.assetCode,
              });

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
                    pw.BarcodeWidget(
                      barcode: pw.Barcode.qrCode(),
                      data: qrData,
                      width: 100,
                      height: 100,
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      label.assetCode,
                      style: pw.TextStyle(font: fontBold, fontSize: 12),
                      textAlign: pw.TextAlign.center,
                    ),
                    if (label.expireDate != null) ...[
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Exp: ',
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

  await Printing.sharePdf(bytes: bytes, filename: 'asset_labels.pdf');
}

