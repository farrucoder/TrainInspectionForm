import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';
import 'package:trainformforinspection/Utils/pdf-Generator.dart';


class PreviewPage extends StatelessWidget{

  PreviewPage({super.key, required this.data});

  final Trainmodel data;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PdfPreview(build: (formate) {
        return PdfGenerator.generatePdf(data);
      },
        allowPrinting: true,
        allowSharing: true,
      ),
    );
  }
}
