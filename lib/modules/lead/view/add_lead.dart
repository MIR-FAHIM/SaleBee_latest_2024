import 'dart:io';
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
import 'package:salebee_latest/modules/lead/controller/lead_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/services.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';

import '../../../common/ui.dart';
import '../../../models/auth/new_prospect_list_model.dart';

class AddLeadView extends GetWidget<LeadController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Lead"),
        ),
        body: SingleChildScrollView(
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
                      width: Get.width * .9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lead Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: 50,
                            width: Get.width * .9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              controller: controller.leadNameController.value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Lead Name',
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width * .9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estimated Amount',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Container(
                            width: Get.width * .9,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              controller: controller.estimatedController.value,
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
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
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
                    items: controller.getProducts
                        .map((item) => item.productName!)
                        .toList(),
                    onChanged: (input) {
                      for (var item in controller.getProducts) {
                        if (item.productName == input) {
                          controller.productId.value = item.id;
                          print("product id---${controller.productId.value}");
                        }
                      }
                    },
                    selectedItem: "Select Items",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Comments (If Required)',
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
                    controller: controller.commentController.value,
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
                    items: Get.find<ProspectController>()
                        .filteredProspectList
                        .map((item) => item.name!)
                        .toList(),
                    onChanged: (input) {
                      for (var item in Get.find<ProspectController>()
                          .filteredProspectList) {
                        if (item.name == input) {
                          controller.prosID.value = item.id!;
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
                Text(
                  'Assign Person',
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
                    items: Get.find<EmployeeController>()
                        .filteredEmpList
                        .map((item) => item.employeeName!)
                        .toList(),
                    onChanged: (input) {
                      for (var item in Get.find<ProspectController>()
                          .filteredProspectList) {
                        if (item.name == input) {
                          controller.empID.value = item.id!;
                          print(
                              "my emp id is ++++++++++++++++++++ ${controller.empID.value}---");
                        }
                      }
                    },
                    selectedItem: "Select Employee",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                      DateFormat.yMMMd().format(
                                          controller.selectedDate.value),
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
                BlockButtonWidget(
                  text: Text(
                    "Add Lead",
                  ),
                  color: Colors.blue,
                  radius: 10,
                  width: Get.width,
                  onPressed: () {
                    InputCheckResult result = controller.inputCheck(context,
                        amount: controller.estimatedController.value.text,
                        name: controller.leadNameController.value.text,
                        selectedDate: controller.selectedDate.value,
                        dropdownValue: controller.prosID.value.toString());

                    if (result == InputCheckResult.Success) {
                      controller.addLeadController();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
//
