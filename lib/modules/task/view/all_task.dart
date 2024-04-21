import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/models/auth/task/task_type_mpdel.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class AllTaskView extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ADDTASK);
            },
            child: Icon(Icons.add),
          ),
          body: Column(
            children: [
              DefaultTabController(
                initialIndex: controller.monthSelection.value - 1,
                length: 12,
                child: Container(
                  height: 30,
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8),
                      //   child: Container(
                      //     width: 70,
                      //     child: DropdownButton<String>(
                      //       value: controller.dropdownValue.value,
                      //       isExpanded: true,
                      //       icon:
                      //       Icon(Icons.arrow_drop_down_outlined),
                      //       elevation: 16,
                      //       style: const TextStyle(
                      //           color: Colors.deepPurple),
                      //       underline: Container(
                      //         height: 2,
                      //         color: Colors.transparent,
                      //       ),
                      //       onChanged: (String? value) {
                      //         // This is called when the user selects an item.
                      //
                      //         controller.dropdownValue.value = value!;
                      //         controller.yearSelection.value =
                      //             int.parse(controller.dropdownValue.value);
                      //
                      //       },
                      //       items: controller.yearList
                      //           .map<DropdownMenuItem<String>>(
                      //               (String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(value),
                      //             );
                      //           }).toList(),
                      //     ),
                      //   ),
                      // ),

                      Container(
                        width: Get.width * .9,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.dateFilterList.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                controller.selectDateFil.value = i;
                                controller.lastDate.value =
                                    controller.dateFilterList[i].lastDate;
                                controller.toDate.value =
                                    controller.dateFilterList[i].toDate;
                                controller.getAllTaskController();
                              },
                              child: Card(
                                child: Container(
                                  color: controller.selectDateFil.value == i
                                      ? Colors.blue
                                      : Colors.white,
                                  height: 25,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      controller.dateFilterList[i].name,
                                      style: TextStyle(
                                          color:
                                              controller.selectDateFil.value ==
                                                      i
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: Get.height * .1,
                width: Get.width * .9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.statuses.length,
                  itemBuilder: (context, i) {
                    var data = controller.statuses[i];
                    return Obx(() {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            controller.selectedStatus.value = i;
                            controller.stausID.value =
                                controller.statuses[i].id;
                            controller.getAllTaskController();
                          },
                          child: Container(
                              height: Get.height * .06,
                              decoration: BoxDecoration(
                                  color: controller.selectedStatus.value == i
                                      ? Colors.blue
                                      : Colors.blue.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(6)),
                              width: Get.width * .12,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.statuses[i].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.allTaskList
                                                .where((v) =>
                                                    v.statusId == data.id)
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
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: Get.width * .4,
                    color: Colors.white,
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: Get.find<EmployeeController>()
                          .empList
                          .map((item) => item.employeeName!)
                          .toList(),
                      onChanged: (input) {
                        for (var item
                            in Get.find<EmployeeController>().empList) {
                          if (item.employeeName == input) {
                            controller.empId.value = item.employeeId!;
                            controller.getAllTaskController();
                          }
                        }
                      },
                      selectedItem: "Assigned Person",
                    ),
                  ),
                  Container(
                    height: Get.height * .08,
                    width: Get.width * .53,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.getTaskType.length,
                      itemBuilder: (context, i) {
                        var data = controller.getTaskType[i];
                        return Card(
                          child: InkWell(
                            onTap: () {
                              controller.selectedType.value = i;
                              controller.taskType.value =
                                  controller.getTaskType[i].id;
                              controller.getAllTaskController();
                            },
                            child: Container(
                                height: Get.height * .04,
                                width: Get.width * .15,
                                decoration: BoxDecoration(
                                    color: controller.selectedType.value == i
                                        ? Colors.blue
                                        : Colors.blue.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.getTaskType[i].type,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.allTaskList
                                                  .where(
                                                      (v) => v.type == data.id)
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
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: Get.height * .55,
                child: controller.filteredAllTaskList.isEmpty
                    ? Text("No Task Found")
                    : ListView.builder(
                        itemCount: controller.filteredAllTaskList.length,
                        itemBuilder: (context, index) {
                          var data =
                              controller.filteredAllTaskList.toList()[index];
                          return Obx(() {
                            return ExpandableNotifier(
                              child: Stack(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 02,
                                          color: data.statusId == 5
                                              ? Colors.greenAccent
                                              : data.statusId == 11
                                                  ? Colors.red
                                                  : data.statusId == 1
                                                      ? Colors.redAccent
                                                          .withOpacity(.5)
                                                      : data.statusId == 4
                                                          ? Colors.blue
                                                          : Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Task Id: ${data.taskId}",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                DateFormat.yMd()
                                                    .format(data.createdOn!),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${data.title!}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          data.prospectName == null
                                              ? Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                )
                                              : Text(
                                                  "${data.prospectName!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black54,
                                                      fontSize: 12),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data.taskDesc!,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // print(
                                                  //     "tapped11");
                                                  // Add2Calendar
                                                  //     .addEvent2Cal(
                                                  //   buildEvent(
                                                  //       title: data
                                                  //           .title,
                                                  //       description:
                                                  //       data.taskDesc),
                                                  // );
                                                },
                                                child: Container(
                                                    height: 52,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue
                                                            .withOpacity(.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                    width: 100,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 4.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                DateFormat('EEEE')
                                                                        .format(data
                                                                            .dueDate!)
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            3) +
                                                                    ",",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                              Center(
                                                                child: Text(
                                                                  " " +
                                                                      data.dueDate
                                                                          .toString()
                                                                          .substring(
                                                                              8,
                                                                              10),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              Text(DateFormat(
                                                                      'MMM')
                                                                  .format(data
                                                                      .dueDate!)
                                                                  .toString()
                                                                  .substring(
                                                                      0, 3)),
                                                            ],
                                                          ),
                                                          Card(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  DateFormat
                                                                          .jm()
                                                                      .format(data
                                                                          .dueDate!),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              Spacer(),
                                              Text(
                                                "You have ${data.dueDate!.difference(DateTime.now()).inDays} days",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          data.contactPersonDetails == null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Prospect: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {},
                                                            child: Text(
                                                              "${data.prospectName}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    data.leadName == null ||
                                                            data.leadName == ""
                                                        ? Container()
                                                        : Row(
                                                            children: [
                                                              Text(
                                                                "Lead:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4.1,
                                                                child:
                                                                    data.leadName ==
                                                                            null
                                                                        ? Text(
                                                                            "No Data",
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black54,
                                                                                fontWeight: FontWeight.normal),
                                                                          )
                                                                        : Text(
                                                                            "${data.leadName}",
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.black54,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                              ),
                                                            ],
                                                          ),
                                                  ],
                                                )
                                              : Card(
                                                  elevation: 5,
                                                  color:
                                                      data.contactPersonDetails ==
                                                              null
                                                          ? Colors.white
                                                          : AppColors
                                                              .greenButton,
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Prospect:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.5,
                                                                  child: Text(
                                                                    "${data.prospectName}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Lead:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4.1,
                                                                  child: data.leadName ==
                                                                          null
                                                                      ? Text(
                                                                          "No Data",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black54,
                                                                              fontWeight: FontWeight.normal),
                                                                        )
                                                                      : Text(
                                                                          "${data.leadName}",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black54,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        data.contactPersonDetails ==
                                                                null
                                                            ? Container()
                                                            : Container(
                                                                child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 20,
                                                                    color: Colors
                                                                        .blue,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 4,
                                                                          child:
                                                                              Text(
                                                                            "Contact person",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 4,
                                                                          child:
                                                                              Text(
                                                                            "Designation",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 4,
                                                                          child:
                                                                              Text(
                                                                            "Mobile",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        Container(
                                                          height: 80,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: data
                                                                      .contactPersonDetails!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Container(
                                                                      height:
                                                                          40,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          data.contactPersonDetails == null
                                                                              ? Container(
                                                                                  width: MediaQuery.of(context).size.width / 4,
                                                                                  child: Text(
                                                                                    "No Data",
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: MediaQuery.of(context).size.width / 4,
                                                                                  child: Text(
                                                                                    data.contactPersonDetails!.first.contactpersonName!,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 2,
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                          data.contactPersonDetails == null
                                                                              ? Container(
                                                                                  width: MediaQuery.of(context).size.width / 3.5,
                                                                                  child: Text(
                                                                                    "No Data",
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  color: Colors.white,
                                                                                  width: MediaQuery.of(context).size.width / 3.5,
                                                                                  child: Text(
                                                                                    data.contactPersonDetails!.first.contactpersonDesignation!,
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                          data.contactPersonDetails == null
                                                                              ? Container(
                                                                                  width: MediaQuery.of(context).size.width / 4,
                                                                                  child: Text(
                                                                                    "No Data",
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: MediaQuery.of(context).size.width / 4,
                                                                                  child: Text(
                                                                                    data.contactPersonDetails!.first.contactpersonMobile!,
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 12,
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
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 3),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.map,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        data.taskType!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: Get.width * .4,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: DropdownButton<int>(
                                                  value: data.statusId,
                                                  items: controller.statuses
                                                      .map((status) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: status.id,
                                                      child: Text(status.name),
                                                    );
                                                  }).toList(),
                                                  onChanged: (statusId) {
                                                    controller.stausID.value =
                                                        statusId!;
                                                    data.statusId = statusId;

                                                    print(
                                                        "pros id is ++++++ ${data.prospectId} and ${data.prospectName}");

                                                    controller.updateTaskStatus(
                                                     taskID:   data.taskId.toString(),
                                                        status:   data.statusId,
                                                        prospectId: data.prospectId,
                                                      taskType: data.taskType,
                                                      prosName: data.prospectName,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          ScrollOnExpand(
                                            scrollOnExpand: true,
                                            scrollOnCollapse: false,
                                            child: ExpandablePanel(
                                              theme: const ExpandableThemeData(
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
                                                      // _textMe(
                                                      //     455);
                                                    },
                                                    child: Card(
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
                                                            Icons.chat,
                                                            color: Colors.blue,
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
                                                      // launchPhoneDialer(
                                                      //     "2424");
                                                    },
                                                    child: Card(
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
                                                            Icons.call,
                                                            color: Colors.blue,
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
                                                      // _launchWhatsapp(
                                                      //     356.toString());
                                                    },
                                                    child: Card(
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
                                                            Icons.messenger,
                                                            color: Colors.blue,
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.more_horiz,
                                                          color: Colors.blue,
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
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .15,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.blue,
                                                        onTap: () {
                                                          // _textMe(
                                                          //     455);
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
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.blue,
                                                        onTap: () {
                                                          // launchPhoneDialer(
                                                          //     "2424");
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
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.blue,
                                                        onTap: () {
                                                          // _launchWhatsapp(
                                                          //     356.toString());
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
                                                                    Colors.blue,
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
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.send,
                                                        color: Colors.grey,
                                                      ),
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
                                                            'images/person.jpg',
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      data.assignedPerson ==
                                                              null
                                                          ? Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                            )
                                                          : Text(
                                                              data.assignedPerson
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .airline_seat_recline_normal_sharp,
                                                        color: Colors.grey,
                                                      ),
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
                                                      data.createdByName == null
                                                          ? Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                            )
                                                          : Text(
                                                              data.createdByName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
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
                                                          Card(
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
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .blue,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 110,
                                                          ),
                                                          data.priorityName ==
                                                                  null
                                                              ? Container()
                                                              : Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      color: Colors
                                                                          .redAccent),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12.0,
                                                                        vertical:
                                                                            8),
                                                                    child: Text(
                                                                      data.priorityName
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        }),
              )
            ],
          ));
    });
  }
}
//
