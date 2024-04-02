import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textPwdController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final stausID = 1.obs;
  final selectAll = true.obs;
  final checkedValue = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final fcmtoken = "".obs;
  final searchType = "".obs;
  final searchString = "".obs;
  final dropdownValue = DateTime.now().year.toString().obs;
  final monthSelection = int.parse(DateTime.now().toString().substring(5, 7)).obs;
  final yearSelection = int.parse(DateTime.now().toString().substring(0, 4)).obs;
  final daySelection = int.parse(DateTime.now().toString().substring(8, 10)).obs;
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
  final statuses = <Status>[
    Status(
      id: 0,
      name: 'Change Status',
    ),
    Status(
      id: 11,
      name: 'Cancelled',
    ),
    Status(
      id: 4,
      name: 'Done',
    ),
    Status(
      id: 1,
      name: 'Incomplete',
    ),
    Status(
      id: 5,
      name: 'Initiated',
    ),
    Status(
      id: 13,
      name: 'Need More Time',
    ),
    Status(id: 3, name: 'Partially done'),
  ];

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
  final allTaskList = <MyTaskResult>[].obs;
  final assigedToMeTaskList = <MyTaskResult>[].obs;
  final assignedByMeTaskList = <MyTaskResult>[].obs;
  @override
  Future<void> onInit() async {
    getMyTaskController();
    getAllTaskController();
    getAssingedBySomeoneTaskController();
    geAssignedByMeTaskController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  taskUpdateController({
    taskType,
    taskID,
    type,
    title,
    description,
    prosName,
    prospectId,
    assignaTo,
    priority,
    status,
    dueDate,
  }) {
    Map<String, dynamic> bodyString = {
      "TaskID": taskID,
      "Type": type,
      "Title": title,
      "TaskDesc": description,
      "Notes": "No Data",
      "ProspectId": prospectId ?? 01,
      "LeadID": 0,
      "SupportID": 0,
      "StartDate": DateTime.now().toString(),
      "StartTime": "string",
      "DueDate": dueDate,
      "DueTime": "string",
      "ReminderDate": "2022-10-10T05:40:37.409Z",
      "ReminderDays": 0,
      "ReminderHour": 0,
      "ReminderMinutes": 0,
      "Repeat": 0,
      "AssignedTo": assignaTo,
      "Priority": priority,
      "StatusId": status,
      "FollowUpID": 0,
      "IsViewed": true,
      "StatusUpdateDate": "2022-10-10T05:40:37.409Z",
      "StatusUpdateBy": 0,
      "TaskShare": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [0],
            "SelectedlongIds": [0]
          }
        ],
        "SelectedIds": [0],
        "SelectedlongIds": [0]
      },
      "TaskContact": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [0],
            "SelectedlongIds": [0]
          }
        ],
        "SelectedIds": [0],
        "SelectedlongIds": [0]
      },
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "TaskShareList": [0],
      "TaskContactList": [0],
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2022-10-10T05:40:37.409Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2022-10-10T05:40:37.409Z",
      "IsDeleted": true
    };
    AllRepository().updateTask(bodyString).then((value) {
      final taskUpdateModel = TaskUpdateModel.fromJson(value);
      print("task updated model ${taskUpdateModel.message}");
      if(taskUpdateModel.isSuccess == true){
        if(taskType == "Visit" && status == 4){
          getMyTaskController();
          Get.put(VisitController());
          Get.find<VisitController>().addVisitController(prospectId, prosName);

        } else {
          getMyTaskController();
        }

      }
    });
  }
  List<MyTaskResult> get filteredMyTaskList {

    if(searchString.value.isEmpty){
      return myTaskList.value;
    } else if(searchType.value == "date"){
      return  myTaskList.where((data) {
        final status = data.dueDate ;

        final searchTerm = DateTime.parse(searchString.value);

        return status!.day == searchTerm.day && status!.month == searchTerm.month && status!.year == searchTerm.year;

      }).toList();
    }
    else if (searchString.value.isNum)
      {
        return  myTaskList.where((data) {
          final status = data.statusId.toString() ;

          final searchTerm = searchString.value;

          return status! == searchTerm;

        }).toList();
      }
      else {
      return  myTaskList.where((data) {
        final status = data.taskType.toString() ;

        final searchTerm = searchString.value;

        return status! == searchTerm;

      }).toList();
    }

  }
  List<MyTaskResult> get filteredAllTaskList {

    if(searchString.value.isEmpty){
      return allTaskList.value;
    } else if(searchType.value == "date"){
      return  allTaskList.where((data) {
        final status = data.dueDate ;

        final searchTerm = DateTime.parse(searchString.value);

        return status!.day == searchTerm.day && status!.month == searchTerm.month && status!.year == searchTerm.year;

      }).toList();
    }
    else if (searchString.value.isNum)
      {
        return  allTaskList.where((data) {
          final status = data.statusId.toString() ;

          final searchTerm = searchString.value;

          return status! == searchTerm;

        }).toList();
      }
      else {
      return  allTaskList.where((data) {
        final status = data.taskType.toString() ;

        final searchTerm = searchString.value;

        return status! == searchTerm;

      }).toList();
    }

  }
  List<MyTaskResult> get filteredAssignedToMeTaskList {

    if(searchString.value.isEmpty){
      return assigedToMeTaskList.value;
    } else if(searchType.value == "date"){
      return  assigedToMeTaskList.where((data) {
        final status = data.dueDate ;

        final searchTerm = DateTime.parse(searchString.value);

        return status!.day == searchTerm.day && status!.month == searchTerm.month && status!.year == searchTerm.year;

      }).toList();
    }
    else if (searchString.value.isNum)
      {
        return  assigedToMeTaskList.where((data) {
          final status = data.statusId.toString() ;

          final searchTerm = searchString.value;

          return status! == searchTerm;

        }).toList();
      }
      else {
      return  assigedToMeTaskList.where((data) {
        final status = data.taskType.toString() ;

        final searchTerm = searchString.value;

        return status! == searchTerm;

      }).toList();
    }

  }
  List<MyTaskResult> get filteredAssignedByMeTaskList {

    if(searchString.value.isEmpty){
      return assignedByMeTaskList.value;
    } else if(searchType.value == "date"){
      return  assignedByMeTaskList.where((data) {
        final status = data.dueDate ;

        final searchTerm = DateTime.parse(searchString.value);

        return status!.day == searchTerm.day && status!.month == searchTerm.month && status!.year == searchTerm.year;

      }).toList();
    }
    else if (searchString.value.isNum)
      {
        return  assignedByMeTaskList.where((data) {
          final status = data.statusId.toString() ;

          final searchTerm = searchString.value;

          return status! == searchTerm;

        }).toList();
      }
      else {
      return  assignedByMeTaskList.where((data) {
        final status = data.taskType.toString() ;

        final searchTerm = searchString.value;

        return status! == searchTerm;

      }).toList();
    }

  }
  void setSearchText(String text, String type) {
    searchString.value = text;
  }
  getMyTaskController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 0,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2024-02-12T10:35:31.037Z",
      "ToDate": "2024-02-12T10:35:31.037Z"
    };
    AllRepository().getMyTask(body).then((value) {
      print("my task list is $value");
      if (value['Message'] == "Data Found") {
        final model = GetMyTaskModel.fromJson(value);

        myTaskList.value = model.result!;
        print("my task are ${myTaskList.value.length}");
      }
    });
  }
  getAssingedBySomeoneTaskController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 0,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2024-02-12T10:35:31.037Z",
      "ToDate": "2024-02-12T10:35:31.037Z"
    };
    AllRepository().getAssingedBySomeOneTask(body).then((value) {
      print("assigedToMeTaskList task list is $value");
      if (value['Message'] == "Data Found") {
        final model = GetMyTaskModel.fromJson(value);

        assigedToMeTaskList.value = model.result!;
        print("assigedToMeTaskList task are ${assigedToMeTaskList.value.length}");
      }
    });
  }
  geAssignedByMeTaskController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 0,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2024-02-12T10:35:31.037Z",
      "ToDate": "2024-02-12T10:35:31.037Z"
    };
    AllRepository().getAssignedByMeTask(body).then((value) {
      print("geAssignedByMeTaskController task list is $value");
      if (value['Message'] == "Data Found") {
        final model = GetMyTaskModel.fromJson(value);

        assignedByMeTaskList.value = model.result!;
        print("geAssignedByMeTaskController task are ${myTaskList.value.length}");
      }
    });
  }

  getAllTaskController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "ProspectID": 0,
      "LeadID": 0,
      "TaskID": 0,
      "EmployeeID": 0,
      "SupportID": 0,
      "FollowupID": 0,
      "ExpenseID": 0,
      "Type": "string",
      "StatusId": 0,
      "FromDate": "2024-02-12T10:35:31.037Z",
      "ToDate": "2024-02-12T10:35:31.037Z"
    };
    AllRepository().getAllTask(body).then((value) {
      print("getAllTask task list is $value");
      if (value['Message'] == "Data Found") {
        final model = GetMyTaskModel.fromJson(value);

        allTaskList.value = model.result!;
        print("getAllTask task are ${myTaskList.value.length}");
      }
    });
  }
}



class Status {
  final int id;
  final String name;

  Status({required this.id, required this.name});
}
