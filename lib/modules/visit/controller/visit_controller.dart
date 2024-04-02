import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitController extends GetxController {
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
  final getAllVisit = <Resultvisit>[].obs;
  final getEmpVisit = <Resultvisit>[].obs;
  @override
  Future<void> onInit() async {
    getVisitController();
    getVisitByEmpController();
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

  getVisitController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };
    AllRepository().getVisit(body).then((value) {
      print("my visit list is $value");

        final model = GetVisitListModel.fromJson(value);

        getAllVisit.value = model.result!;
        print("my visit are ${myTaskList.value.length}");

    });
  }
  getVisitByEmpController() {
    Map body =   {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": Get.find<AuthService>().currentUser.value.result!.employeeId!,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2024-02-20T05:08:24.599Z",
      "ToDate": "2024-02-20T05:08:24.599Z"
    };
    AllRepository().getEmpIdVisit(body).then((value) {
      print("emp id by visit list is $value");

        final model = GetVisitListModel.fromJson(value);

        getEmpVisit.value = model.result!;
        print("emp id by visit are ${getEmpVisit.value.length}");

    });
  }

  addVisitController(int? prospectId, String? prospectName) {
    Map<String, dynamic> body = {
      "Id": 0,
      "EmployeeId":  Get.find<AuthService>().currentUser.value.result!.employeeId!,
      "Latitude": Get.find<LocationService>().currentLocation['lat'],
      "Longitude": Get.find<LocationService>().currentLocation['lng'],
      "LocationTime": DateTime.now().toString(),
      "IMEI": "string",
      "IP": "string",
      "Brand": "string",
      "Model": "string",
      "OS": "string",
      "BatteryStatus": "string",
      "OSVersion": "string",
      "Note": "string",
      "ProspectId": prospectId,
      "LeadId": 0,
      "LocationDescription": "string",
      "LeadName": "No Data",
      "ProspectName": prospectName,
      "ProspectAddress": "string",
      "EmployeeName": "string",
      "FollowupType": 0,
      "IsLogIn": true,
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2024-02-22T08:12:23.386Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2024-02-22T08:12:23.386Z",
      "IsDeleted": true
    };

    AllRepository().addVisit(body).then((e) {
      if(e['Message']== "Add successfully"){
        Get.showSnackbar(Ui.successSnackBar(
            message: "Visit added successfully", title: 'Success'.tr));
      }
    });
  }

  List<MyTaskResult> get filteredVisitList {
    if (searchString.value.isEmpty) {
      return myTaskList.value;
    } else if (searchType.value == "date") {
      return myTaskList.where((data) {
        final status = data.dueDate;

        final searchTerm = DateTime.parse(searchString.value);

        return status!.day == searchTerm.day &&
            status!.month == searchTerm.month &&
            status!.year == searchTerm.year;
      }).toList();
    } else if (searchString.value.isNum) {
      return myTaskList.where((data) {
        final status = data.statusId.toString();

        final searchTerm = searchString.value;

        return status! == searchTerm;
      }).toList();
    } else {
      return myTaskList.where((data) {
        final status = data.taskType.toString();

        final searchTerm = searchString.value;

        return status! == searchTerm;
      }).toList();
    }
  }

  void setSearchText(String text, String type) {
    searchString.value = text;
  }
}
