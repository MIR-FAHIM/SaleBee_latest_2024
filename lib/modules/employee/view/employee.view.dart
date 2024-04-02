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

class EmployeeListView extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Employee"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: Get.height * .8,
                child: controller.filteredEmpList.isEmpty
                    ? Text("Loading.....")
                    : ListView.builder(
                        itemCount: controller.filteredEmpList.length,
                        itemBuilder: (context, index) {
                          var data = controller.filteredEmpList[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: data.profilePicturePath == null ? CircleAvatar(
                                                radius: 25,
                                                child: Icon(Icons.verified_user)): CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                ApiUrl.mainUrl +
                                                    data.profilePicturePath,
                                              ),
                                            ),
                                            title: Text(data.employeeName!),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                data.departmentObj == null
                                                    ? Text("No data")
                                                    : Text(data.departmentObj!
                                                        .departmentName!),
                                                data.designationObj == null
                                                    ? Text("No data")
                                                    : Text(data.designationObj!
                                                        .designationName!),
                                              ],
                                            ),
                                            // trailing: Container(
                                            //   width: 100,
                                            //   child: Row(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment
                                            //             .end,
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.end,
                                            //     children: [
                                            //       Icon(Icons.call),
                                            //       Icon(Icons.mail),
                                            //     ],
                                            //   ),
                                            // ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              InkWell(
                                                splashColor: Colors.blue,
                                                onTap: () {
                                                  controller.textMe(data.phoneNumbers!.split(","));
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
                                                      data.phoneNumbers!.split(",")[0]);
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
                                                  controller.launchWhatsapp(data.phoneNumbers!.split(",")[0]);
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
                                                      child: Image(
                                                        height: 25,
                                                        width: 25,
                                                        image: AssetImage("images/Icons/whatsapp.png"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ));
    });
  }
}
//
