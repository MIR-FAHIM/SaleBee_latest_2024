import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/services/services.dart';
import 'package:salebee_latest/utils/ui_support.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
                    "Email address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.textUserController.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your email",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.textPwdController.value,
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
                          if(controller.checkTerm.value == true){
                            controller.loginController();
                            Get.find<LocationService>().determinePosition();
                          }else{
                            Get.showSnackbar(Ui.errorSnackBar(
                                message: 'Please check Terms and Conditions.', title: 'error'.tr));
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
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        child: Center(
                          child: CheckboxListTile(
                            title: Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            value: controller.checkedValue.value,
                            onChanged: (newValue) {
                              controller.checkedValue.value = newValue!;
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Center(
                          child: CheckboxListTile(
                            title: GestureDetector(
                              onTap: () async{
                                final String urlString = "https://salebee.net/terms-conditions/";

                                Uri url = Uri.parse(urlString);
                                if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                                } else {
                                print("can not load this url");
                                }
                              },
                              child: Text(
                                "I agree on Terms and Conditions of this App.",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            value: controller.checkTerm.value,
                            onChanged: (newValue) {
                              controller.checkTerm.value = newValue!;
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SUBDOMAIN);
                    },
                    child: Center(
                      child: Text.rich(TextSpan(
                          text: 'Want to change Sub-Domain?',
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sub-Domain page',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ])),
                    ),
                  )
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
