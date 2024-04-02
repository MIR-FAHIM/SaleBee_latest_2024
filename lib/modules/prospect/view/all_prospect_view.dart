import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
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

class AllProspectView extends GetView<ProspectController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: Get.height *.7,
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.5,
                children: List.generate(controller.getStatus.length, (i) {
                  var status = controller.getStatus[i];
                  return Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: GestureDetector(
                      onTap: () {
                        controller.setSearchText(status.status, "status");
                      },
                      // onTap: productDetail[index].press,

                      child: Card(
                        child: Container(
                            height: Get.height * .08,
                            decoration: BoxDecoration(
                                color: HexColor(status.funnelColor),
                                borderRadius: BorderRadius.circular(6)),
                            width: Get.width * .16,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    status.status!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.getNewProspect.value
                                              .where((v) =>
                                                  v.stage == status.status)
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
                    ),
                  );
                })),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ));
    });
  }
}
//
