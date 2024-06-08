import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart'; // For kIsWeb
import '../classes/subscription_class.dart';

class ExportService {
  static Future<void> exportToCSV(List<Subscription> data, String fileName) async {
    List<List<dynamic>> rows = [
      ["Name", "IP", "NAS", "MAC", "Plan", "Status"]
    ];

    for (var subscription in data) {
      List<dynamic> row = [];
      row.add(subscription.name);
      row.add(subscription.lastCon.ip);
      row.add(subscription.lastCon.nas);
      row.add(subscription.macAdd);
      row.add(subscription.plan.name);
      row.add(subscription.isDisconnected ? 'Disconnected' : subscription.isTerminated ? 'Terminated' : 'Connected');
      rows.add(row);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      final bytes = utf8.encode(csvData);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName.csv';
      final File file = File(path);
      await file.writeAsString(csvData);
    }
  }

  static Future<void> exportToExcel(List<Subscription> data, String fileName) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    sheetObject.appendRow([
      TextCellValue("Name"),
      TextCellValue("IP"),
      TextCellValue("NAS"),
      TextCellValue("MAC"),
      TextCellValue("Plan"),
      TextCellValue("Status")
    ]);

    for (var subscription in data) {
      List<CellValue> row = [];
      row.add(TextCellValue(subscription.name));
      row.add(TextCellValue(subscription.lastCon.ip));
      row.add(TextCellValue(subscription.lastCon.nas));
      row.add(TextCellValue(subscription.macAdd));
      row.add(TextCellValue(subscription.plan.name));
      row.add(TextCellValue(subscription.isDisconnected ? 'Disconnected' : subscription.isTerminated ? 'Terminated' : 'Connected'));
      sheetObject.appendRow(row);
    }

    if (kIsWeb) {
      final bytes = excel.encode()!;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.xlsx")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName.xlsx';
      final File file = File(path);
      await file.writeAsBytes(excel.encode()!);
    }
  }

  static Future<void> exportToPDF(List<Subscription> data, String fileName) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: ["Name", "IP", "NAS", "MAC", "Plan", "Status"],
            data: data.map((subscription) {
              return [
                subscription.name,
                subscription.lastCon.ip,
                subscription.lastCon.nas,
                subscription.macAdd,
                subscription.plan.name,
                subscription.isDisconnected ? 'Disconnected' : subscription.isTerminated ? 'Terminated' : 'Connected'
              ];
            }).toList(),
            cellStyle: pw.TextStyle(font: font, fontSize: 10),
            headerStyle: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 12),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellHeight: 30,
            cellAlignment: pw.Alignment.centerLeft,
            headerHeight: 40,
          );
        },
      ),
    );

    if (kIsWeb) {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.pdf")
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName.pdf';
      final File file = File(path);
      await file.writeAsBytes(await pdf.save());
    }
  }
}
