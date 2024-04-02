import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }
}
