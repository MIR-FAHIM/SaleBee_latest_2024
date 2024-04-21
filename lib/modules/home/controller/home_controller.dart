import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:salebee_latest/models/auth/get_all_emp_model.dart';
import 'package:salebee_latest/models/auth/permitted_model.dart';
import 'package:salebee_latest/repository/all_rep.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textNewPwdController = TextEditingController().obs;
  int lastSplashScreenIndex = -1;
  final checkedValue = false.obs;
  final openLock = false.obs;
  final isExpenseVisible = false.obs;
  final scaffoldkey = GlobalKey().obs;
  final allEmployeeList = <ResultsEmployee>[].obs;
  final permitModel = PemittedModel().obs;
  final fcmtoken = "".obs;
  final checkTerm = false.obs;

  //'Expense', 'Task', 'Attendance', 'Lead', 'Prospect', 'Settings', 'Accounts'

  final menuItems = <MenuModel>[
    MenuModel('Visit', 'images/drawer/track.png', false),
    MenuModel('Task', 'images/Icons/todo1.png', false),
    MenuModel('Attendance', 'images/Icons/attendance.png', false),
    MenuModel('Lead', 'images/Icons/lead.png', false),
    MenuModel('Prospect', 'images/Icons/prospect.png', false),
    MenuModel('Settings', 'images/Icons/attendance.png', false),
  ].obs;
  final focusedIndex = 0.obs;
  @override
  Future<void> onInit() async {

    getALlEmployeeController();
    advancedStatusCheck();
    allPermittedMenu();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getALlEmployeeController() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };
    AllRepository().getAllEmployee(body).then((value) {
      final allEmployeeModel = AllEmployeeListModel.fromJson(value);
      allEmployeeList.value = allEmployeeModel.results!;
    });
  }

  allPermittedMenu() {
    Map body = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
    };

    AllRepository().getPermittedMenu(body).then((value) {
      final permittedModel = PemittedModel.fromJson(value);
      permitModel.value = permittedModel;
      for (var menu in permitModel.value.result!) {
        if (menu.label == 'Expense') {
          isExpenseVisible.value = menu.menuVisibility;
        }
      }
    });
  }
  changePass() {
    Map<String, dynamic> bodyString = {
      "Token": Get.find<AuthService>().currentUser.value.result!.userToken!,
      "Data": {
        "NewPassword": textNewPwdController.value.text,
      }
    };
    AuthRepository().changePassRep(bodyString).then((resp) {
      print("change pass $resp");
      if (resp['IsSuccess'] == true) {
        textNewPwdController.value.clear();
        Get.showSnackbar(Ui.successSnackBar(
            message: resp['Message'], title: 'SUCCESS'.tr));
          Get.toNamed(Routes.LOGIN);
      } else {
        Get.showSnackbar(Ui.errorSnackBar(
            message: 'Pass did not save.', title: 'error'.tr));
      }
    });
  }
  addExpense() {
    Map body = {};
    AllRepository().addExpense(body).then((e) {
      print("my add expense are $e");
    });
  }

  advancedStatusCheck() async {
    final newVersion = NewVersionPlus(
      //iOSId: 'com.google.Vespa',
      androidId: 'com.salebee.crm',
    );
    var status = await newVersion.getVersionStatus();
    print("version status ${status!.appStoreLink}");
    if (status.canUpdate == true) {
      newVersion.showUpdateDialog(
        launchModeVersion: LaunchModeVersion.external,
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'Update Available!',
        dialogText:
            'Upgrade Salebee ${status.localVersion} to Salebee ${status.storeVersion}',
      );
    }
  }

  void swapMenuItems(int draggedIndex) {
    int currentFocusedIndex = focusedIndex.value;
    int newFocusedIndex = draggedIndex;

    // Calculate the difference in indices
    int indexDifference =
        (currentFocusedIndex - newFocusedIndex) % menuItems.length;
    if (indexDifference < 0) {
      indexDifference += menuItems.length;
    }

    // Update the menu items list by rotating it based on the index difference
    menuItems.value = List.from(menuItems.skip(indexDifference))
      ..addAll(menuItems.take(indexDifference));

    focusedIndex.value = newFocusedIndex;
  }
}

class MenuModel {
  String? label;
  bool? badge;
  String? image;

  MenuModel(this.label, this.image, this.badge);
}
