import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salebee_latest/modules/home/view/widget/drawer_item_widget.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/services.dart';


class MainDrawerWidget extends StatelessWidget {
  final _size = Get.size;
  final userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Center(
                child: Text(
          Get.find<AuthService>().domainName.value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              )),


          InkWell(
            onTap: () {

            },
            child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
                child: Container(
                  width: _size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('images/drawer/7.png'),
                                height: 25,
                                width: 25,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                width: 1,
                                height: 28,
                                color: Get.theme.dividerColor.withOpacity(0.2),
                              ),
                              Expanded(
                                child: Text('Language Change'.tr, style: Get.textTheme.bodyText2!.merge(TextStyle(fontSize: 16))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Color(0xFF652981),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            GetStorage().read<String>('language') == 'en_US' ? 'বাংলা' : 'English',
                            style: TextStyle(
                              color: Color(0xFF652981),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
          DrawerLinkWidget(
            icon: 'images/Icons/utility_expense.png',
            text: "Expense".tr,
            onTap: (e) {
              Get.put(ProspectController());
              Get.toNamed(Routes.EXPENSEVIEW);
            },
          ),
          // DrawerLinkWidget(
          //   icon: 'images/Icons/utility_expense.png',
          //   text: "Follow Up".tr,
          //   onTap: (e) {
          //  //   Get.toNamed(Routes.E);
          //   },
          // ),
          DrawerLinkWidget(
            icon: 'images/drawer/6.png',
            text: "Change Password".tr,
            onTap: (e) {
             Get.toNamed(Routes.CHANGEPASS);
            },
          ),

          DrawerLinkWidget(
            icon: 'images/drawer/emplist.png',
            text: "Employees".tr,
            onTap: (e) {
              Get.toNamed(Routes.EMPLIST);
            },
          ),
          DrawerLinkWidget(
            icon: 'images/drawer/7.png',
            text: "App ID: 0012".tr,
            onTap: (e) {
              //     Get.toNamed(Routes.ACCOUNT_SETTING);
            },
          ),
          DrawerLinkWidget(
            icon: 'images/drawer/1.png',
            text: "Sign Out".tr,
            onTap: (e) {
              // userdata.remove('imeiNumber');
              // userdata.remove('mobile_number');



              Get.find<AuthService>().removeCurrentUser();
              Get.find<AuthService>().removeProspect();
              Get.find<AuthService>().removeDomain();

              Get.find<AuthService>().removeLogged().then((e){
                Get.offNamed(Routes.SPLASHSCREEN);
              });


            },
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
