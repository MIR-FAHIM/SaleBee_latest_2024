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
                          child: Obx(
                           () {
                              return Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TabBar(
                                            onTap: (i){
                                              controller.getFollowUpByProsIdController(Get.find<ProspectController>().prosId.value, (i+1).toString());
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
                                                'Call',
                                              ),
                                              Tab(
                                                text:
                                                'Meesage',
                                              ),
                                              Tab(
                                                text:
                                                'Mail',
                                              ),
                                              Tab(
                                                text:
                                                'Meeting',
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
                                            child: controller.getFollowUpList.isEmpty ? Text("No Data")  :Container(
                                              height: Get.height * .7,
                                              child: ListView.builder(
                                                itemCount: controller.getFollowUpList.length,
                                                itemBuilder: (BuildContext context, index) {
                                                  var data = controller.getFollowUpList[index];

                                                      return Card(
                                                          child: Column(
                                                            children: [
                                                              ListTile(
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
                                                                                    .format(data.createdOn!)
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
                                                                                  " " + data.createdOn.toString().substring(8, 10),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              Text(DateFormat('MMM')
                                                                                  .format(data.createdOn!)
                                                                                  .toString()
                                                                                  .substring(0, 3)),
                                                                            ],
                                                                          ),
                                                                          Card(
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  DateFormat.jm().format(data.createdOn!),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ),
                                                              ListTile(
                                                                title: Text("Created by -${data.createdBy}",style: TextStyle(color: Colors.purpleAccent),),
                                                                subtitle: Text("Assigned to -${data.assignToEmployeeName}",style: TextStyle(color: Colors.purple),),
                                                              )
                                                            ],
                                                          ));


                                                },
                                              ),
                                            ),
                                          ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: controller.getFollowUpList.isEmpty ? Text("No Data")  :Container(
                                          height: Get.height * .7,
                                          child: ListView.builder(
                                            itemCount: controller.getFollowUpList.length,
                                            itemBuilder: (BuildContext context, index) {
                                              var data = controller.getFollowUpList[index];

                                              return Card(
                                                  child: Column(
                                                    children: [
                                                      ListTile(
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
                                                                            .format(data.createdOn!)
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
                                                                          " " + data.createdOn.toString().substring(8, 10),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      ),
                                                                      Text(DateFormat('MMM')
                                                                          .format(data.createdOn!)
                                                                          .toString()
                                                                          .substring(0, 3)),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm().format(data.createdOn!),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      ListTile(
                                                        title: Text("Created by -${data.createdBy}",style: TextStyle(color: Colors.purpleAccent),),
                                                        subtitle: Text("Assigned to -${data.assignToEmployeeName}",style: TextStyle(color: Colors.purple),),
                                                      )
                                                    ],
                                                  ));


                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: controller.getFollowUpList.isEmpty ? Text("No Data")  :Container(
                                          height: Get.height * .7,
                                          child: ListView.builder(
                                            itemCount: controller.getFollowUpList.length,
                                            itemBuilder: (BuildContext context, index) {
                                              var data = controller.getFollowUpList[index];

                                              return Card(
                                                  child: Column(
                                                    children: [
                                                      ListTile(
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
                                                                            .format(data.createdOn!)
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
                                                                          " " + data.createdOn.toString().substring(8, 10),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      ),
                                                                      Text(DateFormat('MMM')
                                                                          .format(data.createdOn!)
                                                                          .toString()
                                                                          .substring(0, 3)),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm().format(data.createdOn!),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      ListTile(
                                                        title: Text("Created by -${data.createdBy}",style: TextStyle(color: Colors.purpleAccent),),
                                                        subtitle: Text("Assigned to -${data.assignToEmployeeName}",style: TextStyle(color: Colors.purple),),
                                                      )
                                                    ],
                                                  ));


                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: controller.getFollowUpList.isEmpty ? Text("No Data")  :Container(
                                          height: Get.height * .7,
                                          child: ListView.builder(
                                            itemCount: controller.getFollowUpList.length,
                                            itemBuilder: (BuildContext context, index) {
                                              var data = controller.getFollowUpList[index];

                                              return Card(
                                                  child: Column(
                                                    children: [
                                                      ListTile(
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
                                                                            .format(data.createdOn!)
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
                                                                          " " + data.createdOn.toString().substring(8, 10),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      ),
                                                                      Text(DateFormat('MMM')
                                                                          .format(data.createdOn!)
                                                                          .toString()
                                                                          .substring(0, 3)),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm().format(data.createdOn!),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      ListTile(
                                                        title: Text("Created by -${data.createdBy}",style: TextStyle(color: Colors.purpleAccent),),
                                                        subtitle: Text("Assigned to -${data.assignToEmployeeName}",style: TextStyle(color: Colors.purple),),
                                                      )
                                                    ],
                                                  ));


                                            },
                                          ),
                                        ),
                                      ),

                                    ]),
                                  ),
                                ],
                              );
                            }
                          ),
                        ),
                      )),
                ],
              )

      );

  }
}
//
