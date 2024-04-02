import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/attendance/controller/attendance_controller.dart';
import 'package:salebee_latest/modules/attendance/view/all_attendance_report.dart';
import 'package:salebee_latest/modules/attendance/view/attendance_report.dart';
import 'package:salebee_latest/modules/attendance/view/check_in_out_view.dart';
import 'package:salebee_latest/modules/attendance/view/emp_wise_report.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:salebee_latest/widgets/circle_painter.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Attendance"),
      ),
      //backgroundColor: primaryColorLight,
      //key: _scaffoldkey,
      body: DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            onTap: (i){
                              if(i == 3){
                                Get.put(EmployeeController());
                              }
                            },
                            indicatorColor: AppColors.colorBlue,
                            labelColor: AppColors.colorBlue,
                            unselectedLabelColor: Colors.grey,
                            isScrollable: true,
                            labelStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            tabs: [

                              Tab(
                                text:
                                'Check IN/Out',
                              ),
                              Tab(
                                text:
                                'My Report',
                              ),
                              Tab(
                                text:
                                'All Report',
                              ),
                              Tab(
                                text:
                                'Employee Report',
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
                        child: CheckInOutView(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: AttendanceReportView(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: AllDailyAttendanceReportView(),
                      ) ,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: EmpWiseAttendanceReportView(),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
//
