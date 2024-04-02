import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/common/custom_data.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/expense/controller/expense_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';

import '../../../common/ui.dart';
import '../../../models/auth/new_prospect_list_model.dart';


class AddOtherExView extends GetWidget<ExpenseController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
            () {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Person',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      // _productController.searchProduct(value);
                                    },
                                    controller: controller.personController.value,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefix: Container(
                                        width: 20,
                                      ),
                                      hintText: 'Number of person',
                                      hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'Roboto',
                                          color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cost',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 140,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      // _productController.searchProduct(value);
                                    },
                                    controller: controller.pricingController.value,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefix: Container(
                                        width: 20,
                                      ),
                                      hintText: 'Type amount',
                                      hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'Roboto',
                                          color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                                // Expanded(
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         border:
                                //             Border.all(color: Colors.grey, width: 1.5),
                                //         borderRadius: const BorderRadius.all(
                                //             Radius.circular(10.0))),
                                //     child: TextFormField(
                                //       onChanged: (value) {
                                //         // _productController.searchProduct(value);
                                //       },
                                //       keyboardType: TextInputType.number,
                                //       decoration: InputDecoration(
                                //         suffixIcon: const Icon(Icons.access_time),
                                //         prefix: Container(
                                //           width: 20,
                                //         ),
                                //         hintText: 'Enter Time',
                                //         // icon:
                                //
                                //         hintStyle: const TextStyle(
                                //             fontSize: 14.0,
                                //             fontFamily: 'Roboto',
                                //             color: Colors.grey),
                                //         border: InputBorder.none,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Description (If Required)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      maxLines: 3,
                      controller: controller.wayDescriptionController.value,
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Type Details',
                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                            color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Related With (Prospect/Client)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    color: Colors.white,
                    child: DropdownSearch(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      dropdownSearchDecoration: Ui.getInputDecoration(
                        hintText: '',
                        iconData: CupertinoIcons.location_solid,
                      ),
                      showSelectedItems: true,
                      items: Get.find<ProspectController>().filteredProspectList
                          .map((item) => item.name!)
                          .toList(),
                      onChanged: (input) {
                        for (var item in Get.find<ProspectController>().filteredProspectList) {
                          if (item.name == input) {
                            controller.prosID.value =
                            item.id!;
                            print(
                                "my prospect id is ${controller.prosID.value}---${controller.prospectName.value}");
                          }
                        }

                      },
                      selectedItem: "Select Prospect",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectDate(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => Text(
                                    DateFormat.yMMMd()
                                        .format(controller.selectedDate.value),
                                    style:
                                    const TextStyle(color: Colors.grey),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Photos(Optional)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
showPopup(context, "expense");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(.35))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Tap to Upload')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                  BlockButtonWidget(
                    text:Text("Add Expense",),
                    color: Colors.blue,
                    radius: 10,
                    width: Get.width,
                    onPressed: (){

                      controller.addExpenseController();
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }
  showPopup(context, String type) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Photo Library'.tr),
                      onTap: () {
                        controller.getImageAndroid13(ImageSource.gallery, type);
                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      controller.getImageAndroid13(ImageSource.camera, type);
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          // actions: <Widget>[

          // ],
        );
      },
    );
  }
}
//
