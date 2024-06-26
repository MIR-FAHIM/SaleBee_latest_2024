
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:salebee_latest/models/auth/attendance/my_atten_report_by_month.dart';



Future<Uint8List> makePdf(
    MyAttenRepByMonthModel report, int month, int year, String name) async {
  final pdf = pw.Document();
  List<pw.Widget> widgets = [];
  widgets.add(pw.SizedBox(height: 5));
  var font = await PdfGoogleFonts.bangersRegular();
  final fontData = await rootBundle.load('images/font/Kalpurush.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

  widgets.add(
    Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(
                    "Printed on: ${DateFormat.yMd().format(DateTime.now())}," +
                        " ${DateFormat.jm().format(DateTime.now())}" +
                        " (printed by: )",
                    style: TextStyle(
                        fontWeight: pw.FontWeight.normal, fontSize: 8),
                  ),
                ]),
            SizedBox(height: 05),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nexzen Solution Ltd",
                    style:
                    TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "House: 545, 2nd floor, Suite A2, Road 8, Mirpur DOHS",
                    style: TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        pw.SizedBox(height: 05),
        Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                ),
                shape: BoxShape.rectangle),
            child: Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  Text("Attendance Sheet",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  PaddedText(
                      ""),
                ])),
        SizedBox(height: 05),
        Row(children: [
          Container(
              child: Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Employee Name: $name",
                    ),
                    //  Text(StaticData.designation),
                  ])),
          Spacer(),
        ]),
        pw.SizedBox(height: 20),
      ],
    ),
  );
  widgets.add(
    Table(
      border: TableBorder.all(color: PdfColors.black),
      children: [
        TableRow(
          children: [
            Padding(
              child: Text('Date',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Check In',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Check Out',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
            // Padding(
            //   child: Text(
            //     'In Time',
            //
            //     textAlign: TextAlign.center,
            //   ),
            //   padding: EdgeInsets.all(20),
            // ),

            Padding(
              child: Center(
                child: Text('Working Hour',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: pw.TextStyle(fontSize: 8)),
              ),
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              child: Text('Note',
                  textAlign: TextAlign.center,
                  style: pw.TextStyle(fontSize: 8)),
              padding: EdgeInsets.only(top: 10),
            ),
          ],
        ),
        ...report.result!.where((element) => element.logTimeIn.year == year && element.logTimeIn.month == month).map(
              (e) {



              return TableRow(
                children: [
                  Expanded(
                    child: PaddedText(
                        "${DateFormat('EEEE').format(e.createdOn!).toString().substring(0, 3) + ","} ${e.createdOn.toString().substring(8, 10)}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(children: [
                      PaddedText(
                          "${DateFormat.jm().format(e.logTimeIn!)}"),
                      Text(e.locationDescription.toString(),
                          style: pw.TextStyle(font: ttf, fontSize: 8)),
                    ]),
                    flex: 2,
                  ),

                  Expanded(
                    child: e.logTimeOut != null
                        ? Column(children: [
                      PaddedText(
                          "${DateFormat.jm().format(e.logTimeOut!)}"),
                      Text(e.locationDescriptionOut.toString(),
                          style: pw.TextStyle(font: ttf, fontSize: 8)),
                    ])
                        : Column(children: [
                      PaddedText(
                          "${DateFormat.jm().format(e.logTimeIn!)}"),
                      Text(e.locationDescription.toString(),
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 8,
                          )),
                    ]),
                    flex: 2,
                  ),
                  // Expanded(
                  //   child: int.parse(e.logTimeIn.substring(11,12)) < 10 ?
                  //   PaddedText(int.parse(e.logTimeIn.substring(11,13)).toString()) : PaddedText("No"),
                  //   flex: 1,
                  // ),
                  Expanded(
                    child:  PaddedText("No Data"),

                    flex: 1,
                  ),
                  Expanded(
                    child: PaddedText(e.checkOutNote ?? "No data"),
                    flex: 1,
                  ),
                ],
              );
            }

        ),
        TableRow(
          children: [
            PaddedText('TOTAL', align: TextAlign.right),
            PaddedText(''),
            PaddedText(''),
            PaddedText(""),
            // '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
          ],
        )
      ],
    ),
  );
  widgets.add(
    pw.SizedBox(height: 60),
  );
  widgets
      .add(Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("User Signature & Date"),
      pw.SizedBox(width: 10),
    ]),
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("Admin Checked"),
      pw.SizedBox(width: 10),
    ]),
    Column(children: [
      Container(
        width: 100,
        child: Divider(thickness: 1),
      ),
      Text("Approved by"),
      pw.SizedBox(width: 10),
    ]),
  ]));

  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    pw.MultiPage(build: (context) {
      return widgets;
    }),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(2),
      child: Text(text, textAlign: align, style: pw.TextStyle(fontSize: 8)),
    );
