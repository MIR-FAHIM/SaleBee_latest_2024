import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:salebee_latest/models/auth/get_visit_model.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/new_prospect_list_model.dart';
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
import 'package:http/http.dart' as http;

class ProspectController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textPwdController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final locationDis = "".obs;
  final prosId = "".obs;

  final stausID = 0.obs;
  final checkedValue = false.obs;
  final load = false.obs;
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

  final getNewProspect = <ProspectList>[].obs;
  final getStatus = <ResultStatus>[].obs;
  @override
  Future<void> onInit() async {
    if (Get.find<AuthService>().checkProspectBool.value == true) {
      Get.find<AuthService>().getProspectList();
    } else {
      getNewProspectListController();
    }

    getProspectStatus();
    getAddressFromLatLng(
      Get.find<LocationService>().currentLocation['lat'],
      Get.find<LocationService>().currentLocation['lng'],
    );

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
          Ui.errorSnackBar(message: 'No Whatsapp'.tr, title: 'Error'.tr));
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

  launchURL(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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

  getNewProspectListController() {
    load.value = true;
    AllRepository()
        .getNewProspectList(
      Get.find<AuthService>().currentUser.value.result!.userToken!,
    )
        .then((value) {
      print("my new prospect list is $value");

      final model = ProspectNewListModel.fromJson(value);
      print("my new prospect list is ${model.result!.prospects!.length}");
      Get.find<AuthService>().setProspect(model);
      getNewProspect.value = model.result!.prospects;

      print("my new prospect are ${getNewProspect.value.length}");
      load.value = false;
      Get.find<AuthService>().getProspectList();
    });
  }

  getProspectStatus() {
    var token = Get.find<AuthService>().currentUser.value.result!.userToken!;
    String encodedToken = Uri.encodeComponent(token);
    AllRepository().getProspectStatus(encodedToken).then((value) {
      print("my prospect status list is $value");

      final model = ProspectStatusModel.fromJson(value);

      getStatus.value = model.result!;
      print("my prospect status are ${getStatus.value.length}");
    });
  }

  updateProspectStatus(id, stage) {
    var token = Get.find<AuthService>().currentUser.value.result!.userToken!;
    String encodedToken = Uri.encodeComponent(token);
    AllRepository().updateProspectStatus(encodedToken, id, stage).then((value) {
      print("my prospect status update is $value");
      if (value["IsSuccess"] == true) {
        Get.showSnackbar(
            Ui.successSnackBar(message: value['Message'], title: 'Success'.tr));

        getNewProspectListController();
      }
    });
  }

  getAddressFromLatLng(double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        String _area =
            data["results"][0]["address_components"][1]["short_name"];
        print("response ==== $_formattedAddress");
        locationDis.value = _area + ", " + _formattedAddress;
        return locationDis.value;
      } else {
        return locationDis.value;
      }
    }
  }

  addVisitController(int? prospectId, String? prospectName) {
    Map<String, dynamic> body = {
      "Id": 0,
      "EmployeeId":
          Get.find<AuthService>().currentUser.value.result!.employeeId!,
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
      "LocationDescription": locationDis.value,
      "LeadName": "No Data",
      "ProspectName": prospectName,
      "ProspectAddress": "No Data",
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
      if (e["Message"] == "Add successfully") {
        Get.showSnackbar(Ui.successSnackBar(
            message: 'Visit Added for $prospectName', title: 'Success'.tr));
      }
    });
  }

  List<ProspectList> get filteredProspectList {
    if (searchString.value.isNotEmpty) {
      if (searchType.value == "search") {
        if (Get.find<AuthService>().getNewProspectLocal.value.isEmpty) {
          return getNewProspect.value;
        } else {
          return Get.find<AuthService>()
              .getNewProspectLocal
              .value
              .where((data) {
            final title = data.name.toLowerCase().toString();

            final searchTerm = searchString.value;

            return title.contains(searchTerm);
          }).toList();
        }
      } else {
        if (Get.find<AuthService>().getNewProspectLocal.value.isEmpty) {
          return getNewProspect.value;
        } else {
          return Get.find<AuthService>()
              .getNewProspectLocal
              .value
              .where((data) {
            final status = data.stage.toString();

            final searchTerm = searchString.value;

            return status! == searchTerm;
          }).toList();
        }
      }
    } else {
      return Get.find<AuthService>().getNewProspectLocal;
    }
  }

  void setSearchText(String text, String type) {
    searchString.value = text;
    searchType.value = type;
  }
}
