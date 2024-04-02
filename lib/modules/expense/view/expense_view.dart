import 'dart:math';
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
import 'package:salebee_latest/modules/expense/view/wdget/amount_widget.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/lead/controller/lead_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class ExpenseView extends GetView<ExpenseController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Expense"),
        ),
        body: Obx(() {
          if (controller.getAllExpenseModel.value.result!.data.isEmpty) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.ADDEXPENSE);
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Expense'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textColorBlack,
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: AppColors.textColorBlack,
                      size: 14,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        //height: 180,
                        width: Get.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // controller.changeState();
                                    },
                                    child: Container(
                                      height: 145,
                                      width: Get.width * .45,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.blue,
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                            height: 145,
                                            width: 145,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.blue,
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        // const Image(
                                                        //   height: 15,
                                                        //   width: 15,
                                                        //   image: AssetImage('assets/images/taka.png'),
                                                        //   color: Colors.white,

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2.0,
                                                                  right: 5),
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: Text(
                                                              controller
                                                                  .getAllExpenseModel
                                                                  .value
                                                                  .result!
                                                                  .statusCount[
                                                                      0]
                                                                  .totalAmount
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Total Claimed'.tr,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .textColorWhite,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Center(
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                // const Image(
                                                                //   height: 15,
                                                                //   width: 15,
                                                                //   image: AssetImage('assets/images/taka.png'),
                                                                //   color: Colors.white,

                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2.0,
                                                                      right: 5),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    child: Text(
                                                                      controller
                                                                          .getAllExpenseModel
                                                                          .value
                                                                          .result!
                                                                          .statusCount[
                                                                              1]
                                                                          .totalAmount
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Approved'.tr,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .textColorWhite,
                                                            fontSize: 12,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Center(
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                // const Image(
                                                                //   height: 15,
                                                                //   width: 15,
                                                                //   image: AssetImage('assets/images/taka.png'),
                                                                //   color: Colors.white,

                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2.0,
                                                                      right: 5),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    child: Text(
                                                                      controller
                                                                          .getAllExpenseModel
                                                                          .value
                                                                          .result!
                                                                          .statusCount[
                                                                              3]
                                                                          .totalAmount
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Paid'.tr,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .textColorWhite,
                                                            fontSize: 12,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Center(
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                // const Image(
                                                                //   height: 15,
                                                                //   width: 15,
                                                                //   image: AssetImage('assets/images/taka.png'),
                                                                //   color: Colors.white,

                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2.0,
                                                                      right: 5),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    child: Text(
                                                                      controller
                                                                          .getAllExpenseModel
                                                                          .value
                                                                          .result!
                                                                          .statusCount[
                                                                              2]
                                                                          .totalAmount
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Rejected'.tr,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .textColorWhite,
                                                            fontSize: 12,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.ADDEXPENSE);
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.textColorWhite,
                                            size: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Add Expense'.tr,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.textColorBlack,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                              //Right Side 3 Item
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AmountWidget(
                                    image: 'images/food.png',
                                    amount: controller.getAllExpenseModel.value
                                        .getTotalAmount(
                                          specificType: "Food",
                                        )
                                        .toString(),
                                    title: 'Food'.tr,
                                    padding: "10",
                                    //  colors: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  AmountWidget(
                                      image: 'images/transportation.png',
                                      amount:
                                          controller.getAllExpenseModel.value
                                              .getTotalAmount(
                                                specificType: "Transport",
                                              )
                                              .toString(),
                                      // colors: Colors.white,
                                      title: 'Transport'.tr,
                                      padding: "3"),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  AmountWidget(
                                      image: 'images/Icons/other1.png',
                                      amount:
                                          controller.getAllExpenseModel.value
                                              .getTotalAmount(
                                                specificType: "Others",
                                              )
                                              .toString(),
                                      // colors: Colors.blue,
                                      title: 'Other'.tr,
                                      padding: "10"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultTabController(
                    length: 4,
                    child: SafeArea(
                      child: Container(
                        color: AppColors.backgroundColor,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TabBar(
                                      onTap: (i) {
                                        if (i == 3) {
                                          Get.put(EmployeeController());
                                        }
                                      },
                                      indicatorColor: AppColors.colorBlue,
                                      labelColor: AppColors.colorBlue,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      unselectedLabelStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      tabs: [
                                        Tab(
                                          text: 'Claimed',
                                        ),
                                        Tab(
                                          text: 'Approved',
                                        ),
                                        Tab(
                                          text: 'Rejected',
                                        ),
                                        Tab(
                                          text: 'Paid',
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Expanded(child: Container())
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height * .5,
                              child: TabBarView(children: [
                                Container(
                                  height: Get.height * .4,
                                  child:
                                      controller.filteredAllExpenseList
                                              .where((element) =>
                                                  element.status == "Pending")
                                              .isEmpty
                                          ? Center(child: Text("No Data"))
                                          : ListView.builder(
                                              itemCount: controller
                                                  .filteredAllExpenseList
                                                  .where((element) =>
                                                      element.status ==
                                                      "Pending")
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var data = controller
                                                    .filteredAllExpenseList
                                                    .where((element) =>
                                                        element.status ==
                                                        "Pending")
                                                    .toList()[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              data.expenseType ==
                                                                      "Food"
                                                                  ? Container(
                                                                      width: 65,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Image(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            image:
                                                                                AssetImage("images/food.png"),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                              data.expenseType!.toString(),
                                                                              maxLines: 1,
                                                                              style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : data.expenseType ==
                                                                          "Transport"
                                                                      ? Container(
                                                                          width:
                                                                              65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height: 25,
                                                                                width: 25,
                                                                                image: AssetImage("images/transportation.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 4,
                                                                              ),
                                                                              Text(data.expenseType!.toString(), maxLines: 1, style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width:
                                                                              65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height: 25,
                                                                                width: 25,
                                                                                image: AssetImage("images/more.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 4,
                                                                              ),
                                                                              Text(data.expenseType!.toString(), maxLines: 1, style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        ),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        .55,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                    data.description ==
                                                                            null
                                                                        ? Text(
                                                                            "No Details")
                                                                        : Text(data
                                                                            .description!
                                                                            .toString()),
                                                                    Text(data
                                                                        .cost!
                                                                        .toString()),
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                    Text(data
                                                                        .claimedByName!
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 42,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  width: 75,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "${DateFormat('EEEE').format(data.expenseDate!).toString().substring(0, 3)},",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                            Center(
                                                                              child: Text(
                                                                                " ${data.expenseDate.toString().substring(8, 10)}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('MMM').format(data.expenseDate!),
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Card(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.jm().format(data.expenseDate!),
                                                                                style: TextStyle(fontSize: 8),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Get.find<HomeController>().isExpenseVisible.value == false ? Container():
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                          data
                                                                              .id,
                                                                      statusId:
                                                                          2);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                        Get.height *
                                                                            .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                                .3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Approved"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                          data
                                                                              .id,
                                                                      statusId:
                                                                          3);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                        Get.height *
                                                                            .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(
                                                                                .3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Rejected"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                          data
                                                                              .id,
                                                                      statusId:
                                                                          4);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                        Get.height *
                                                                            .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green
                                                                            .withOpacity(
                                                                                .3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Paid"))),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                ),
                                Container(
                                  height: Get.height * .4,
                                  child:
                                      controller.filteredAllExpenseList
                                              .where((element) =>
                                                  element.status == "Approved")
                                              .isEmpty
                                          ? Center(child: Text("No Data"))
                                          : ListView.builder(
                                              itemCount: controller
                                                  .filteredAllExpenseList
                                                  .where((element) =>
                                                      element.status ==
                                                      "Approved")
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var data = controller
                                                    .filteredAllExpenseList
                                                    .where((element) =>
                                                        element.status ==
                                                        "Approved")
                                                    .toList()[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              data.expenseType ==
                                                                      "Food"
                                                                  ? Container(
                                                                      width: 65,
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Image(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            image: AssetImage(
                                                                                "images/food.png"),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                              data.expenseType!
                                                                                  .toString(),
                                                                              maxLines:
                                                                                  1,
                                                                              style: TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 9,
                                                                                  color: AppColors.textColorBlack,
                                                                                  fontWeight: FontWeight.w500))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : data.expenseType ==
                                                                          "Transport"
                                                                      ? Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/transportation.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/more.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        ),
                                                              Container(
                                                                width:
                                                                    Get.width * .55,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                    data.description ==
                                                                            null
                                                                        ? Text(
                                                                            "No Details")
                                                                        : Text(data
                                                                            .description!
                                                                            .toString()),
                                                                    Text(data.cost!
                                                                        .toString()),
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 42,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  6)),
                                                                  width: 75,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
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
                                                                            Text(
                                                                              "${DateFormat('EEEE').format(data.expenseDate!).toString().substring(0, 3)},",
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  5,
                                                                            ),
                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                            Center(
                                                                              child:
                                                                                  Text(
                                                                                " ${data.expenseDate.toString().substring(8, 10)}",
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                                style:
                                                                                    TextStyle(fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('MMM')
                                                                                  .format(data.expenseDate!),
                                                                              style:
                                                                                  TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Card(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.jm().format(data.expenseDate!),
                                                                                style:
                                                                                    TextStyle(fontSize: 8),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      1);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .purpleAccent
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Pending"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      3);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Rejected"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      4);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Paid"))),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                ),
                                Container(
                                  height: Get.height * .4,
                                  child:
                                      controller.filteredAllExpenseList
                                              .where((element) =>
                                                  element.status == "Rejected")
                                              .isEmpty
                                          ? Center(child: Text("No Data"))
                                          : ListView.builder(
                                              itemCount: controller
                                                  .filteredAllExpenseList
                                                  .where((element) =>
                                                      element.status ==
                                                      "Rejected")
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var data = controller
                                                    .filteredAllExpenseList
                                                    .where((element) =>
                                                        element.status ==
                                                        "Rejected")
                                                    .toList()[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              data.expenseType ==
                                                                      "Food"
                                                                  ? Container(
                                                                      width: 65,
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Image(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            image: AssetImage(
                                                                                "images/food.png"),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                              data.expenseType!
                                                                                  .toString(),
                                                                              maxLines:
                                                                                  1,
                                                                              style: TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 9,
                                                                                  color: AppColors.textColorBlack,
                                                                                  fontWeight: FontWeight.w500))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : data.expenseType ==
                                                                          "Transport"
                                                                      ? Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/transportation.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/more.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        ),
                                                              Container(
                                                                width:
                                                                    Get.width * .55,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                    data.description ==
                                                                            null
                                                                        ? Text(
                                                                            "No Details")
                                                                        : Text(data
                                                                            .description!
                                                                            .toString()),
                                                                    Text(data.cost!
                                                                        .toString()),
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 42,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  6)),
                                                                  width: 75,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
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
                                                                            Text(
                                                                              "${DateFormat('EEEE').format(data.expenseDate!).toString().substring(0, 3)},",
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  5,
                                                                            ),
                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                            Center(
                                                                              child:
                                                                                  Text(
                                                                                " ${data.expenseDate.toString().substring(8, 10)}",
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                                style:
                                                                                    TextStyle(fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('MMM')
                                                                                  .format(data.expenseDate!),
                                                                              style:
                                                                                  TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Card(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.jm().format(data.expenseDate!),
                                                                                style:
                                                                                    TextStyle(fontSize: 8),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      2);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Approved"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      1);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .purpleAccent
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Pending"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      4);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Paid"))),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                ),
                                Container(
                                  height: Get.height * .4,
                                  child:
                                      controller.filteredAllExpenseList
                                              .where((element) =>
                                                  element.status == "Paid")
                                              .isEmpty
                                          ? Center(child: Text("No Data"))
                                          : ListView.builder(
                                              itemCount: controller
                                                  .filteredAllExpenseList
                                                  .where((element) =>
                                                      element.status == "Paid")
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var data = controller
                                                    .filteredAllExpenseList
                                                    .where((element) =>
                                                        element.status ==
                                                        "Paid")
                                                    .toList()[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              data.expenseType ==
                                                                      "Food"
                                                                  ? Container(
                                                                      width: 65,
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Image(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            image: AssetImage(
                                                                                "images/food.png"),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                              data.expenseType!
                                                                                  .toString(),
                                                                              maxLines:
                                                                                  1,
                                                                              style: TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 9,
                                                                                  color: AppColors.textColorBlack,
                                                                                  fontWeight: FontWeight.w500))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : data.expenseType ==
                                                                          "Transport"
                                                                      ? Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/transportation.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width: 65,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Image(
                                                                                height:
                                                                                    25,
                                                                                width:
                                                                                    25,
                                                                                image:
                                                                                    AssetImage("images/more.png"),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    4,
                                                                              ),
                                                                              Text(
                                                                                  data.expenseType!.toString(),
                                                                                  maxLines: 1,
                                                                                  style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 9, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
                                                                            ],
                                                                          ),
                                                                        ),
                                                              Container(
                                                                width:
                                                                    Get.width * .55,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                    data.description ==
                                                                            null
                                                                        ? Text(
                                                                            "No Details")
                                                                        : Text(data
                                                                            .description!
                                                                            .toString()),
                                                                    Text(data.cost!
                                                                        .toString()),
                                                                    Text(data
                                                                        .expenseType!
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 42,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              .3),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  6)),
                                                                  width: 75,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
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
                                                                            Text(
                                                                              "${DateFormat('EEEE').format(data.expenseDate!).toString().substring(0, 3)},",
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  5,
                                                                            ),
                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                            Center(
                                                                              child:
                                                                                  Text(
                                                                                " ${data.expenseDate.toString().substring(8, 10)}",
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                                style:
                                                                                    TextStyle(fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('MMM')
                                                                                  .format(data.expenseDate!),
                                                                              style:
                                                                                  TextStyle(fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Card(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.jm().format(data.expenseDate!),
                                                                                style:
                                                                                    TextStyle(fontSize: 8),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      2);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Approved"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      3);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Rejected"))),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.updateExpenseStatus(
                                                                      expenseId:
                                                                      data
                                                                          .id,
                                                                      statusId:
                                                                      1);
                                                                },
                                                                child: Container(
                                                                    height:
                                                                    Get.height *
                                                                        .05,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .purpleAccent
                                                                            .withOpacity(
                                                                            .3),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                    width: 75,
                                                                    child: Center(
                                                                        child: Text(
                                                                            "Pending"))),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            );
          }
        }));
  }
}
//
