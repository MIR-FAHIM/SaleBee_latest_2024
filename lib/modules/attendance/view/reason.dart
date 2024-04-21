import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:salebee_latest/modules/attendance/controller/attendance_controller.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';
import 'package:salebee_latest/widgets/circle_painter.dart';
import 'package:salebee_latest/widgets/text_field_widget.dart';

class AttendanceReason extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data = Get.arguments[0];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: data == "checkin"
              ? Text("Reason of late")
              : Text("Reason of early leaving"),
        ),
        //backgroundColor: primaryColorLight,
        //key: _scaffoldkey,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.reasonTextController.value,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  onChanged: (input) {
                    controller.reasonTextV.value = input;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                data == "checkin"
                    ? Container(
                        height: Get.height * .6,
                        child: ListView.builder(
                            itemCount: controller.checkINReason.value.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  controller.reasonTextV.value =
                                      controller.checkINReason.value[i];
                                  controller.reasonTextController.value.text =
                                      controller.reasonTextV.value;
                                },
                                child: Card(
                                  child: Container(
                                      color: controller.getRandomColor(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                            controller.checkINReason.value[i]),
                                      )),
                                ),
                              );
                            }))
                    : Container(
                        height: Get.height * .6,
                        child: ListView.builder(
                            itemCount: controller.checkOutReason.value.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  controller.reasonTextV.value =
                                      controller.checkOutReason.value[i];
                                  controller.reasonTextController.value.text =
                                      controller.reasonTextV.value;
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        color: controller.getRandomColor(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(controller
                                              .checkOutReason.value[i]),
                                        )),
                                  ),
                                ),
                              );
                            })),
                BlockButtonWidget(
                  onPressed: () {
                    if (controller.reasonTextV.value.isEmpty) {
                      Get.showSnackbar(Ui.errorSnackBar(
                          message: 'Please give a reason'.tr,
                          title: 'Error'.tr));
                    } else {
                      if (data == "checkin") {
                        controller.addCheckIn();
                      } else {
                        controller.addCheckOut();
                      }
                    }
                  },
                  color: AppColors.colorBlue,
                  text: data == "checkin"
                      ? Text(
                          "Confirm Check In".tr,
                          style: Get.textTheme.headline6!
                              .merge(const TextStyle(color: Colors.white)),
                        )
                      : Text(
                          "Confirm Check Out".tr,
                          style: Get.textTheme.headline6!
                              .merge(const TextStyle(color: Colors.white)),
                        ),
                ).paddingSymmetric(vertical: 10, horizontal: 20),
              ],
            );
          }),
        )));
  }
}
//
