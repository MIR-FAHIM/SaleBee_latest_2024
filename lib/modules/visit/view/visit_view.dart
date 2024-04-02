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
import 'package:salebee_latest/modules/visit/view/all_emp_visit_list.dart';
import 'package:salebee_latest/modules/visit/view/my_visit_list.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class VisitView extends GetView<VisitController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Visit"),
        ),
          body: DefaultTabController(
              length: 2,
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
                                    'My Visit',
                                  ),
                                  Tab(
                                    text:
                                    'All Visit',
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
                            child: MyVisitView(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: AllVisitView(),
                          ),

                        ]),
                      ),
                    ],
                  ),
                ),
              )),);

  }
}
//
