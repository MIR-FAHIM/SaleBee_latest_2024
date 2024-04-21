import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salebee_latest/models/auth/my_task_model.dart';
import 'package:salebee_latest/models/auth/task/new_task_model.dart';
import 'package:salebee_latest/models/auth/task/task_status_model.dart';
import 'package:salebee_latest/models/auth/task/task_type_mpdel.dart';
import 'package:salebee_latest/models/auth/task_update_model.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
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
  final taskTitleController = TextEditingController().obs;
  final taskDesController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final stausID = 0.obs;
  final prosID = 0.obs;
  final prospectName = "".obs;
  final selectDateFil = 3.obs;
  final selectedStatus = 177.obs;
  final selectedType = 177.obs;
  final taskType = 0.obs;
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  final selectedImage = File('').obs;
  final imageList = <File>[].obs;
  final fileString = "".obs;
  final selectedDate = DateTime.now().obs;
  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;
  final selectAll = true.obs;
  final loader = false.obs;
  final lastDate = DateTime.now().obs;
  final toDate = DateTime.now().add(Duration(days: 1)).obs;
  final checkedValue = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final dateFilterList = <FilterDateModel>[
    FilterDateModel(id: 0, name: "Last 30 Days" , lastDate: DateTime.now().subtract(Duration(days: 30)), toDate: DateTime.now() ),
    FilterDateModel(id: 1, name: "Last 7 Days" , lastDate: DateTime.now().subtract(Duration(days: 7)), toDate: DateTime.now() ),
    FilterDateModel(id:2, name: "Last 3 Days" , lastDate: DateTime.now().subtract(Duration(days: 3)), toDate: DateTime.now() ),
    FilterDateModel(id: 3, name: "Today" , lastDate: DateTime.now(), toDate: DateTime.now().add(Duration(days: 1) ), ),
    FilterDateModel(id: 4, name: "next 3 Days" , lastDate: DateTime.now(), toDate: DateTime.now().add(Duration(days: 3) ),),
    FilterDateModel(id: 5, name: "next 7 Days" , lastDate: DateTime.now(), toDate: DateTime.now().add(Duration(days: 7) ),),
    FilterDateModel(id: 6, name: "next 30 Days" , lastDate: DateTime.now(), toDate: DateTime.now().add(Duration(days: 30) ),),

  ].obs;
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
  final statuses = <ResultSta>[].obs;

  final checkTerm = false.obs;

  final focusedIndex = 0.obs;
  final empId = 0.obs;
  final myTaskList = <MyTaskResult>[].obs;
  final getTaskType = <ResultType>[].obs;
  final allTaskList = <DatumTask>[].obs;
  final assigedToMeTaskList = <MyTaskResult>[].obs;
  final assignedByMeTaskList = <MyTaskResult>[].obs;
  @override
  Future<void> onInit() async {
    Get.put(EmployeeController());
    getTaskStatus();
    getTaskTypeController();
    getAllTaskController();
    Get.put(ProspectController());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
  List<DatumTask> get filteredAllTaskList {




      return allTaskList.value;


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
  addTaskController() {
    loader.value = true;
    Map body = {
      "TaskID": 0,
      "Type": selectedType.value,
      "Title": taskTitleController.value.text,
      "TaskDesc": taskDesController.value.text,
      "Notes": "string",
      "ProspectId": prosID.value,
      "LeadID": 0,
      "SupportID": 0,
      "StartDate": "2024-04-21T05:46:46.228Z",
      "StartTime": "string",
      "DueDate": "2024-04-21T05:46:46.228Z",
      "DueTime": selectedDate.value.toString(),
      "ReminderDate": "2024-04-21T05:46:46.228Z",
      "ReminderDays": 0,
      "ReminderHour": 0,
      "ReminderMinutes": 0,
      "Repeat": 0,
      "AssignedTo": empId.value,
      "Priority": 0,
      "StatusId": stausID.value,
      "FollowUpID": 0,
      "IsViewed": true,
      "StatusUpdateDate": "2024-04-21T05:46:46.228Z",
      "StatusUpdateBy": 0,
      "TaskShare": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [
              0
            ],
            "SelectedlongIds": [
              0
            ]
          }
        ],
        "SelectedIds": [
          0
        ],
        "SelectedlongIds": [
          0
        ]
      },
      "TaskContact": {
        "List": [
          {
            "Id": 0,
            "Name": "string",
            "SelectedIds": [
              0
            ],
            "SelectedlongIds": [
              0
            ]
          }
        ],
        "SelectedIds": [
          0
        ],
        "SelectedlongIds": [
          0
        ]
      },
      "Token":Get.find<AuthService>().currentUser.value.result!.userToken!,
      "FCMToken": "string",
      "DeviceId": "string",
      "TaskShareList": [
        0
      ],
      "TaskContactList": [
        0
      ],
      "TaskFiles": [
        {
          "TaskID": 0,
          "ID": 0,
          "SavedAs": "string",
          "Ext": "string",
          "SizeInKB": 0,
          "Name": "string",
          "Path": "string",
          "Active": true,
          "CreatedBy": 0,
          "CreatedOn": "2024-04-21T05:46:46.229Z",
          "UpdatedBy": 0,
          "UpdatedOn": "2024-04-21T05:46:46.229Z",
          "IsDeleted": true
        }
      ],
      "Active": true,
      "CreatedBy": 0,
      "CreatedOn": "2024-04-21T05:46:46.229Z",
      "UpdatedBy": 0,
      "UpdatedOn": "2024-04-21T05:46:46.229Z",
      "IsDeleted": true
    };
    AllRepository().addTask(body).then((value) {
      print("add task is $value");
      if (value['Message'] == "Task Add Successfully") {
        Get.showSnackbar(Ui.successSnackBar(
            message:value["Message"], title: 'Success'.tr));
        getAllTaskController();
        Get.toNamed(Routes.TASKVIEW);
      }else{
        loader.value = true;
      }
    });
  }

  void getImageAndroid13(ImageSource imageSource, String type) async {
    selectedImagePath = ''.obs;
    selectedImageSize = ''.obs;

    // Crop code
    cropImagePath = ''.obs;
    cropImageSize = ''.obs;

    // Compress code
    compressImagePath = ''.obs;
    compressImageSize = ''.obs;


    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      selectedImagePath.value = result.files.first.path.toString();
      selectedImageSize.value = ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";

      // Crop
      final cropImageFile = await ImageCropper().cropImage(sourcePath: selectedImagePath.value, maxWidth: 512, maxHeight: 512, compressFormat: ImageCompressFormat.jpg);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value = ((File(cropImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";

      // Compress
      print('compress path: ${cropImagePath.value}');
      final dir = Directory.systemTemp;
      final targetPath = dir.absolute.path + '/' + cropImagePath.value.split('/').last;
      var compressedFile = await FlutterImageCompress.compressAndGetFile(cropImagePath.value, targetPath, quality: 100, keepExif: false, autoCorrectionAngle: true, rotate: 0);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value = ((File(compressImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";

      // final bytes = compressedFile.readAsBytesSync();

      List<int> bytes = compressedFile.readAsBytesSync();

      selectedImage.value = File(targetPath);
      imageList.add(selectedImage.value);
      fileString.value = base64Encode(bytes);






      // uploadImage(compressedFile);
    } else {
      Get.snackbar('Error', 'No image selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
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


  getTaskStatus() {

    AllRepository().getTaskStatus().then((value) {
      print("getTaskStatus $value");
      if (value['Message'] == "Data Found") {
        final model = TaskStatusModel.fromJson(value);

        statuses.value = model.result!;
        print("getTaskStatus ${statuses.value.length}");
      }
    });
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
            "SelectedIds": [],
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
      "UpdatedBy": Get.find<AuthService>().currentUser.value.result!.employeeId!,
      "UpdatedOn": "2022-10-10T05:40:37.409Z",
      "IsDeleted": true
    };
    AllRepository().updateTask(bodyString).then((value) {
      final taskUpdateModel = TaskUpdateModel.fromJson(value);
      print("task updated model ${taskUpdateModel.message}");
      print("pros name id +++++++++++++++++++++++++++++++++++++++++++++ $prospectId, $prosName");
      if(taskUpdateModel.isSuccess == true){
        if(taskType == "Visit" && status == 4){
          Get.put(VisitController());
          Get.find<VisitController>().addVisitController(prospectId, prosName);
          getAllTaskController();


        } else {
          getAllTaskController();
        }

      }
    });
  }
  updateTaskStatus({

    taskID,

    prosName,
    prospectId,
    taskType,
    status,

  }) {

    AllRepository().updateTaskStatus(taskID,status).then((value) {
      print("update sts id $status type and $taskType task status $value");
      if (value['IsSuccess'] == true) {
        Get.showSnackbar(Ui.successSnackBar(
            message: value["Message"], title: 'Success'));
        getAllTaskController();
        if(taskType == "Visit" && status == 4){
          Get.put(VisitController());
          Get.find<VisitController>().addVisitController(prospectId, prosName);


      }
    }});
  }

  getTaskTypeController() {

    AllRepository().getTaskType().then((value) {
      print("getTaskType $value");
      if (value['Message'] == "Data Found") {
        final model = TaskTypeModel.fromJson(value);

        getTaskType.value = model.result!;
        print("getTaskType ${getTaskType.value.length}");
      }
    });
  }

  getAllTaskController({String? operation}) {
    allTaskList.value.clear();
    Map body = {
      "Token":  Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Data": {
        "AssignedTo": empId.value,
        "Type": taskType.value,
        "Status": stausID.value,
        "DueTimeFilter": "DateRange",
        "DateFrom": lastDate.value.toString(),
        "DateTo": toDate.value.toString(),
       "OperationType": operation,

      }
    };
    AllRepository().getAllTask(body).then((value) {
      print("getAllTask task list is $value");
      if (value['Message'] == "Data Found") {
        final model = NewTaskListModel.fromJson(value);

        allTaskList.value = model.result!.data;
        print("getAllTask task are ${allTaskList.value.length}");
      }
    });
  }
}



class Status {
  final int id;
  final String name;

  Status({required this.id, required this.name});
}
class FilterDateModel {
  final int id;
  final String name;
  final DateTime lastDate;
  final DateTime toDate;

  FilterDateModel({required this.id, required this.name, required this.lastDate, required this.toDate});
}
