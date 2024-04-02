
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';


class SplashscreenView extends GetView<SplashscreenController> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: AppColors.textColorWhite,
      //
      body: Obx(
         () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Image.asset(
                    "images/salbee_logo_color_1024.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Text("Today's date:"),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Image.asset(
                    "images/Icons/calendar.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Text("${DateFormat.yMd().format(DateTime.now())}"),
                //day, month and year is optional parameter! Uses provide values or current date if not provided!
                // Text(
                //   '${BanglaUtility.getBanglaMonthName(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year)}' +
                //       ', ${BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year).toString().substring(0, 2)}',
                //   style: TextStyle(
                //       fontSize: 16,
                //       color: MyColors.brown,
                //       fontWeight: FontWeight.bold),
                // ),

                Text(
                  controller.today.toFormat("MMMM dd yyyy"),
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.redButton,
                      fontWeight: FontWeight.bold),
                ), //Ramadan 14 1439
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                    strokeWidth: 3,
                    value: controller.value.value,
                    semanticsLabel: "10",
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
//
