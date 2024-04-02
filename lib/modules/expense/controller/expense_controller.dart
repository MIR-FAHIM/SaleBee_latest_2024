import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/models/auth/all_emp_model.dart';
import 'package:salebee_latest/models/auth/expense/expense_claim_list_model.dart';
import 'package:salebee_latest/models/auth/get_all_expense_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpenseController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textPwdController = TextEditingController().obs;
  final startLocationController = TextEditingController().obs;
  final endLocationController = TextEditingController().obs;
  final personController = TextEditingController().obs;
  final pricingController = TextEditingController().obs;
  final wayDescriptionController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final stausID = 0.obs;
  final checkedValue = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final fcmtoken = "".obs;
  final prospectName = "".obs;
  final prosID = 0.obs;
  final imageList = <File>[].obs;
  final getAllExpenseModel = NewExpenseClaimModel().obs;
  final searchType = "".obs;
  final fileString = "".obs;
  final selectedType = "".obs;
  final foodType = "".obs;
  final expenseTypeS = "Food".obs;
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  final selectedImage = File('').obs;
  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;
  final searchString = "".obs;
  final allExpenseList = <DatumClaim>[].obs;
  final selectedDate = DateTime.now().obs;
  final myFormat = DateFormat('dd-MM-yyyy').obs;
  final wayList = <String>[
    "Rickshaw",
    "Bus",
    "Train",
    "Byke",
    "CNG",
    "Car",
    "Others"
  ];

  final foodList = <String>[
    "Lunch",
    "Dinner",
    "Breakfast",
    "Snacks",
    "Party",
    "Programm",
    "Client"
  ];
  @override
  Future<void> onInit() async {
    getAllExpenseController();
    print(
        "emp id is ++++++${Get.find<AuthService>().currentUser.value.result!.id}");
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

  getAllExpenseController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Data": {
        "DateRange": "",
        "ClaimedBy": Get.find<AuthService>().currentUser.value.result!.employeeId!,
        "ExpenseTypeId": 0,
        "StatusId": 0,
        "ApprovedBy": 0,
        "ProspectId": 0,
        "CostRange": 0
      }
    };

    AllRepository().getAllExpense(body).then((value) {
      print("my emp list is $value");

      final model = NewExpenseClaimModel.fromJson(value);
      getAllExpenseModel.value = model;

      allExpenseList.value = model.result!.data;
      print("get all expense ${allExpenseList.length}");
    });
  }
  updateExpenseStatus({statusId, expenseId}) {
    print("hlw");
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Data": {

      },

    };

    AllRepository().updateExpenseStatus(body, expenseId, statusId).then((value) {
      print("update status expense $value");
      if (value["IsSuccess"] == true) {

        getAllExpenseController();
        Get.showSnackbar(
            Ui.successSnackBar(message: value["Message"], title: 'Success'.tr));

      } else {
        Get.showSnackbar(Ui.errorSnackBar(message: value["Message"], title: 'Error'.tr));
      }
    });
  }
  addExpenseController() {
    print("hlw");
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Data": {
        "ID": 0,
        "Title": selectedType.value,
        "Description": wayDescriptionController.value.text,
        "Cost": pricingController.value.text,
        "PersonCount": personController.value.text,
        "ProspectId": 0,
        "ExpenseTypeId": expenseTypeS.value == "Food"? 1 : expenseTypeS.value == "Transport"? 2 : 3,
        "ExpenseDate": selectedDate.value.toString(),
        "ClaimedBy": Get.find<AuthService>().currentUser.value.result!.employeeId!,
        "ApprovedBy": 0,
        "ApprovedDate": "2024-03-10T10:26:21.451Z",
        "StatusId": 1,
        "ReasonForUpdate": "testing",
        "PaymentDate": "2024-03-10T10:26:21.451Z",
        "StartLocation": "start",
        "EndLocation": "ensd",
        "StartLatitude": 0,
        "StartLongitude": 0,
        "EndLatitude": 0,
        "EndLongitude": 0,
        "ExpenseType": expenseTypeS.value,
        "Status": 1,
        "ProspectName": "",
        "ClaimedByName": Get.find<AuthService>().currentUser.value.result!.userName!,
        "ApprovedByName": "",
        "ExpenseFiles": [
          {
            "ExpenseID": 0,
            "ID": 0,
            "SavedAs": "string",
            "Ext": "string",
            "SizeInKB": 0,
            "Name": "string",
            "Path": "string",
            "Active": true,
            "CreatedBy": 0,
            "CreatedOn": "2024-03-10T10:26:21.451Z",
            "UpdatedBy": 0,
            "UpdatedOn": "2024-03-10T10:26:21.451Z",
            "IsDeleted": true
          }
        ],
        "Active": true,
        "CreatedBy":Get.find<AuthService>().currentUser.value.result!.employeeId!,
        "CreatedOn": "2024-03-10T10:26:21.451Z",
        "UpdatedBy": 0,
        "UpdatedOn": "2024-03-10T10:26:21.451Z",
        "IsDeleted": true
      }
    };

    AllRepository().addExpenseNew(body).then((value) {
      print("add expense $value");
      if (value["Message"] == "Expense Claim Added Successfully") {
        addExpenseImage(value['Result']['ID'].toString());
        getAllExpenseController();
        Get.showSnackbar(
            Ui.successSnackBar(message: value["Message"], title: 'Success'.tr));
        Get.toNamed(Routes.EXPENSEVIEW);
      } else {
        Get.showSnackbar(Ui.errorSnackBar(message: "added", title: 'Error'.tr));
      }
    });
  }
  addExpenseImage(expenseId) {

    AllRepository()
        .uploadExpenseImage(
        listImages: imageList.value,
        token: Get.find<AuthService>().currentUser.value.result!.userToken!,
        eexpenseId:expenseId)
        .then((value) {
          print("add  expense image $value");
    });
  }

  // addExpenseFile(id) {
  //   print("hlw");
  //   Map body = {
  //       "expenseId": id,
  //   };
  //
  //   AllRepository().addExpenseNew(body).then((value) {
  //     print("add expense $value");
  //     if (value["Message"] == "Expense Claim Added Successfully") {
  //       getAllExpenseController();
  //       Get.showSnackbar(
  //           Ui.successSnackBar(message: value["Message"], title: 'Success'.tr));
  //     } else {
  //       Get.showSnackbar(Ui.errorSnackBar(message: "added", title: 'Error'.tr));
  //     }
  //   });
  // }

  List<DatumClaim> get filteredAllExpenseList {
    if (searchString.value.isNotEmpty) {
      return allExpenseList.value.where((data) {
        final status = data.status.toString();

        final searchTerm = searchString.value;

        return status! == searchTerm;
      }).toList();
    } else {
      return allExpenseList.value;
    }
  }

  void setSearchText(String text, String type) {
    searchString.value = text;
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
}
