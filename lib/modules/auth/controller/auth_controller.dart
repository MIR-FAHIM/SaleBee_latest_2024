import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/models/auth/login_model.dart';
import 'package:salebee_latest/repository/auth_rep.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  RxString splashScreenImages = ''.obs;
  final textSubDomainController = TextEditingController().obs;
  final textUserController = TextEditingController().obs;
  final textPwdController = TextEditingController().obs;
  final openLock = false.obs;
  int lastSplashScreenIndex = -1;
  final checkedValue = false.obs;
  final fcmtoken = "".obs;

  final checkTerm = false.obs;

  @override
  Future<void> onInit() async {
    getFcmToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  checkSubDomainController() {
    Map<String, dynamic> body = {
      "hostname": textSubDomainController.value.text,
    };
    AuthRepository()
        .checkDomain(body, textSubDomainController.value.text)
        .then((resp) {
      print("res is $resp");

      if (resp['Result']['data'] == "OK") {
        SharedPreff.to.prefss
            .setString("domain", textSubDomainController.value.text);
        Get.toNamed(Routes.LOGIN);
      } else {
        Get.showSnackbar(Ui.errorSnackBar(
            message: 'Sub-Domain did not match', title: 'error'.tr));
      }
    });
  }

  getFcmToken() async {
    fcmtoken.value = (await FirebaseMessaging.instance.getToken())!;
    print("my fcm toekn is =+++++++++ $fcmtoken");
    return fcmtoken;
  }

  loginController() {
    Map<String, dynamic> bodyString = {
      "Email": "string",
      "UserName": textUserController.value.text,
      "Password": textPwdController.value.text,
      "RememberMe": true,
      "Token": "string",
      "FCM_Token": "grdrtgd",
      "DeviceId": "007"
    };
    AuthRepository().loginRep(bodyString).then((resp) {
      if (resp['IsSuccess'] == true) {
        Get.find<AuthService>().setUser(LoginResponseModel.fromJson(resp));
        Get.find<AuthService>().setLogged();

        Get.offNamed(Routes.HOME);
        textPwdController.value.clear();
      } else {
        Get.showSnackbar(Ui.errorSnackBar(
            message: 'Authentication is not right.', title: 'error'.tr));
      }
    });
  }



}
