import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:salebee_latest/modules/lead/view/all_lead_view.dart';
import 'package:salebee_latest/modules/lead/view/my_lead_view.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class LeadView extends GetView<ProspectController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lead"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.ADDLEAD);
        },
        child: Icon(Icons.add),
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
                                text: 'My Lead',
                              ),
                              Tab(
                                text: 'Lead Dashboard',
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
                        child: MyLeadView(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: AllLeadView(),
                      ),
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
