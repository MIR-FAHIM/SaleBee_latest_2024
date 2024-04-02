import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/models/auth/get_all_prospect_by_id_model.dart';
import 'package:salebee_latest/models/auth/get_lead_model.dart';
import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/product_model.dart';
import 'package:salebee_latest/models/auth/prospect_status_model.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/services/services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final leadNameController = TextEditingController().obs;
  final estimatedController = TextEditingController().obs;
  final commentController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final stausID = 0.obs;
  final productId = 0.obs;
  final selectedDate = DateTime.now().obs;
  final myFormat = DateFormat('dd-MM-yyyy').obs;
  final prosID = 0.obs;
  final productModel = ProductModel().obs;
  final empID = 0.obs;
  final getProducts = <Product>[].obs;
  final checkedValue = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final fcmtoken = "".obs;
  final prospectName = "".obs;
  final searchType = "".obs;
  final searchString = "".obs;
  final dropdownValue = DateTime.now().year.toString().obs;
  final monthSelection =
      int.parse(DateTime.now().toString().substring(5, 7)).obs;
  final yearSelection =
      int.parse(DateTime.now().toString().substring(0, 4)).obs;
  final daySelection =
      int.parse(DateTime.now().toString().substring(8, 10)).obs;
  List<String> yearList = <String>[
    DateTime.now().year.toString(),
    DateTime(DateTime.now().year - 1).toString().substring(0, 4),
    DateTime(DateTime.now().year - 2).toString().substring(0, 4)
  ];
  final tabs = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final dayTab = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ].obs;
  final statusList = <String>[
    'Change Status',
    'Cancelled',
    'Done',
    'Incomplete',
    'Initiated',
    'Need More Time',
    'Need Others help',
    'Partially done'
  ].obs;
  final checkTerm = false.obs;
  final menuItems = [
    'Expense',
    'Task',
    'Attendance',
    'Lead',
    'Prospect',
    'Settings',
    'Accounts'
  ].obs;
  final focusedIndex = 0.obs;
  final myTaskList = <MyTaskResult>[].obs;
  final getLeadList = <ResultLead>[].obs;
  final getStatus = <ResultStatus>[].obs;
  @override
  Future<void> onInit() async {
    Get.put(EmployeeController());
    Get.put(ProspectController());
    getLeadController();
    getLeadStatus();
    getProductController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  List<DropdownMenuItem<String>> dropDownItem() {
    //  print("my all status in dropdown is $listStatus");

    // listStatus.forEach((element) {
    //   statusList.add(element);
    // });

    return statusList!
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  launchWhatsapp(String num) async {
    var whatsapp = "+88${num}";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello Sir");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      Get.showSnackbar(
          Ui.errorSnackBar(message: 'No Whatsup'.tr, title: 'Error'.tr));
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


InputCheckResult inputCheck(BuildContext context, {
  required String? name,
  required String? amount,
  required String? dropdownValue,
  required DateTime? selectedDate,
}) {
  if (name == null || name.isEmpty ||
      amount == null || amount.isEmpty ||
      dropdownValue == null || dropdownValue.isEmpty ||
      selectedDate == null) {
    Get.showSnackbar(
        Ui.errorSnackBar(message: 'Please check all the field'.tr, title: 'Error'.tr));

    return InputCheckResult.Error;
  }

  // All data is valid
  return InputCheckResult.Success;
}
  getLeadController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };
    AllRepository().getLead(body).then((value) {
      print("my lead list is $value");

      final model = GetLeaddModel.fromJson(value);

      getLeadList.value = model.result!;
      print("my lead are ${getLeadList.value.length}");
    });
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
  addLeadController() {
    Map body = {
      "ID": 0,
      "LeadDate": selectedDate.value.toString(),
      "ProspectID": prosID.value.toString(),
      "LeadName": leadNameController.value.text,
      "EstimatedClosingDate": "2024-03-31T05:05:26.694Z",
      "EstimatedClosingAmount": estimatedController.value.text,
      "AssignedPerson": empID.value.toString(),
      "LeadStage": 1,
      "StageDate": "2024-03-31T05:05:26.694Z",
      "Comments": commentController.value.text,
      "Priority": 1,
      "ProjectLocation": "string",
      "ProjectType": "string",
      "AreaSft": 0,
      "LeadItems": [productId.value],
      "LeadConcernPersons": [
        {"ConcernPersonId": 0, "InfluencingRoleId": 0, "IsPrimary": true}
      ],
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };
    AllRepository().addLead(body).then((value) {
      print("add lead $value");
      if(value['IsSuccess'] == true){
        Get.showSnackbar(Ui.successSnackBar(
            message: value['Message'], title: 'Success'.tr));
        getLeadController();
      }else{
        Get.showSnackbar(Ui.successSnackBar(
            message: "Something went wrong", title: 'Error'.tr));
      }

    });
  }


  getProductController() {
    Map body = {
        "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    "Data": {}
  };
    AllRepository().getProduct(body).then((value) {
      print("get Product +++++++++ $value");
      productModel.value = ProductModel.fromJson(value);
      getProducts.value = productModel.value.result!.data;
      print("my products are ${getProducts.value.length}");
    });
  }

  getLeadStatus() {
    var token = Get.find<AuthService>().currentUser.value.result!.userToken!;
    String encodedToken = Uri.encodeComponent(token);
    AllRepository().getLeadStatus(encodedToken).then((value) {
      print("my lead status list is $value");

      final model = ProspectStatusModel.fromJson(value);

      getStatus.value = model.result!;
      print("my lead status are ${getStatus.value.length}");
    });
  }

  List<ResultLead> get filteredLeadList {
    if (searchString.value.isNotEmpty) {
      return getLeadList.where((data) {
        final status = data.stageName.toString();

        final searchTerm = searchString.value;

        return status! == searchTerm;
      }).toList();
    } else {
      return getLeadList;
    }
  }

  void setSearchText(String text, String type) {
    searchString.value = text;
  }
}
