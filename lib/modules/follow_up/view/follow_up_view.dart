import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/models/auth/get_followup_by_pros_id_model.dart';
import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/follow_up/controller/follow_up_controller.dart';
import 'package:salebee_latest/modules/follow_up/view/widget/call_follow_up.dart';
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

class FollowUpView extends GetView<FollowUpController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Call> callList = Get.arguments[0]['call'];
    List<Sm> smsList = Get.arguments[0]['sms'];
    List<Call> emailList = Get.arguments[0]['email'];
    List<Call> otherList = Get.arguments[0]['other'];
  //  List<Resultvisit> visitList = Get.arguments[0]['visit'];

      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Follow UP"),
          ),
          body:
               Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTabController(
                      length: 4,
                      child: SafeArea(
                        child: Container(
                          height: Get.height*.8,
                          color: AppColors.backgroundColor,
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(0.0),
                              //   child: Container(
                              //
                              //     height: Get.height*.15,
                              //     child: Row(
                              //
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Container(
                              //             width: Get.width*.5,
                              //             height: Get.height*.15,
                              //             child: Column(
                              //               crossAxisAlignment: CrossAxisAlignment.start,
                              //               children: [
                              //                 Row(
                              //                   children: [
                              //                     Text("Your Total Task: "),
                              //                     Text(
                              //                       (controller.myTaskList.where((v) => v.statusId == 4).length+ controller.myTaskList.where((v) => v.statusId == 5).length + controller.myTaskList.where((v) => v.statusId == 3).length).toString(),
                              //                       style:
                              //                       TextStyle(fontWeight: FontWeight.bold),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Text(
                              //                       "Your Task Pending: ",
                              //                       style: TextStyle(
                              //                           fontWeight: FontWeight.normal),
                              //                     ),
                              //                     Text(
                              //                       "${controller.myTaskList.where((v) => v.statusId == 5).length.toString()}",
                              //                       style:
                              //                       TextStyle(fontWeight: FontWeight.bold),
                              //                     ),
                              //                   ],
                              //                 ) ,
                              //                 Row(
                              //                   children: [
                              //                     Text("Your Task Completed: "),
                              //                     Text(
                              //                       "${controller.myTaskList.where((v) => v.statusId == 4).length.toString()}",
                              //                       style:
                              //                       TextStyle(fontWeight: FontWeight.bold),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Text(
                              //                       "Efficiancy: ",
                              //                       style: TextStyle(
                              //                           fontWeight: FontWeight.normal),
                              //                     ),
                              //                     Text(
                              //                       "${(((controller.myTaskList.where((v) => v.statusId == 4).length)/((controller.myTaskList.where((v) => v.statusId == 5).length) + (controller.myTaskList.where((v) => v.statusId == 4).length))
                              //                       ) * 100).roundToDouble()} %",
                              //                       style:
                              //                       TextStyle(fontWeight: FontWeight.bold),
                              //                     ),
                              //                   ],
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           width: Get.width*.3,
                              //           height: Get.height*.15,
                              //           child: PieChart(
                              //             PieChartData(
                              //               sections: [
                              //                 PieChartSectionData(
                              //                   color: Colors.blue.withOpacity(.5),
                              //                   title: 'Completed',
                              //                   radius: 30,
                              //                   value: controller.myTaskList
                              //                       .where((v) => v.statusId == 4)
                              //                       .length
                              //                       .toDouble(),
                              //                 ),
                              //                 PieChartSectionData(
                              //                     color: Colors.redAccent.withOpacity(.5),
                              //                     title: 'Pending',
                              //                     radius: 35,
                              //                     value: controller.myTaskList
                              //                         .where((v) => v.statusId == 5)
                              //                         .length
                              //                         .toDouble()
                              //                 ),
                              //               ],
                              //               borderData: FlBorderData(show: false),
                              //               centerSpaceRadius: 20,
                              //               sectionsSpace: 0,
                              //               centerSpaceColor: Colors.blue.withOpacity(.2),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
                                            'Call',
                                          ),
                                          Tab(
                                            text:
                                            'Meesage',
                                          ),
                                          Tab(
                                            text:
                                            'Meeting',
                                          ),
                                          Tab(
                                            text:
                                            'Other',
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
                                        child: callList.isEmpty ? Text("Loading....")  :Container(
                                          height: Get.height * .7,
                                          child: ListView.builder(
                                            itemCount: callList.length,
                                            itemBuilder: (BuildContext context, index) {
                                              var data = callList[index];
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
                                        ),
                                      ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: smsList.isEmpty ? Text("Loading....")  :Container(
                                      height: Get.height * .7,
                                      child: ListView.builder(
                                        itemCount: smsList.length,
                                        itemBuilder: (BuildContext context, index) {
                                          var data = emailList[index];
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: otherList.isEmpty ? Text("Loading....")  :Container(
                                      height: Get.height * .7,
                                      child: ListView.builder(
                                        itemCount: otherList.length,
                                        itemBuilder: (BuildContext context, index) {
                                          var data = otherList[index];
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: otherList.isEmpty ? Text("Loading....")  :Container(
                                      height: Get.height * .7,
                                      child: ListView.builder(
                                        itemCount: otherList.length,
                                        itemBuilder: (BuildContext context, index) {
                                          var data = otherList[index];
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
                                    ),
                                  ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//                                     child:  Column(
//                                       children: [
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         DefaultTabController(
//                                           initialIndex: controller.monthSelection.value - 1,
//                                           length: 12,
//                                           child: Container(
//                                             height: 30,
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 8),
//                                                   child: Container(
//                                                     width: 70,
//                                                     child: DropdownButton<String>(
//                                                       value: controller.dropdownValue.value,
//                                                       isExpanded: true,
//                                                       icon: Icon(Icons.arrow_drop_down_outlined),
//                                                       elevation: 16,
//                                                       style: const TextStyle(color: Colors.deepPurple),
//                                                       underline: Container(
//                                                         height: 2,
//                                                         color: Colors.transparent,
//                                                       ),
//                                                       onChanged: (String? value) {
//                                                         // This is called when the user selects an item.
//
//                                                         controller.dropdownValue.value = value!;
//                                                         controller.yearSelection.value =
//                                                             int.parse(controller.dropdownValue.value);
//                                                       },
//                                                       items: controller.yearList
//                                                           .map<DropdownMenuItem<String>>((String value) {
//                                                         return DropdownMenuItem<String>(
//                                                           value: value,
//                                                           child: Text(value),
//                                                         );
//                                                       }).toList(),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   width: MediaQuery.of(context).size.width - 150,
//                                                   child: DefaultTabController(
//                                                     initialIndex: controller.monthSelection.value - 1,
//                                                     length: 12,
//                                                     child: TabBar(
//                                                       indicator: BoxDecoration(
//                                                           borderRadius: BorderRadius.circular(10),
//                                                           color: AppColors.textColorGreen.withOpacity(.5)),
//                                                       isScrollable: true,
//                                                       indicatorColor: Colors.black,
//                                                       labelColor: Colors.black,
//                                                       onTap: (index) {
//                                                         controller.monthSelection.value = index + 1;
//                                                       },
//                                                       tabs: controller.tabs
//                                                           .map((tab) => Tab(
//                                                         icon: Padding(
//                                                           padding: const EdgeInsets.all(4.0),
//                                                           child: Text(
//                                                             tab,
//                                                             style: TextStyle(fontSize: 12),
//                                                           ),
//                                                         ),
//                                                       ))
//                                                           .toList(),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                           child: DefaultTabController(
//                                             initialIndex: controller.daySelection.value - 1,
//                                             length: 31,
//                                             child: Column(
//                                               children: [
//                                                 TabBar(
//                                                   isScrollable: true,
//                                                   indicatorColor: Colors.black38,
//                                                   labelColor: Colors.black,
//                                                   onTap: (index) {
//                                                     controller.daySelection.value = index + 1;
//                                                   },
//                                                   tabs: controller.dayTab
//                                                       .map((tab) => Tab(
//                                                     icon: Padding(
//                                                       padding: const EdgeInsets.all(8.0),
//                                                       child: Text(
//                                                         tab.toString(),
//                                                         style: TextStyle(
//                                                           fontSize: 12,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ))
//                                                       .toList(),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         Container(
//                                           height: Get.height * .67,
//                                           child: visitList.isEmpty
//                                               ? Text("Loading....")
//                                               : ListView.builder(
//                                               itemCount: visitList
//                                                   .where((p) =>
//                                               p.locationTime!.day ==
//                                                   controller.daySelection.value &&
//                                                   p.locationTime!.month ==
//                                                       controller.monthSelection.value &&
//                                                   p.locationTime!.year ==
//                                                       controller.yearSelection.value)
//                                                   .length,
//                                               itemBuilder: (context, index) {
//                                                 var visitData = visitList
//                                                     .where((p) =>
//                                                 p.locationTime!.day ==
//                                                     controller.daySelection.value &&
//                                                     p.locationTime!.month ==
//                                                         controller.monthSelection.value &&
//                                                     p.locationTime!.year ==
//                                                         controller.yearSelection.value)
//                                                     .toList()[index];
//                                                 return ExpandableNotifier(
//                                                   child: Stack(
//                                                     children: [
//                                                       Card(
//                                                         child: Container(
//                                                           child: Column(
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Container(
//                                                                       height: 45,
//                                                                       decoration: BoxDecoration(
//                                                                           color: AppColors.greenButton
//                                                                               .withOpacity(.3),
//                                                                           borderRadius:
//                                                                           BorderRadius.circular(6)),
//                                                                       width: 100,
//                                                                       child: Padding(
//                                                                         padding:
//                                                                         const EdgeInsets.symmetric(
//                                                                             vertical: 4.0),
//                                                                         child: Column(
//                                                                           children: [
//                                                                             Row(
//                                                                               mainAxisAlignment:
//                                                                               MainAxisAlignment
//                                                                                   .center,
//                                                                               children: [
//                                                                                 visitData.locationTime ==
//                                                                                     null
//                                                                                     ? Text(
//                                                                                   "No data",
//                                                                                   textAlign:
//                                                                                   TextAlign
//                                                                                       .center,
//                                                                                   style: TextStyle(
//                                                                                       fontSize: 10,
//                                                                                       fontWeight:
//                                                                                       FontWeight
//                                                                                           .bold),
//                                                                                 )
//                                                                                     : Text(
//                                                                                   DateFormat('EEEE')
//                                                                                       .format(visitData
//                                                                                       .locationTime!)
//                                                                                       .toString()
//                                                                                       .substring(
//                                                                                       0,
//                                                                                       3) +
//                                                                                       ",",
//                                                                                   textAlign:
//                                                                                   TextAlign
//                                                                                       .center,
//                                                                                   style: TextStyle(
//                                                                                       fontSize: 10,
//                                                                                       fontWeight:
//                                                                                       FontWeight
//                                                                                           .bold),
//                                                                                 ),
//                                                                                 SizedBox(
//                                                                                   height: 5,
//                                                                                 ),
// //"LogTimeIn":"2022-09-13T08:36:40.32"
//
//                                                                                 Center(
//                                                                                   child: visitData
//                                                                                       .locationTime ==
//                                                                                       null
//                                                                                       ? Text(
//                                                                                     "No Data",
//                                                                                     textAlign:
//                                                                                     TextAlign
//                                                                                         .center,
//                                                                                     style:
//                                                                                     TextStyle(
//                                                                                       fontSize: 10,
//                                                                                     ),
//                                                                                   )
//                                                                                       : Text(
//                                                                                     " " +
//                                                                                         visitData
//                                                                                             .locationTime!
//                                                                                             .toString()
//                                                                                             .substring(
//                                                                                             8,
//                                                                                             10),
//                                                                                     textAlign:
//                                                                                     TextAlign
//                                                                                         .center,
//                                                                                     style:
//                                                                                     TextStyle(
//                                                                                       fontSize: 10,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 visitData.locationTime ==
//                                                                                     null
//                                                                                     ? Text("No data")
//                                                                                     : Text(
//                                                                                   DateFormat('MMM')
//                                                                                       .format(visitData
//                                                                                       .locationTime!)
//                                                                                       .toString()
//                                                                                       .substring(
//                                                                                       0, 3),
//                                                                                   style: TextStyle(
//                                                                                       fontSize: 10,
//                                                                                       fontWeight:
//                                                                                       FontWeight
//                                                                                           .bold),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                             Card(
//                                                                               child: Row(
//                                                                                 mainAxisAlignment:
//                                                                                 MainAxisAlignment
//                                                                                     .center,
//                                                                                 children: [
//                                                                                   visitData.locationTime ==
//                                                                                       null
//                                                                                       ? Text("No data")
//                                                                                       : Text(
//                                                                                     DateFormat.jm()
//                                                                                         .format(visitData
//                                                                                         .locationTime!),
//                                                                                     style: TextStyle(
//                                                                                         fontSize:
//                                                                                         10,
//                                                                                         fontWeight:
//                                                                                         FontWeight
//                                                                                             .bold),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       )),
//                                                                   SizedBox(
//                                                                     width: 05,
//                                                                   ),
//                                                                   Container(
//                                                                     child: Column(
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment.start,
//                                                                       children: [
//                                                                         visitData.prospectName == null
//                                                                             ? Text(
//                                                                           "No Data",
//                                                                           style: TextStyle(
//                                                                             fontSize: 12,
//                                                                             color: Colors.black54,
//                                                                             fontWeight:
//                                                                             FontWeight.bold,
//                                                                           ),
//                                                                         )
//                                                                             : Text(
//                                                                           visitData.prospectName!,
//                                                                           style: TextStyle(
//                                                                             fontSize: 12,
//                                                                             color: Colors.black54,
//                                                                             fontWeight:
//                                                                             FontWeight.bold,
//                                                                           ),
//                                                                         ),
//                                                                         // Container(
//                                                                         //   height: 25,
//                                                                         //   width: MediaQuery.of(context).size.width * .6,
//                                                                         //   child: Text(
//                                                                         //
//                                                                         //     getProspectAdrs(
//                                                                         //         visitData
//                                                                         //             .prospectId!,
//                                                                         //         StaticData
//                                                                         //             .prosepctList),
//                                                                         //     style: TextStyle(
//                                                                         //       fontSize: 10,
//                                                                         //       color: Colors
//                                                                         //           .black54,
//                                                                         //     ),
//                                                                         //     maxLines: 2,
//                                                                         //   ),
//                                                                         // ),
//                                                                         Container(
//                                                                             height: 5,
//                                                                             width: 200,
//                                                                             child: Divider(
//                                                                               thickness: 1,
//                                                                               color: Colors.grey,
//                                                                             )),
//                                                                         Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               "Visted by: ",
//                                                                               style: TextStyle(
//                                                                                   fontSize: 9,
//                                                                                   color: Colors.black,
//                                                                                   fontWeight:
//                                                                                   FontWeight.bold),
//                                                                             ),
//                                                                             Text(
//                                                                               "${visitData.employeeName}",
//                                                                               style: TextStyle(
//                                                                                 fontSize: 10,
//                                                                                 color: Colors.black54,
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                         Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               "Address: ",
//                                                                               style: TextStyle(
//                                                                                   fontSize: 9,
//                                                                                   color: Colors.black,
//                                                                                   fontWeight:
//                                                                                   FontWeight.bold),
//                                                                             ),
//                                                                             Container(
//                                                                               width:
//                                                                               MediaQuery.of(context)
//                                                                                   .size
//                                                                                   .width *
//                                                                                   .5,
//                                                                               child: Center(
//                                                                                 child: InkWell(
//                                                                                   onTap: () {
//                                                                                     print("my lat lon are ${visitData.latitude}and ${visitData.longitude}");
//                                                                                     Get.toNamed(
//                                                                                         Routes.MAPVIEW,
//                                                                                         arguments: [
//                                                                                           visitData
//                                                                                               .latitude,
//                                                                                           visitData
//                                                                                               .longitude
//                                                                                         ]);
//                                                                                   },
//                                                                                   child: Text(
//                                                                                     maxLines: 2,
//                                                                                     visitData
//                                                                                         .locationDescription!,
//                                                                                     style: TextStyle(
//                                                                                         fontSize: 10,
//                                                                                         color: Colors
//                                                                                             .blue),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               }),
//                                         )
//                                       ],
//                                     ),
//                                   ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              )

      );

  }
}
//
