import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/follow_up/controller/follow_up_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class CallFollowUpView extends GetView<FollowUpController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Container(
        height: Get.height * .7,
        child: ListView.builder(
          itemCount: controller.callList.value.length,
          itemBuilder: (BuildContext context, index) {
            var data = controller.callList[index];
            return Card(
                child: ListTile(
              title: Text(data.title!),
              subtitle: Text(data.description!),
              trailing: Container(
                  height: 52,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.3),
                      borderRadius: BorderRadius.circular(6)),
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEEE')
                                      .format(data.date!)
                                      .toString()
                                      .substring(0, 3) +
                                  ",",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                            Center(
                              child: Text(
                                " " + data.date.toString().substring(8, 10),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(DateFormat('MMM')
                                .format(data.date!)
                                .toString()
                                .substring(0, 3)),
                          ],
                        ),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.jm().format(data.date!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
          },
        ),
      );
    });
  }
}
//
