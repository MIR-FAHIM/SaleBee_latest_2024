import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';

import 'package:salebee_latest/modules/attendance/controller/attendance_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';

import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class EmpWiseAttendanceReportView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
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
            SizedBox(
              height: 20,
            ),
            Container(
              height: Get.height * .7,
              child: Get.find<EmployeeController>().filteredEmpList.isEmpty
                  ? Text("Loading.....")
                  : ListView.builder(
                      itemCount:
                          Get.find<EmployeeController>().filteredEmpList.length,
                      itemBuilder: (context, index) {
                        var data =
                            Get.find<EmployeeController>().filteredEmpList[index];
                        return GestureDetector(
                          onTap: () {
                            controller.getMyAttenReportByMonth(data.employeeId!, data.employeeName!);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading:data.profilePicturePath == null ?CircleAvatar(child: Icon(Icons.verified_user),) : CircleAvatar(
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      );
    });
  }
}
//
