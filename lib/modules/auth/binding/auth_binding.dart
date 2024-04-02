import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';



class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
          () => AuthController(),
    );
  }
}
