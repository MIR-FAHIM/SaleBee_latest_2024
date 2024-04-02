import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/lead/controller/lead_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class MyLeadView extends GetView<LeadController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 10,
                ),


                Container(
                  height: Get.height *.1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.getStatus.length,
                      itemBuilder: (context, i){
                        var status = controller.getStatus[i];
                        return GestureDetector(
                          onTap: () {


                            controller.setSearchText(status.status, "status");
                          },
                          child: Card(
                            child: Container(
                                height: Get.height * .08,
                                decoration: BoxDecoration(
                                    color: HexColor(status.funnelColor),
                                    borderRadius: BorderRadius.circular(6)),
                                width: Get.width * .16,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        status.status!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                      Card(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.getLeadList
                                                  .where((v) => v.stageName == status.status)
                                                  .length
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),


                SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height * .68,
                  child: controller.filteredLeadList.isEmpty
                      ? Text("So many lead . Loading.....")
                      : ListView.builder(
                      itemCount: controller.filteredLeadList.length,
                      itemBuilder: (context, index) {
                        var data = controller.filteredLeadList[index];
                        return  Card(
                          child: ExpandableNotifier(
                            child: InkWell(
                              onTap: () {
                               // Get.toNamed(Routes.PROSPECTVIEWDETAIL, arguments: [data]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(6),
                                    color: const Color(0xFFFFFFFF)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            'Lead Id -${data.leadId.toString()}',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w700,
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              DateFormat.yMMM().format(data.createdDate!),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ],
                                      ),
                                      ListTile(
                                          trailing: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.greenButton,
                                                    width: 1),
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        10.0))),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text("Stage:",
                                                    // getStage(data.stage!),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontSize: 12,
                                                        color:
                                                        Colors.black54),
                                                  ),
                                                  Text(data.stageName!,
                                                    // getStage(data.stage!),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontSize: 12,
                                                        color:
                                                        Colors.black54),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            data.leadName!,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w700,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),),
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(
                                          theme:
                                          const ExpandableThemeData(
                                            headerAlignment:
                                            ExpandablePanelHeaderAlignment
                                                .center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Row(
                                            children: [
                                              const Text(
                                                'Pick Any',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  controller.textMe(data.concernPerson![0].mobile!.toString());
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.chat,
                                                        color:
                                                        AppColors.textColorGreen,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  controller.launchPhoneDialer(
                                                      data.concernPerson![0].mobile!.toString());
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.call,
                                                        color:
                                                        AppColors.greenButton,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  controller.launchWhatsapp(data.concernPerson![0].mobile!.toString());
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          100)),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Icon(
                                                        Icons.messenger,
                                                        color:
                                                        AppColors.greenButton,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Card(
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        100)),
                                                child: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                      shape: BoxShape
                                                          .circle),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Icon(
                                                      Icons.more_horiz,
                                                      color: AppColors.greenButton,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          collapsed: const SizedBox(
                                            height: 10,
                                          ),
                                          expanded: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Get.width*.25,
                                                      child: Text("Assign to:")),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                    const BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child:
                                                    const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage:
                                                      AssetImage(
                                                        'images/suite.png',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(Get.find<EmployeeController>().getEmployeeNameById(data.assignedTo),
                                                    style: TextStyle(
                                                        color:
                                                        Colors.grey,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * .25,
                                                      child: Text("Created by:")),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                    const BoxDecoration(
                                                        shape: BoxShape
                                                            .circle),
                                                    child:
                                                    const CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage:
                                                      AssetImage(
                                                        'images/suite.png',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(data.createdByName!,
                                                    style: TextStyle(
                                                        color:
                                                        Colors.grey,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Action',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                        //  controller.addVisitController(data.id, data.prospectName);
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  100)),
                                                          child:
                                                          Container(
                                                            decoration:
                                                            BoxDecoration(
                                                                shape:
                                                                BoxShape.circle),
                                                            child:
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: Text(
                                                                "Add Visit",
                                                                style:
                                                                TextStyle(
                                                                  color:
                                                                  AppColors.colorBlue,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                100)),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                8.0),
                                                            child: Icon(
                                                              Icons.edit,
                                                              color:
                                                              AppColors.greenButton,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                100)),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .delete,
                                                              color: Colors
                                                                  .red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Container()
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ));
    });
  }
}
//
