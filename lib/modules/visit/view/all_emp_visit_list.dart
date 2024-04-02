import 'dart:math';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';


class AllVisitView extends GetView<VisitController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return SingleChildScrollView(
        child: Column(
              children: [
                SizedBox(height: 10,),
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


                Container(
                  height: Get.height *.1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Get.find<HomeController>().allEmployeeList.value.length,
                      itemBuilder: (context, i){
                        var empData = Get.find<HomeController>().allEmployeeList.value[i];
                        return GestureDetector(
                          onTap: () {


                         //   controller.setSearchText("4", "status");
                          },
                          child: Card(
                            child: Container(
                                height: Get.height * .08,
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(6)),
                                width: Get.width * .16,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        empData.employeeName!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                      Card(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.getAllVisit.where((p) =>
                                              p.employeeId == empData.employeeId &&
                                              p.locationTime!.day == controller.daySelection.value
                                                  && p.locationTime!.month == controller.monthSelection.value
                                                  && p.locationTime!.year == controller.yearSelection.value).length
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


                SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height * .57,
                  child: controller.getAllVisit.isEmpty
                      ? Text("Loading....")
                      : ListView.builder(
                      itemCount: controller.getAllVisit.where((p) =>
                      p.locationTime!.day == controller.daySelection.value
                          && p.locationTime!.month == controller.monthSelection.value
                          && p.locationTime!.year == controller.yearSelection.value).length,
                      itemBuilder: (context, index) {
                        var visitData = controller.getAllVisit.where((p) =>
                        p.locationTime!.day == controller.daySelection.value
                            && p.locationTime!.month == controller.monthSelection.value
                            && p.locationTime!.year == controller.yearSelection.value).toList()[index];
                        return ExpandableNotifier(
                          child: Stack(
                            children: [
                              Card(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  color: AppColors.greenButton
                                                      .withOpacity(
                                                      .3),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      6)),
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    4.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        visitData.locationTime ==
                                                            null
                                                            ? Text(
                                                          "No data",
                                                          textAlign:
                                                          TextAlign.center,
                                                          style:
                                                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                        )
                                                            : Text(
                                                          DateFormat('EEEE').format(visitData.locationTime!).toString().substring(0, 3) +
                                                              ",",
                                                          textAlign:
                                                          TextAlign.center,
                                                          style:
                                                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
//"LogTimeIn":"2022-09-13T08:36:40.32"

                                                        Center(
                                                          child: visitData.locationTime ==
                                                              null
                                                              ? Text(
                                                            "No Data",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          )
                                                              : Text(
                                                            " " + visitData.locationTime!.toString().substring(8, 10),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                        visitData.locationTime ==
                                                            null
                                                            ? Text(
                                                            "No data")
                                                            : Text(
                                                          DateFormat('MMM').format(visitData.locationTime!).toString().substring(0,
                                                              3),
                                                          style:
                                                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Card(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          visitData.locationTime ==
                                                              null
                                                              ? Text(
                                                              "No data")
                                                              : Text(
                                                            DateFormat.jm().format(visitData.locationTime!),
                                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          SizedBox(
                                            width: 05,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                visitData.prospectName ==
                                                    null
                                                    ? Text(
                                                  "No Data",
                                                  style:
                                                  TextStyle(
                                                    fontSize:
                                                    12,
                                                    color: Colors
                                                        .black54,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                )
                                                    : Text(
                                                  visitData
                                                      .prospectName!,
                                                  style:
                                                  TextStyle(
                                                    fontSize:
                                                    12,
                                                    color: Colors
                                                        .black54,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: MediaQuery.of(context).size.width * .6,
                                                  child: Text(

                                                   visitData.prospectAddress!,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors
                                                          .black54,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Container(
                                                    height: 5,
                                                    width: 200,
                                                    child: Divider(
                                                      thickness: 1,
                                                      color: Colors
                                                          .grey,
                                                    )),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Visted by: ",
                                                      style: TextStyle(
                                                          fontSize:
                                                          9,
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                    Text(
                                                      "${visitData.employeeName}",
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        10,
                                                        color: Colors
                                                            .black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Address: ",
                                                      style: TextStyle(
                                                          fontSize:
                                                          9,
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
                                                          .width *
                                                          .5,
                                                      child: Center(
                                                        child:
                                                        InkWell(
                                                          onTap:
                                                              () {
                                                          Get.toNamed(Routes.MAPVIEW, arguments: [visitData.latitude, visitData.longitude]);
                                                          },
                                                          child:
                                                          Text(
                                                            maxLines:2,
                                                            visitData
                                                                .locationDescription!,

                                                            style: TextStyle(
                                                                fontSize:
                                                                10,
                                                                color:
                                                                Colors.blue),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
      );
    });
  }
}
//
