import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';

import 'package:salebee_latest/modules/attendance/controller/attendance_controller.dart';
import 'package:salebee_latest/modules/attendance/view/pdf/pdf_preview.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';

import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class EmpByMonthReportTable extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            DefaultTabController(
              initialIndex: controller.monthSelection.value - 1,
              length: 12,
              child: Container(
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 70,
                        child: DropdownButton<String>(
                          value: controller.dropdownValue.value,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.

                            controller.dropdownValue.value = value!;
                            controller.yearSelection.value =
                                int.parse(controller.dropdownValue.value);
                          },
                          items: controller.yearList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: DefaultTabController(
                        initialIndex: controller.monthSelection.value - 1,
                        length: 12,
                        child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.textColorGreen.withOpacity(.5)),
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          onTap: (index) {
                            controller.monthSelection.value = index + 1;
                          },
                          tabs: controller.tabs
                              .map((tab) => Tab(
                            icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                tab,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Check IN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Check Out',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Working Hour',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),

            Container(
              height: Get.height *.7,
              child: ListView.builder(
                  itemCount: controller.myAttenReportByModel.value.result!.where((element) => element.logTimeIn.year == controller.yearSelection.value && element.logTimeIn.month == controller.monthSelection.value).length,
                  itemBuilder:

                      (BuildContext context, index) {
                    var data = controller.myAttenReportByModel.value.result!.where((element) => element.logTimeIn.year == controller.yearSelection.value && element.logTimeIn.month == controller.monthSelection.value).toList()[index];

                    return Card(
                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                    Colors.blue,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        6)),
                                width: 30,
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      4.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                      Center(
                                        child: Text(
                                          data.logTimeIn
                                              .toString()
                                              .substring(
                                              8,
                                              10),
                                          textAlign:
                                          TextAlign
                                              .center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat(
                                            'EEEE')
                                            .format(data.logTimeIn)
                                            .toString()
                                            .substring(
                                            0, 3),
                                        textAlign:
                                        TextAlign
                                            .center,
                                        style:
                                        TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: 80,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    Text(

                                      DateFormat.jm()
                                          .format(data.logTimeIn!),
                                      style: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Get.toNamed(Routes.MAPVIEW, arguments: [data.latitude, data.longitude]);
                                      },
                                      child: Text(

                                        data.locationDescription
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 8),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                                width: 80,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    data.logTimeOut ==
                                        DateTime.parse("2024-03-07T09:06:13.489Z")
                                        ? Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                          FontWeight.w600),
                                    )
                                        : Text(
                                      DateFormat.jm()
                                          .format(data.logTimeOut!) ??
                                          "",
                                      style: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                          FontWeight.w600),
                                    ),
                                    data.locationDescriptionOut ==
                                        null
                                        ? Text(
                                      "No Data",
                                      style: TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                          FontWeight
                                              .w600,
                                          fontSize:
                                          8),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.MAPVIEW, arguments: [data.latitude, data.longitude]);
                                      },
                                      child: Text(
                                        data.locationDescriptionOut
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                            Colors.blue,
                                            fontWeight: FontWeight
                                                .w600,
                                            fontSize:
                                            8),
                                      ),
                                    )
                                  ],
                                )),

                            Container(
                              width: 80,
                              child:
                              data.logTimeOut == DateTime.parse("2024-03-07T09:06:13.489Z") ? Text("did not checkout"):
                              Text(
                                controller.duration(data.logTimeIn.toString(), data.logTimeOut.toString()),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),



                          ]),
                    );

                  }


              ),),
            GestureDetector(
              onTap: () async {
                    Get.to(PdfPreviewPage(report: controller.myAttenReportByModel.value,
                      year: controller.yearSelection.value ,
                      month: controller.monthSelection.value,
                      name: Get.arguments[0]
                    ));
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Center(
                    child: Text(
                      "Generate PDF".tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ).paddingSymmetric(vertical: 5, horizontal: 20),
            ),
          ],
        );
      }),
    );
  }
}
//
