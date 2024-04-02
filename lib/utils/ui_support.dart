import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class Ui {
  static GetSnackBar successSnackBar({String title = 'Success', required String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message, style: Get.textTheme.caption!.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
    );
  }
  static BoxDecoration getBoxDecoration({
    Color? color,
    double? radius,
    Border? border,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Color(0xFF652981).withOpacity(0.3),
            blurRadius: 2,
            offset: Offset(0, 2)),
      ],
      //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }
  //
  static GetSnackBar errorSnackBar({String title = 'Something went wrong!', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message.tr, style: Get.textTheme.caption!.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
  //
  static GetSnackBar authenticationErrorSnackBar({required String title, required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message.tr, style: Get.textTheme.caption!.merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }


  static customLoaderSplash() {
    return SpinKitCubeGrid(
      size: 25,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.textColorGreen,
          ),
        );
      },
    );
  }
}
