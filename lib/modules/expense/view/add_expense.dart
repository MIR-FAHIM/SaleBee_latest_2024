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
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';

import '../../../common/ui.dart';
import '../../../models/auth/new_prospect_list_model.dart';

class AddExpenseView extends GetView<ExpenseController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Expense"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.expenseTypeS.value = "Food";
                        },
                        child: Container(
                          width: Get.width * .3,
                          height: Get.height * .05,
                          decoration: BoxDecoration(
                            color:controller.expenseTypeS.value == "Food" ?  Colors.orange[500] : Colors.blue[500],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Food",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.expenseTypeS.value = "Transport";
                        },
                        child: Container(
                          width: Get.width * .3,
                          height: Get.height * .05,
                          decoration: BoxDecoration(
                            color:controller.expenseTypeS.value == "Transport" ?  Colors.orange[500] : Colors.blue[500],

                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Transport",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.expenseTypeS.value = "Others";
                        },
                        child: Container(
                          width: Get.width * .3,
                          height: Get.height * .05,
                          decoration: BoxDecoration(
                            color:controller.expenseTypeS.value == "Others" ?  Colors.orange[500] : Colors.blue[500],

                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Others",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.expenseTypeS.value == "Food"
                      ? AddFoodExView()
                      : controller.expenseTypeS.value == "Transport"
                          ? AddExpenseTransportView()
                          : AddOtherExView()
                ],
              ),
            ),
          );
        }));
  }
}
//
