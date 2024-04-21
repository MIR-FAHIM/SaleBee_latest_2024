import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';

import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class MyProspectView extends GetView<ProspectController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: Get.height * .1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.getStatus.length,
                  itemBuilder: (context, i) {
                    var status = controller.getStatus[i];
                    return GestureDetector(
                      onTap: () {
                        controller.setSearchText(status.status, "status");
                      },
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
                                          Get.find<AuthService>()
                                              .getNewProspectLocal
                                              .value
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
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: TextField(
                  onChanged: (e) {
                    controller.setSearchText(e, "search");
                    // controller.contactsResult.value =
                    //     _search(controller.contacts.value);
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Get.height * .6,
              child: controller.filteredProspectList.isEmpty
                  ? Text("Loading....")
                  : ListView.builder(
                      itemCount: controller.filteredProspectList.length,
                      itemBuilder: (context, index) {
                        var data = controller.filteredProspectList[index];
                        return Card(
                          child: ExpandableNotifier(
                            child: InkWell(
                              onTap: () {
                                controller.prosId.value = data.id.toString();
                                Get.toNamed(Routes.PROSPECTVIEWDETAIL,
                                    arguments: [data]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFFFFFFF)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Created on: ${DateFormat.yMd().format(data.createdOn!)}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                      ListTile(
                                          trailing: Container(
                                            width: Get.width * .4,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: DropdownButton<int>(
                                              value: data.prospectStage,
                                              items: controller.getStatus
                                                  .map((status) {
                                                return DropdownMenuItem<int>(
                                                  value: status.id,
                                                  child: Text(status.status),
                                                );
                                              }).toList(),
                                              onChanged: (statusId) {
                                                controller.stausID.value =
                                                    statusId!;
                                                data.prospectStage = statusId;

                                                controller.updateProspectStatus(
                                                    data.id.toString(),
                                                    statusId.toString());
                                              },
                                            ),
                                          ),
                                          title: Text(
                                            data.name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data.zoneName!),
                                              InkWell(
                                                  onTap: () {
                                                    controller.launchURL(
                                                        data.websiteProspect!);
                                                  },
                                                  child: Text(
                                                    data.websiteProspect!,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              data.concernPersons!.isEmpty
                                                  ? Text(
                                                      "No data",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    )
                                                  : Text(
                                                      data.concernPersons![0]
                                                          .contactpersonName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                              data.concernPersons!.isEmpty
                                                  ? Text(
                                                      "No data",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    )
                                                  : Text(
                                                      data.concernPersons![0]
                                                          .contactpersonDesignation
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                              data.concernPersons!.isEmpty
                                                  ? Text(
                                                      "No data",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    )
                                                  : Text(
                                                      data.concernPersons![0]
                                                          .contactpersonMobile
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                            ],
                                          )),
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
                                                  controller.textMe(data
                                                      .concernPersons![0]
                                                      .contactpersonMobile!
                                                      .toString());
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
                                                        color: AppColors
                                                            .textColorGreen,
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
                                                  controller.launchPhoneDialer(
                                                      data.concernPersons![0]
                                                          .contactpersonMobile!
                                                          .toString());
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
                                                        color: AppColors
                                                            .greenButton,
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
                                                  controller.launchWhatsapp(data
                                                      .concernPersons![0]
                                                      .contactpersonMobile!
                                                      .toString());
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
                                                      child: Image(
                                                        height: 25,
                                                        width: 25,
                                                        image: AssetImage(
                                                            "images/Icons/whatsapp.png"),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.more_horiz,
                                                      color:
                                                          AppColors.greenButton,
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
                                                  SizedBox(
                                                      width: Get.width * .2,
                                                      child:
                                                          Text("Created by:")),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const CircleAvatar(
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
                                                  Text(
                                                    data.createdByName!,
                                                    // getEmp(
                                                    //     data.createdBy! ??
                                                    //         1,
                                                    //     AttendanceRepository
                                                    //         .employeeList),
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
                                                children: [
                                                  SizedBox(
                                                      width: Get.width * .2,
                                                      child:
                                                          Text("Assign to:")),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const CircleAvatar(
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
                                                  Text(
                                                    data.assignToEmployee!,
                                                    // getEmp(
                                                    //     data.createdBy! ??
                                                    //         1,
                                                    //     AttendanceRepository
                                                    //         .employeeList),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                  )
                                                ],
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
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (Get.find<
                                                                  LocationService>()
                                                              .currentLocation
                                                              .value
                                                              .isEmpty) {
                                                            Get.find<
                                                                    LocationService>()
                                                                .determinePosition();
                                                            if (controller
                                                                .locationDis
                                                                .value
                                                                .isEmpty) {
                                                              controller
                                                                  .getAddressFromLatLng(
                                                                Get.find<LocationService>()
                                                                        .currentLocation[
                                                                    'lat'],
                                                                Get.find<LocationService>()
                                                                        .currentLocation[
                                                                    'lng'],
                                                              );
                                                            } else {
                                                              controller
                                                                  .addVisitController(
                                                                data.id!,
                                                                data.name,
                                                              );
                                                            }
                                                          } else {
                                                            controller
                                                                .addVisitController(
                                                                    data.id!,
                                                                    data.name);
                                                          }
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
                                                              child: Text(
                                                                "Add Visit",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .colorBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
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
                                                              Icons.edit,
                                                              color: AppColors
                                                                  .greenButton,
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
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Container()
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // Container(
                                              //   height: 50,
                                              //   child: ListView.separated(
                                              //     scrollDirection:
                                              //     Axis.horizontal,
                                              //     itemCount:
                                              //     activityList.length,
                                              //     itemBuilder:
                                              //         (BuildContext
                                              //     context,
                                              //         index) {
                                              //       return Row(
                                              //         children: [
                                              //           badges.Badge(
                                              //             badgeContent: index ==
                                              //                 0
                                              //                 ? Text(data
                                              //                 .followupLogActivity!
                                              //                 .leadCount
                                              //                 .toString())
                                              //                 : index == 1
                                              //                 ? Text(data
                                              //                 .followupLogActivity!
                                              //                 .quoteCount
                                              //                 .toString())
                                              //                 : index ==
                                              //                 2
                                              //                 ? Text(data.followupLogActivity!.orderCount.toString())
                                              //                 : index == 3
                                              //                 ? Text(data.followupActivity!.call.toString())
                                              //                 : index == 4
                                              //                 ? Text(data.followupActivity!.message.toString())
                                              //                 : index == 5
                                              //                 ? Text(data.followupActivity!.meeting.toString())
                                              //                 : Text(data.followupActivity!.visit.toString()),
                                              //             badgeStyle: badges.BadgeStyle(
                                              //               badgeColor: primaryColorLight,
                                              //             ),
                                              //             child: Card(
                                              //               elevation: 5,
                                              //               child:
                                              //               Container(
                                              //                 width: MediaQuery.of(context)
                                              //                     .size
                                              //                     .width *
                                              //                     .11,
                                              //                 height: 40,
                                              //                 child:
                                              //                 Column(
                                              //                   children: [
                                              //                     InkWell(
                                              //                       onTap:
                                              //                           () {},
                                              //                       child:
                                              //                       CircleAvatar(
                                              //                         radius:
                                              //                         10,
                                              //                         backgroundColor:
                                              //                         Colors.transparent,
                                              //                         child:
                                              //                         activityList[index].icon,
                                              //                       ),
                                              //                     ),
                                              //                     SizedBox(
                                              //                       height:
                                              //                       5,
                                              //                     ),
                                              //                     Expanded(
                                              //                       child:
                                              //                       Text(
                                              //                         activityList[index].activityName!,
                                              //                         style:
                                              //                         TextStyle(color: Colors.grey, fontSize: 7),
                                              //                         overflow:
                                              //                         TextOverflow.ellipsis,
                                              //                       ),
                                              //                     ),
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             width: 10,
                                              //           )
                                              //         ],
                                              //       );
                                              //     },
                                              //     separatorBuilder:
                                              //         (context, index) {
                                              //       return SizedBox(
                                              //         width: 0,
                                              //       );
                                              //     },
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ));
    });
  }
}
