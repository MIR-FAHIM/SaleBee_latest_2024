import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/get_all_prospect_by_id_model.dart';
import 'package:salebee_latest/models/auth/get_followup_by_pros_id_model.dart';
import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUpController extends GetxController {
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
  final  callList =<Call>[].obs;
  final  smsList =<Sm>[].obs;
  final getAllVisit = <Resultvisit>[].obs;
  final  meetingList =<Call>[].obs;
  final  othersList =<Call>[].obs;
  final  emailList =<Call>[].obs;
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
  final getFollowUpListByPros = ResultFollowUpByPros().obs;
  @override
  Future<void> onInit() async {
getVisitController();
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
  getFollowUpByProsIdController(String? prosId) {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": prosId,
    };
    AllRepository().getFollowUpById(body).then((value) {
      print("my followup list of $prosId ---- $value");

      final model = FollowUpByProsIdModel.fromJson(value);

      getFollowUpListByPros.value = model.result!;
      callList.value = model.result!.call!;
      smsList.value = model.result!.sms!;
      emailList.value = model.result!.email!;
      othersList.value = model.result!.others!;


      print("my follow up model are ${getFollowUpListByPros.value.call}");
      print("my calll model are ${callList.value.length}");
      print("my calll model are ${callList.value[0].description!}");
      if(callList.value.isEmpty){
        Get.showSnackbar(Ui.errorSnackBar(
            message: 'No Data', title: 'error'.tr));
      }else{
        Get.offNamed(Routes.FOLLOWUPVIEW, arguments: [
          {
         "call":   callList.value,
         "email":   emailList.value,
         "other":   othersList.value,
         "sms":   smsList.value,
            "visit": getAllVisit.value.where((element) => element.prospectId == int.parse(prosId!) ),
          }
        ]);
      }



    });
  }

  addVisitController(String? prospectId, String? prospectName) {
    Map<String, dynamic> body = {
      "Id": DateTime.now().millisecond,
      "EmployeeId":
      Get.find<AuthService>().currentUser.value.result!.employeeId!,
      "Latitude": "0.00000",
      "Longitude": "0.000000",
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
      "LeadName": "string",
      "ProspectName": prospectName,
      "FollowupType": 0,
      "IsLogIn": true,
      "LocationDescription": "location",
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": DateTime.now().toString(),
      "UpdatedBy": 0,
      "UpdatedOn": "2022-12-15T10:28:24.418Z",
      "IsDeleted": true
    };

    AllRepository().addVisit(body).then((e) {});
  }

  List<MyTaskResult> get filteredMyTaskList {
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
