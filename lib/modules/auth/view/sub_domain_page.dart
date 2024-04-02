
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';



class SsubDomainView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: Get.height *.7,
            child: Padding(

              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Sub-domain",
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
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Sub-Domain",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.textSubDomainController.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your sub-domain",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {

                      controller.checkSubDomainController();

                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:  Text("Next", style: TextStyle(color: Colors.white),),

                      ),
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text.rich(TextSpan(
                        text: 'Do you want to register your company?',
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Help & Support',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
