import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:trainformforinspection/Utils/Parameter-Constant-List.dart';
import '../Models/Train-Model.dart';

class PdfGenerator {
  static Future<Uint8List> generatePdf(Trainmodel data) async {
    final pdf = pw.Document();
    final parameterList = ParameterConstantList.parametersList;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [

         pw.Center(child:  pw.Text('Train Inspection Summary', style: pw.TextStyle(fontSize: 22)),),

          pw.SizedBox(height: 50),
          pw.Row(
            children: [
              pw.Text('Station Name:',style: pw.TextStyle(fontSize: 17,fontWeight: pw.FontWeight.bold)),
              pw.Text(data.stationName,style: pw.TextStyle(fontSize: 15)),
            ]
          ),
          pw.SizedBox(height: 10),
          pw.Row(
              children: [
                pw.Text('Date:',style: pw.TextStyle(fontSize: 17,fontWeight: pw.FontWeight.bold)),
                pw.Text(data.date,style: pw.TextStyle(fontSize: 15)),
              ]
          ),

          pw.SizedBox(height: 16),

          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
            columnWidths: {
              0: pw.FixedColumnWidth(60),
              for (int i = 1; i <= parameterList.length; i++) i: pw.FixedColumnWidth(90),
            },
            children: [
              // Table Header
              pw.TableRow(
                children: [
                  pw.Container(
                    height: 50,
                    alignment: pw.Alignment.center,
                    color: PdfColors.green400,
                    child: pw.Text('Coach', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  ...parameterList.map(
                        (p) => pw.Container(
                          height: 50,
                      color: PdfColors.green400,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        p,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              // Data Rows
              ...data.coachWiseCleanlinesParameter.entries.map((coachEntry) {
                final coach = coachEntry.key;
                final paramData = coachEntry.value;

                return pw.TableRow(
                  children: [
                    pw.Container(
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(
                        coach,
                        style: pw.TextStyle(fontSize: 13, color: PdfColors.blue),
                      ),
                    ),
                    ...parameterList.map((p) {
                      final score = paramData[p]?.score.toString() ?? '-';
                      final remark = paramData[p]?.remark ?? '-';

                      return pw.Container(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Score: $score", style: pw.TextStyle(fontSize: 12)),
                            pw.SizedBox(height: 3),
                            pw.Text("Remark: $remark", style: pw.TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
