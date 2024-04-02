import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:salebee_latest/modules/attendance/controller/attendance_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';

import 'package:salebee_latest/utils/AppColors/app_colors.dart';


class AllDailyAttendanceReportView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
            () {
          return SingleChildScrollView(
            child: Column(
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
                              icon:
                              Icon(Icons.arrow_drop_down_outlined),
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.deepPurple),
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
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.width - 150,
                          child: DefaultTabController(
                            initialIndex: controller.monthSelection.value - 1,
                            length: 12,
                            child: TabBar(
                              indicator: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: AppColors.textColorGreen
                                      .withOpacity(.5)),
                              isScrollable: true,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              onTap: (index) {

                                controller.monthSelection.value = index + 1;

                              },
                              tabs: controller.tabs
                                  .map((tab) => Tab(
                                icon: Padding(
                                  padding:
                                  const EdgeInsets.all(4.0),
                                  child: Text(
                                    tab,
                                    style:
                                    TextStyle(fontSize: 12),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: DefaultTabController(
                    initialIndex: controller.daySelection.value - 1,
                    length: 31,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.black38,
                          labelColor: Colors.black,
                          onTap: (index) {

                            controller.daySelection.value = index + 1;

                            controller.getAllDaillyEmpAttendance(DateTime(DateTime.now().year,  controller.monthSelection.value,   controller.daySelection.value,));

                          },
                          tabs: controller.dayTab.value
                              .map((tab) => Tab(
                            icon: Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Text(
                                tab.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultTabController(
                    length: 2,
                    child: Container(
                      height: Get.height*.68,
                      color: AppColors.backgroundColor,
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: TabBar(
                                    indicatorColor: AppColors.colorBlue,
                                    labelColor: AppColors.colorBlue,
                                    unselectedLabelColor: Colors.grey,
                                    isScrollable: true,
                                    labelStyle: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w600),
                                    unselectedLabelStyle: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w400),
                                    tabs: [

                                      Tab(
                                        text:
                                        'Present(${controller.attendanceModeAllEmp.value.result!.length.toString()})',
                                      ),
                                      Tab(
                                        text:
                                        'Absent(${controller.absentList.length.toString()})',
                                      ),

                                    ],
                                  ),
                                ),
                                // Expanded(child: Container())
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(children: [

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height - 300,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Name',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Check IN',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  'Check Out',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  'Working Hour',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        height: Get.height *.55,
                                        child: ListView.builder(
                                            itemCount: controller.attendanceModeAllEmp.value.result!.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var data = controller.attendanceModeAllEmp.value.result![index];

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
                                                              Colors.green.withOpacity(.3),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6)),
                                                          width: Get.width *.2,
                                                          child:
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0),
                                                            child:
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  data.employeeName!,
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontSize: 10,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black),
                                                                ),

                                                              ],
                                                            ),
                                                          )),
                                                      Container(
                                                          width: Get.width *.2,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                DateFormat.jm()
                                                                    .format(data.logTimeIn!),
                                                                style: TextStyle(
                                                                    color: 10 > int.parse(DateFormat('HH:mm:ss').format(data.logTimeIn!).substring(0, 2))
                                                                        ? Colors.grey
                                                                        : Colors.red,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                              InkWell(
                                                                onTap: (){
                                                                  Get.toNamed(Routes.MAPVIEW, arguments: [data.latitude, data.longitude]);
                                                                },

                                                                child: Text(
                                                                  data.locationDescription
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                      Colors.blue.withOpacity(.8),
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 8),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      Container(
                                                          width: Get.width*.2,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              data.logTimeOut ==
                                                                  null
                                                                  ? Text(
                                                                "",
                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                              )
                                                                  : Text(
                                                                DateFormat.jm().format(DateTime.parse(data.logTimeOut)) ?? "",
                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                                                              ),
                                                              data.locationDescriptionOut ==
                                                                  null
                                                                  ? Text(
                                                                "No Data",
                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 8),
                                                              )
                                                                  : InkWell(
                                                                onTap:(){
                                                                  Get.toNamed(Routes.MAPVIEW, arguments: [data.latitudeOut, data.longitudeOut]); // Get.to(AttendanceMapScreen(lat:  data.latitudeOut, lon: data.longitudeOut, location: data.locationDescriptionOut, time: DateTime.parse(data.logTimeOut) ,));

                                                                },
                                                                child: Text(
                                                                  data.locationDescriptionOut.toString(),
                                                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 8),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      Container(
                                                          width: 80,
                                                          child:  Center(
                                                            child: Text(
                                                              controller.duration(data.logTimeIn.toString(), data.logTimeOut),
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.grey,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          )

                                                      ),
                                                    ]),
                                              );
                                            }


                                        ),)
                                    ],
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child:  Container(
                                  height: MediaQuery.of(context).size.height - 300,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Name',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Designation',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  'On Leave',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                Text(
                                                  'Contact',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        height: Get.height *.55,
                                        child: ListView.builder(
                                            itemCount: controller.absentList.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              var data = controller.absentList[index];

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
                                                              Colors.green.withOpacity(.3),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6)),
                                                          width: Get.width*.18,
                                                          child:
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.0),
                                                            child:
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  data.name!,
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black),
                                                                ),

                                                              ],
                                                            ),
                                                          )),
                                                      Container(
                                                          width: Get.width *.3,
                                                          child: Center(child: Text(data.designation!, style: TextStyle(fontSize: 12),))),
                                                      Container(
                                                          width:  Get.width *.2,
                                                          child: Text("On Leave", style: TextStyle(fontSize: 12))),
                                                      Container(
                                                          width:  Get.width *.1,
                                                          child: Icon(Icons.phone)

                                                      ),
                                                    ]),
                                              );
                                            }


                                        ),)
                                    ],
                                  ),
                                ),
                              ),

                            ]),
                          ),
                        ],
                      ),
                    )),






              ],
            ),
          );
        }
    );

  }
}
//
