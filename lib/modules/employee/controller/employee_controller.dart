import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/all_emp_model.dart';
import 'package:salebee_latest/models/auth/get_all_prospect_by_id_model.dart';
import 'package:salebee_latest/models/auth/get_lead_model.dart';
import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/prospect_status_model.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textPwdController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final stausID = 0.obs;
  final checkedValue = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final fcmtoken = "".obs;
  final searchType = "".obs;
  final searchString = "".obs;
  final empList = <EmpResults>[].obs;

  @override
  Future<void> onInit() async {
getEmpController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  launchWhatsapp(String num) async {
    var whatsapp = "+88${num}";
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=hello Sir");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      Get.showSnackbar(Ui.errorSnackBar(
          message: 'No Whatsup'.tr, title: 'Error'.tr));
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  textMe(num) async {
    // Android
    var uri = 'sms:+88${num.toString()}?body= Hellow Sir';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:+8801782084390?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  getEmpController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };
    AllRepository().getEmployee(body).then((value) {
      print("my emp list is $value");

      final model = AllEmployeeListModel.fromJson(value);

      empList.value = model.results!;
      print("my emp are ${empList.length}");

    });
  }


  String getEmployeeNameById(int employeeId) {
    // Iterate through empList to find the employee with the given ID
    for (EmpResults employee in empList) {
      if (employee.employeeId == employeeId) {
        return employee.employeeName ?? "Unknown"; // Return the employee's name if found
      }
    }

    // Return a default value if the employee with the given ID is not found
    return "Unknown";
  }


  List<EmpResults> get filteredEmpList {
    if(searchString.value.isNotEmpty){
      return empList.value.where((data) {
        final status = data.employeeName.toString();

        final searchTerm = searchString.value;

        return status! == searchTerm;
      }).toList();
    }else {
      return  empList.value;
    }



  }

  void setSearchText(String text, String type) {
    searchString.value = text;
  }
}
