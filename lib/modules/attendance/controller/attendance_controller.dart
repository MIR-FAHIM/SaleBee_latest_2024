import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/attendance/my_atten_report_by_month.dart';
import 'package:salebee_latest/models/auth/get_all_emp_attendance_report_model.dart';
import 'package:salebee_latest/models/auth/get_all_prospect_by_id_model.dart';
import 'package:salebee_latest/models/auth/get_emp_attendance_model.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:http/http.dart' as http;

class AttendanceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  final attendanceModel = GetAttendanceDataModel().obs;
  final myAttenReportByModel = MyAttenRepByMonthModel().obs;
  final attendanceModeAllEmp = GetAllEmployeeAttendance().obs;
  final isLongPressing = false.obs;
  final reasonTextV = "".obs;
  final reasonTextController = TextEditingController().obs;
  final presentTab = false.obs;
  final circularProgressIndicatorValue = 0.0.obs;

  final end = 0.0.obs;
  final tabIndex = 0.obs;
  final totalHours = "".obs;
  final locationDis = "".obs;
  final absentList = <AbsentModel>[].obs;
  final presentID = <AbsentModel>[].obs;
  final employeeListAtn = <AbsentModel>[].obs;
  final status = true.obs;
  final showInfo = false.obs;
  final animationValue = 0.0.obs;
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
  final checkOutReason = <String>[
    'Personal appointments (doctor, dentist, etc.)',
    'Family obligations or emergencies',
    'Family obligations or emergencies',
    'Childcare responsibilities (picking up children from school or daycare)',
    'Scheduled meetings or appointments outside of the office',
    'Feeling unwell or experiencing illness',
    'Attending a family event or special occasion',
    'Continuing education classes or courses',
    'Flexibility in work hours due to company policy or agreement',
    'Preparing for travel or catching a flight',
  ].obs;
  final checkINReason = <String>[
    'Traffic congestion',
    'Public transportation delays',
    'Family obligations or emergencies',
    'Childcare responsibilities (picking up children from school or daycare)',
    'Scheduled meetings or appointments outside of the office',
    'Feeling unwell or experiencing illness',
    'Attending a family event or special occasion',
    'Continuing education classes or courses',
    'Flexibility in work hours due to company policy or agreement',
    'Car trouble',
    'Oversleeping',
  ].obs;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEmpAttendance();
      getAllDaillyEmpAttendance(DateTime(
        DateTime.now().year,
        monthSelection.value,
        daySelection.value,
      ));
      getAddressFromLatLng(
        Get.find<LocationService>().currentLocation['lat'],
        Get.find<LocationService>().currentLocation['lng'],
      );
    });
  }

  @override
  void onClose() {
    animationController
        .dispose(); // Dispose the animation controller when the controller is closed
    super.onClose();
  }

  void updateEndValue(double value) {
    end.value = value;
  }

  void updateStatus(bool newStatus) {
    status.value = newStatus;
  }

  void updateCircularProgressValue(double value) {
    circularProgressIndicatorValue.value = value;
  }

  void onLongPressCallback() {
    // Your function to be called after long press
    isLongPressing.value = false;
    print("Long press completed!");
  }

  void startProgress() {
    animationController.forward().then((value) {
      resetProgress();
    });
  }

  void resetProgress() {
    animationController.reset();
  }
  Color getRandomColor() {
    Random random = Random();
    List<Color> colors = [
      Colors.purple.withOpacity(0.1),
      Colors.green.withOpacity(0.1),
      Colors.blue.withOpacity(0.1),
      Colors.yellow.withOpacity(0.1),
      Colors.red.withOpacity(0.1),
      Colors.deepOrange.withOpacity(0.1),
      Colors.brown.withOpacity(0.1),
      Colors.purpleAccent.withOpacity(0.1),
    ];
    return colors[random.nextInt(colors.length)];
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&latlng=$lat,$lng';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'OK' &&
            data['results'] is List &&
            data['results'].isNotEmpty) {
          String formattedAddress = data['results'][0]['formatted_address'];
          String political = '';
          String sublocality = '';
          String sublocalityLevel1 = '';

          // Extracting political, sublocality, and sublocality_level_1 from address components
          for (var component in data['results'][0]['address_components']) {
            if (component['types'].contains('political')) {
              political = component['short_name'];
            }
            if (component['types'].contains('sublocality')) {
              sublocality = component['short_name'];
            }
            if (component['types'].contains('sublocality_level_1')) {
              sublocalityLevel1 = component['short_name'];
            }
          }

          print("Formatted Address: $formattedAddress");
          print("Political: $political");
          print("Sublocality: $sublocality");
          print("Sublocality Level 1: $sublocalityLevel1");

          // You can customize the result string as needed
          String result = '$sublocality, $sublocalityLevel1, $formattedAddress';
          locationDis.value = result;
          return result;
        } else {
          // Handle no results or error status
          return locationDis.value;
        }
      } else {
        // Handle HTTP error
        return locationDis.value;
      }
    } catch (error) {
      // Handle any exceptions
      print("Error: $error");
      return locationDis.value;
    }
  }

  addCheckIn() {
    updateEndValue(1);
    Map<String, dynamic> body = {
      //    "Id": 0,
      "EmployeeId": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .employeeId!
          .toString(),
      "LogTimeIn": DateTime.now().toString(),
      //"LogTimeOut": "2022-10-02T04:49:01.264Z",
      //IsLogIn": true,
      //"IsLogFromPhone": true,
      "Latitude": Get.find<LocationService>().currentLocation['lat'].toString(),
      "Longitude":
          Get.find<LocationService>().currentLocation['lng'].toString(),
      "LocationDescription": locationDis.value,
      "Remark": reasonTextV.value ?? "",
      // "IsLate": true,
      //  "IsEarlyOut": true,
      // "IsHalfDay": true,
      // "IsExtremeLate": true,
      // "IsExtremeEarlyOut": true,
      //  "LongitudeOut": 0,
      //  "LocationDescriptionOut": "string",
      // "BatteryStatus": "string",
      // "Absent": 0,
      //  "OnLeave": 0,
      //  "WorkingDays": 0,
      // "OnTime": 0,
      //  "CheckInNote": "string",
      //  "CheckOutNote": "string",
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      //"Hours": "string",
      // "OverTime": "string",
      // "Active": true,
      //  "CreatedBy": 0,
      //  "CreatedOn": "2022-10-02T04:49:01.264Z",
      //  "UpdatedBy": 0,
      //  "UpdatedOn": "2022-10-02T04:49:01.264Z",
      // "IsDeleted": true
    };
    print("call check in");
    AllRepository().addCheckIN(body).then((value) {
      if (value['Message'] == "Already checked In") {
        getEmpAttendance();
        Get.showSnackbar(
            Ui.errorSnackBar(message: value['Message'], title: 'Error'));
        Get.toNamed(Routes.ATTENDANCEVIEW);
        status.value = false;
        updateEndValue(0);
      } else {
        getEmpAttendance();
        Get.showSnackbar(Ui.successSnackBar(
            message: "Check In successfully", title: 'Success'));
      }
    });
  }

  addCheckOut() {
    updateEndValue(1);
    Map<String, dynamic> body = {
      "Token": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .userToken!
          .toString(),
      "EmployeeId": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .employeeId!
          .toString(),
      "CheckOutDateTime": DateTime.now().toString(),
      "Latitude": Get.find<LocationService>().currentLocation['lat'].toString(),
      "Longitude":
          Get.find<LocationService>().currentLocation['lng'].toString(),
      "Location": locationDis.value,
      "CheckOutNote": reasonTextV.value ?? "",
    };
    print("call check in");
    AllRepository().addCheckutt(body).then((value) {
      if (value['Result'] != null) {
        Get.showSnackbar(Ui.successSnackBar(
            message: "Check out successfully", title: 'Success'));
        status.value = false;
        Get.toNamed(Routes.ATTENDANCEVIEW);
        getEmpAttendance();
        updateEndValue(0);
      } else {
        Get.showSnackbar(Ui.errorSnackBar(
            message: "Something went wrong....", title: 'Error'));
        updateEndValue(0);
      }
    });
  }

  String duration(String? checkin, String? checkout) {
    try {
      if (checkin == null || checkout == null) {
        return "0";
      } else {
        final DateTime checkInTime1 = DateTime.parse(checkin);
        final DateTime checkOutTime1 = DateTime.parse(checkout);

        final hours = checkOutTime1.difference(checkInTime1).inHours;
        final minutes = checkOutTime1.difference(checkInTime1).inMinutes;
        final totalWorkingHours = '$hours.${(minutes - (hours * 60))} hrs';
        print("hours  " + totalWorkingHours);
        print("duration check in  " + checkInTime1.toString());

        totalHours.value = totalWorkingHours;
        return totalHours.value;
      }
      // Your calculation logic here
      return "Calculated Duration";
    } catch (e) {
      print("Error in duration function: $e");
      return "Error calculating duration";
    }
  }

  getEmpAttendance() {
    Map<String, dynamic> body = {
      "Token": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .userToken!
          .toString(),
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .employeeId!
          .toString(),
      "SupportID": 0,
      "FollowupID": 0,
      "FromDate": "2023-11-29T05:54:29.320Z",
      "ToDate": DateTime.now().toString(),
    };

    AllRepository().getEmpAttendance(body).then((value) {
      if (value['Result'] != null) {
        attendanceModel.value = GetAttendanceDataModel.fromJson(value);
        if (DateTime.parse(attendanceModel.value.result!.first.logTimeIn).day ==
                DateTime.now().day &&
            DateTime.parse(attendanceModel.value.result!.first.logTimeIn)
                    .month ==
                DateTime.now().month) {
          status.value = false;
          showInfo.value = true;
        }
      }
    });
  }

  getMyAttenReportByMonth(int empId, String name) {
    print("called 1211");
    Map<String, dynamic> body = {
      "Token": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .userToken!
          .toString(),
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": empId,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2023-03-07T09:06:13.489Z",
      "ToDate": DateTime.now().toString()
    };

    AllRepository().getMyReportByMonth(body, empId.toString(),monthSelection.value.toString()).then((value) {
      print("hlw month by emp $value");

      myAttenReportByModel.value = MyAttenRepByMonthModel.fromJson(value);

      if (myAttenReportByModel.value.isSuccess == true) {
        Get.offNamed(Routes.EMPMONTHTABLE, arguments: [name]);
      } else {
        print("something went wrong");
      }
    });
  }

  getAllDaillyEmpAttendance(DateTime date) {
    Map<String, dynamic> body = {
      "Token": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .userToken!
          .toString(),
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": Get.find<AuthService>()
          .currentUser
          .value
          .result!
          .employeeId!
          .toString(),
      "SupportID": 0,
      "FollowupID": 0,
      "FromDate": date.toString(),
      "ToDate": date.toString(),
    };

    AllRepository().getAllDalyEmpAttendance(body).then((value) {
      absentList.clear();
      presentID.clear();
      employeeListAtn.clear();

      if (value['Result'] != null) {
        attendanceModeAllEmp.value = GetAllEmployeeAttendance.fromJson(value);

        // Extract employee information for present employees
        presentID.addAll(attendanceModeAllEmp.value.result!.map((element) =>
            AbsentModel(name: element.employeeName!, id: element.employeeId!)));

        // Extract all employees
        employeeListAtn.addAll(Get.find<HomeController>()
            .allEmployeeList
            .map((element) => AbsentModel(
                  name: element.employeeName!,
                  id: element.employeeId!,
                  designation: element.designationObj!.designationName!,
                  num: element.phoneNumbers,
                  imagePath: element.profilePicturePath,
                )));

        // Populate absentList with employees who are absent
        absentList.value =
            employeeListAtn.where((item) => !presentID.contains(item)).toList();

        // Check if absentList is not empty
        if (absentList.isNotEmpty) {
          print("Absent employees: ${absentList.length}");
          // Do something with the absentList
        } else {
          print("No employees are absent");
        }
      }
    });
  }
}

class AbsentModel {
  String name;
  int id;
  String? designation;
  String? num;
  DateTime? date;
  String? imagePath;

  AbsentModel(
      {required this.name,
      required this.id,
      this.designation,
      this.num,
      this.date,
      this.imagePath});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsentModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
