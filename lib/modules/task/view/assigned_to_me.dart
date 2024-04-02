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
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class AssignedToMeTaskView extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
          body: Column(
            children: [
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

                        },
                        tabs: controller.dayTab
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;

                      controller.setSearchText("Call", "task");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Call",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.taskType == "Call"&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("Visit", "task");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Visit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.taskType == "Visit"&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("Meeting", "task");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .18,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Meeting",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.taskType == "Meeting"&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("Mail", "task");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .18,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Mail",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.taskType == "Mail"&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;

                      controller.setSearchText("4", "status");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(.3),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Done",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.statusId == 4&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("1", "status");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.3),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Incomplete",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.statusId == 1&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("5", "status");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.3),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .18,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Initiated",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.statusId == 5&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                  GestureDetector(
                    onTap: () {
                      controller.selectAll.value = false;
                      controller.setSearchText("11", "status");
                    },
                    child: Container(
                        height: Get.height * .06,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.8),
                            borderRadius: BorderRadius.circular(6)),
                        width: Get.width * .18,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              Text(
                                "Cancelled",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.myTaskList
                                          .where((v) => v.statusId == 11&& v.dueDate!.day == controller.daySelection.value
                                          &&v.dueDate!.month == controller.monthSelection.value
                                          &&v.dueDate!.year == controller.yearSelection.value)
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: Get.height * .55,
                child: controller.assigedToMeTaskList.isEmpty
                    ? Text("No Task Found")
                    : ListView.builder(
                    itemCount: controller.assigedToMeTaskList.where((element) => element.dueDate!.day == controller.daySelection.value

                        &&element.dueDate!.month == controller.monthSelection.value
                        &&element.dueDate!.year == controller.yearSelection.value).length,
                    itemBuilder: (context, index) {
                      var data = controller.assigedToMeTaskList.where((element) => element.dueDate!.day == controller.daySelection.value

                          &&element.dueDate!.month == controller.monthSelection.value
                          &&element.dueDate!.year == controller.yearSelection.value).toList()[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          style: TextStyle(color: Colors.grey),
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
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                          fontSize: 12),
                                    )
                                        : Text(
                                      "${data.prospectName!}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.taskDesc!,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
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
                                                        Text(
                                                          DateFormat('EEEE')
                                                              .format(data
                                                              .dueDate!)
                                                              .toString()
                                                              .substring(
                                                              0, 3) +
                                                              ",",
                                                          textAlign:
                                                          TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
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
                                                                    8, 10),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Text(DateFormat('MMM')
                                                            .format(
                                                            data.dueDate!)
                                                            .toString()
                                                            .substring(0, 3)),
                                                      ],
                                                    ),
                                                    Card(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            DateFormat.jm()
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
                                          "${data.dueDate!.difference(DateTime.now()).inDays} days",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    data.contactPersonDetails == null
                                        ? Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Prospect: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2.5,
                                              child: GestureDetector(
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
                                                  4.1,
                                              child:
                                              data.leadName ==
                                                  null
                                                  ? Text(
                                                "No Data",
                                                style: TextStyle(
                                                    fontSize:
                                                    12,
                                                    color: Colors
                                                        .black54,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              )
                                                  : Text(
                                                "${data.leadName}",
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
                                      ],
                                    )
                                        : Card(
                                      elevation: 5,
                                      color: data.contactPersonDetails ==
                                          null
                                          ? Colors.white
                                          : AppColors.greenButton,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                          fontSize: 12,
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
                                                            fontSize: 12,
                                                            color: Colors
                                                                .black54,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Lead:",
                                                      style: TextStyle(
                                                          fontSize: 12,
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
                                                            fontSize:
                                                            12,
                                                            color:
                                                            Colors.black54,
                                                            fontWeight: FontWeight.normal),
                                                      )
                                                          : Text(
                                                        "${data.leadName}",
                                                        style: TextStyle(
                                                            fontSize:
                                                            12,
                                                            color:
                                                            Colors.black54,
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
                                                      color:
                                                      Colors.blue,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                                4,
                                                            child: Text(
                                                              "Contact person",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                                4,
                                                            child: Text(
                                                              "Designation",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                                4,
                                                            child: Text(
                                                              "Mobile",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                              height: 80,
                                              child: ListView.builder(
                                                  itemCount: data
                                                      .contactPersonDetails!
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext
                                                  context,
                                                      int index) {
                                                    return Container(
                                                      height: 40,
                                                      color: Colors.white,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          data.contactPersonDetails ==
                                                              null
                                                              ? Container(
                                                            width:
                                                            MediaQuery.of(context).size.width /
                                                                4,
                                                            child:
                                                            Text(
                                                              "No Data",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                          )
                                                              : Container(
                                                            width:
                                                            MediaQuery.of(context).size.width /
                                                                4,
                                                            child:
                                                            Text(
                                                              data
                                                                  .contactPersonDetails!
                                                                  .first
                                                                  .contactpersonName!,
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              maxLines:
                                                              2,
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontSize:
                                                                12,
                                                              ),
                                                            ),
                                                          ),
                                                          data.contactPersonDetails ==
                                                              null
                                                              ? Container(
                                                            width: MediaQuery.of(context).size.width /
                                                                3.5,
                                                            child:
                                                            Text(
                                                              "No Data",
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontSize:
                                                                12,
                                                              ),
                                                            ),
                                                          )
                                                              : Container(
                                                            color: Colors
                                                                .white,
                                                            width: MediaQuery.of(context).size.width /
                                                                3.5,
                                                            child:
                                                            Text(
                                                              data
                                                                  .contactPersonDetails!
                                                                  .first
                                                                  .contactpersonDesignation!,
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontSize:
                                                                12,
                                                              ),
                                                            ),
                                                          ),
                                                          data.contactPersonDetails ==
                                                              null
                                                              ? Container(
                                                            width:
                                                            MediaQuery.of(context).size.width /
                                                                4,
                                                            child:
                                                            Text(
                                                              "No Data",
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontSize:
                                                                12,
                                                              ),
                                                            ),
                                                          )
                                                              : Container(
                                                            width:
                                                            MediaQuery.of(context).size.width /
                                                                4,
                                                            child:
                                                            Text(
                                                              data
                                                                  .contactPersonDetails!
                                                                  .first
                                                                  .contactpersonMobile!,
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Colors.grey,
                                                                fontSize:
                                                                12,
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
                                            borderRadius: const BorderRadius
                                                .only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                Radius.circular(30)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 3),
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
                                                      color: Colors.white),
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
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: DropdownButton<int>(
                                            value: data.statusId,
                                            items: controller.statuses
                                                .map((status) {
                                              return DropdownMenuItem<int>(
                                                value: status.id,
                                                child: Text(status.name),
                                              );
                                            }).toList(),
                                            onChanged: (statusId) {
                                              controller.stausID.value =
                                              statusId!;
                                              data.statusId = statusId;




                                              controller.taskUpdateController(
                                                taskType: "Visit",
                                                prosName: data.prospectName,
                                                taskID: data.taskId,
                                                type: data.type,
                                                title: data.title,
                                                description: data.taskDesc,
                                                prospectId: data.prospectId,
                                                assignaTo: data.assignedTo,
                                                priority: data.priority,
                                                status: data.statusId,
                                                dueDate:
                                                data.dueDate.toString(),
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
                                                  fontWeight: FontWeight.w600),
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
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
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
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
                                                      shape:
                                                      BoxShape.circle),
                                                  child: const CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                      'images/person.jpg',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                data.assignedPerson == null
                                                    ? Text(
                                                  "No Data",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                )
                                                    : Text(
                                                  data.assignedPerson
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
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
                                                      shape:
                                                      BoxShape.circle),
                                                  child: const CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
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
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                )
                                                    : Text(
                                                  data.createdByName
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
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
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
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
                                                            Icons.edit,
                                                            color: Colors.blue,
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
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 110,
                                                    ),
                                                    data.priorityName == null
                                                        ? Container()
                                                        : Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6),
                                                          color: Colors
                                                              .redAccent),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                    }),
              )
            ],
          ));
    });
  }
}
//
