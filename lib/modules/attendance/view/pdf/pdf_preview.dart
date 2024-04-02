import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:salebee_latest/models/auth/attendance/my_atten_report_by_month.dart';
import 'package:salebee_latest/modules/attendance/view/pdf/make_pdf.dart';




class PdfPreviewPage extends StatelessWidget {
  final MyAttenRepByMonthModel? report;
  final int year;
  final int month;
  final String name;


  PdfPreviewPage({Key? key, required this.report, required this.month, required this.year, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text('PDF Previeww'),
    ),
    body: PdfPreview(
    build: (context) => makePdf(report!,month, year, name),
    ),
    );
  }

}