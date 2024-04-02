import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:url_launcher/url_launcher.dart';

class changePassView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add  New Password"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                      "Enter your credintial to access account",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 40,
                ),

                Text(
                  "New Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.textNewPwdController.value,
                  obscureText: controller.openLock.value == true ? false : true,

                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: (){
                          if(controller.openLock.value == true){
                            controller.openLock.value = false;
                          }else{
                            controller.openLock.value = true;

                          }

                        },
                        child:controller.openLock.value == true ? Icon(Icons.lock): Icon(Icons.lock_open)),
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                      onTap: ()  {
                        if(controller.textNewPwdController.value.text.isNotEmpty){
                          controller.changePass();

                        }else{
                          Get.showSnackbar(Ui.errorSnackBar(
                              message: 'Please add new password.', title: 'error'.tr));
                        }

                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                ),

              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
//
