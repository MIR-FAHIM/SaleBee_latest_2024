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
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
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

class CheckInOutView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      double currentValue = controller.circularProgressIndicatorValue.value;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //  getTime();
                        },
                        child: Text(
                          DateFormat('hh:mm').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat('a').format(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.EEEE().format(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.yMd().format(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: TweenAnimationBuilder<double>(
                duration: Duration(seconds: 3),
                tween: Tween(begin: 0.0, end: controller.end.value),
                builder: (context, double value, _) {
                  return Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                            value: currentValue,
                            backgroundColor: Colors.grey,
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          onLongPress: () async {
                            if(Get.find<LocationService>().currentLocation.value.isEmpty ){
                              Get.find<LocationService>().determinePosition();
                             if(controller.locationDis.value.isEmpty){
                               controller.getAddressFromLatLng(
                                 Get.find<LocationService>().currentLocation['lat'],
                                 Get.find<LocationService>().currentLocation['lng'],
                               );
                             }else{
                               if (controller.status.value == true) {
                                 if (DateTime.now().hour >= 11) {
                                   Get.toNamed(Routes.REASONVIEW,
                                       arguments: ["checkin"]);
                                 } else {
                                   controller.addCheckIn();
                                 }
                               } else {
                                 if (DateTime.now().hour <= 18) {
                                   Get.toNamed(Routes.REASONVIEW,
                                       arguments: ["checkout"]);
                                 } else {
                                   controller.addCheckOut();
                                 }
                               }
                             }
                            }else{
                              if (controller.status.value == true) {
                                if (DateTime.now().hour >= 11) {
                                  Get.toNamed(Routes.REASONVIEW,
                                      arguments: ["checkin"]);
                                } else {
                                  controller.addCheckIn();
                                }
                              } else {
                                if (DateTime.now().hour <= 18) {
                                  Get.toNamed(Routes.REASONVIEW,
                                      arguments: ["checkout"]);
                                } else {
                                  controller.addCheckOut();
                                }
                              }
                            }

                          },
                          onLongPressCancel: () {
                            controller.updateEndValue(0);
                          },
                          child: Obx(() => Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.status.value
                                        ? Colors.blue
                                        : Colors.amber),
                                child: Padding(
                                  padding: const EdgeInsets.all(70.0),
                                  child: Column(children: [
                                    Image.asset(
                                      'images/tap.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    controller.status.value
                                        ? Text("Check In")
                                        : Text("Check Out")
                                  ]),
                                ),
                              )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            controller.showInfo.value == true
                ? DateTime.parse(controller.attendanceModel.value.result!.first
                                    .logTimeIn)
                                .day ==
                            DateTime.now().day &&
                        DateTime.parse(controller.attendanceModel.value.result!
                                    .first.logTimeIn)
                                .month ==
                            DateTime.now().month &&
                        DateTime.parse(controller.attendanceModel.value.result!
                                    .first.logTimeIn)
                                .year ==
                            DateTime.now().year
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                  height: Get.height * .18,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(6)),
                                  width: Get.width * .35,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: controller.attendanceModel.value
                                                  .result !=
                                              null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Check in info",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      DateFormat.EEEE().format(
                                                          DateTime.parse(
                                                              controller
                                                                  .attendanceModel
                                                                  .value
                                                                  .result!
                                                                  .first
                                                                  .logTimeIn)),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      DateFormat.yMd().format(
                                                          DateTime.parse(
                                                              controller
                                                                  .attendanceModel
                                                                  .value
                                                                  .result!
                                                                  .first
                                                                  .logTimeIn)),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: Get.width *.3,
                                                  child: Card(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          DateFormat.jm().format(
                                                              DateTime.parse(
                                                                  controller
                                                                      .attendanceModel
                                                                      .value
                                                                      .result!
                                                                      .first
                                                                      .logTimeIn,
                                                              ),),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold)
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                controller
                                                    .attendanceModel
                                                    .value
                                                    .result!
                                                    .first
                                                    .locationDescription == null ? Text("") :
                                                Text(
                                                  controller
                                                      .attendanceModel
                                                      .value
                                                      .result!
                                                      .first
                                                      .locationDescription!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          : Center(
                                              child:
                                                  Text("You did not check in")))),
                            ),
                          ),
                          Card(
                            child: Column(
                              children: [
                                Container(
                                    color: Colors.redAccent.withOpacity(.1),
                                    width: Get.width * .15,
                                    child: Center(
                                        child: Text(controller.duration(
                                            controller.attendanceModel.value
                                                .result!.first.logTimeIn,
                                            controller.attendanceModel.value
                                                .result!.first.logTimeOut)))),
                                Text("Duration"),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                  height: Get.height * .18,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(6)),
                                  width: Get.width * .32,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: controller.attendanceModel.value
                                                .result!.first.logTimeOut !=
                                            null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Check out info",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    DateFormat.EEEE().format(
                                                        DateTime.parse(controller
                                                            .attendanceModel
                                                            .value
                                                            .result!
                                                            .first
                                                            .logTimeOut)),
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width:3,
                                                  ),
                                                  Text(
                                                    DateFormat.yMd().format(
                                                        DateTime.parse(controller
                                                            .attendanceModel
                                                            .value
                                                            .result!
                                                            .first
                                                            .logTimeOut)),
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: Get.width *.3,
                                                child: Card(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        DateFormat.jm().format(
                                                            DateTime.parse(
                                                                controller
                                                                    .attendanceModel
                                                                    .value
                                                                    .result!
                                                                    .first
                                                                    .logTimeOut)),
                                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                controller
                                                    .attendanceModel
                                                    .value
                                                    .result!
                                                    .first
                                                    .locationDescriptionOut!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : Text("You did not check out today"),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : Container()
                : Container(),
            SizedBox(
              height: 70,
            ),
            controller.locationDis.isEmpty
                ? Text("No Data")
                : Text(controller.locationDis.value),
            InkWell(
                onTap: () {
                  controller.getAddressFromLatLng(
                    Get.find<LocationService>().currentLocation['lat'],
                    Get.find<LocationService>().currentLocation['lng'],
                  );
                },
                child: CircleAvatar(radius: 16, child: Icon(Icons.sync_problem)))
          ],
        ),
      );
    });
  }
}
//
