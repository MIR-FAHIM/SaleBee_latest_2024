import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/task/view/all_task.dart';
import 'package:salebee_latest/modules/task/view/my_task.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class TaskView extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Tasks"),
        ),
        body: DefaultTabController(
            length: 4,
            child: SafeArea(
              child: Container(
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
                              onTap: (i){
                                if(i == 0){
                                  controller.getAllTaskController(operation: "MyTask");
                                }if(i == 1){
                                  controller.getAllTaskController(operation: "AssignedToMe");
                                }if(i == 2){
                                  controller.getAllTaskController(operation: "AssignedByMe");
                                }if(i == 3){
                                  controller.getAllTaskController();
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
                                      'My Task',
                                ),
                                Tab(
                                  text:
                                      'Assigned to me',
                                ),
                                Tab(
                                  text:
                                      'Assigned by me',
                                ),
                                Tab(
                                  text:
                                      'All',
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
                          child: AllTaskView(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: AllTaskView(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: AllTaskView(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: AllTaskView(),
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
