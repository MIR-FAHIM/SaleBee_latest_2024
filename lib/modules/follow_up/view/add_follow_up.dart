import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/common/custom_data.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/expense/controller/expense_controller.dart';
import 'package:salebee_latest/modules/expense/view/add_food_expense.dart';
import 'package:salebee_latest/modules/expense/view/add_transport_expense.dart';
import 'package:salebee_latest/modules/expense/view/other_expense_add.dart';
import 'package:salebee_latest/modules/follow_up/controller/follow_up_controller.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';

import '../../../common/ui.dart';
import '../../../models/auth/new_prospect_list_model.dart';

class AddFollowUpView extends GetView<FollowUpController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add FollowUp"),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          );
        }));
  }
}
//
