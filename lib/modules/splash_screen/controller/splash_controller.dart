import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:salebee_latest/services/location_service.dart';

class SplashscreenController extends GetxController {
  static SplashscreenController get instance => Get.find();
  RxString splashScreenImages = ''.obs;
  int lastSplashScreenIndex = -1;
  var today = HijriCalendar.now();
  final value = 0.0.obs;
  @override
  Future<void> onInit() async {
    Get.find<AuthService>().getAll();
    print('SplashscreenController.onInit');
    //Get.find<BookingController>().filterdListingController();
    print("my data are splash ${Get.find<AuthService>().loggedKey.value} and ${Get.find<AuthService>().logged.value}");
    Get.find<LocationService>().determinePosition();
    Timer(const Duration(seconds: 3), () {
      if (Get.find<AuthService>().loggedKey.value == true) {
        if (Get.find<AuthService>().logged.value == true) {
          Get.offNamed(Routes.HOME);
          Get.find<AuthService>().getProspectList();
        } else {
          Get.offNamed(Routes.SUBDOMAIN);
        }
      } else {
        Get.offNamed(Routes.SUBDOMAIN);
      }
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
