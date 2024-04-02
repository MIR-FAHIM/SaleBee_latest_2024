import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class VisitListByProspectView extends GetView<VisitController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
var id = Get.arguments[0];
var name = Get.arguments[1];
    return Obx(() {
      
      return Scaffold(
        appBar: AppBar(
          title: Text("Visit list of $name"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),

              Container(
                height: Get.height * .67,
                child: controller.getEmpVisit.where((p) => p.prospectId == id).toList().isEmpty
                    ? Text("No Visit found of $name")
                    : ListView.builder(
                    itemCount: controller.getEmpVisit
                        .where((p) =>
                    p.prospectId == id )
                        .length,
                    itemBuilder: (context, index) {
                      var visitData = controller.getEmpVisit
                          .where((p) =>
                      p.prospectId == id )
                          .toList()[index];
                      return ExpandableNotifier(
                        child: Stack(
                          children: [
                            Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: AppColors.greenButton
                                                    .withOpacity(.3),
                                                borderRadius:
                                                BorderRadius.circular(6)),
                                            width: 100,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 4.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      visitData.locationTime ==
                                                          null
                                                          ? Text(
                                                        "No data",
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      )
                                                          : Text(
                                                        DateFormat('EEEE')
                                                            .format(visitData
                                                            .locationTime!)
                                                            .toString()
                                                            .substring(
                                                            0,
                                                            3) +
                                                            ",",
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
//"LogTimeIn":"2022-09-13T08:36:40.32"

                                                      Center(
                                                        child: visitData
                                                            .locationTime ==
                                                            null
                                                            ? Text(
                                                          "No Data",
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                          style:
                                                          TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        )
                                                            : Text(
                                                          " " +
                                                              visitData
                                                                  .locationTime!
                                                                  .toString()
                                                                  .substring(
                                                                  8,
                                                                  10),
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                          style:
                                                          TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      visitData.locationTime ==
                                                          null
                                                          ? Text("No data")
                                                          : Text(
                                                        DateFormat('MMM')
                                                            .format(visitData
                                                            .locationTime!)
                                                            .toString()
                                                            .substring(
                                                            0, 3),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        visitData.locationTime ==
                                                            null
                                                            ? Text("No data")
                                                            : Text(
                                                          DateFormat.jm()
                                                              .format(visitData
                                                              .locationTime!),
                                                          style: TextStyle(
                                                              fontSize:
                                                              10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        SizedBox(
                                          width: 05,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              visitData.prospectName == null
                                                  ? Text(
                                                "No Data",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              )
                                                  : Text(
                                                visitData.prospectName!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              // Container(
                                              //   height: 25,
                                              //   width: MediaQuery.of(context).size.width * .6,
                                              //   child: Text(
                                              //
                                              //     getProspectAdrs(
                                              //         visitData
                                              //             .prospectId!,
                                              //         StaticData
                                              //             .prosepctList),
                                              //     style: TextStyle(
                                              //       fontSize: 10,
                                              //       color: Colors
                                              //           .black54,
                                              //     ),
                                              //     maxLines: 2,
                                              //   ),
                                              // ),
                                              Container(
                                                  height: 5,
                                                  width: 200,
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  )),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Visted by: ",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${visitData.employeeName}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Address: ",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        .5,
                                                    child: Center(
                                                      child: InkWell(
                                                        onTap: () {
                                                          print(
                                                              "my lat lon are ${visitData.latitude}and ${visitData.longitude}");
                                                          Get.toNamed(
                                                              Routes.MAPVIEW,
                                                              arguments: [
                                                                visitData
                                                                    .latitude,
                                                                visitData
                                                                    .longitude
                                                              ]);
                                                        },
                                                        child: Text(
                                                          maxLines: 2,
                                                          visitData
                                                              .locationDescription!,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                              Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
//
