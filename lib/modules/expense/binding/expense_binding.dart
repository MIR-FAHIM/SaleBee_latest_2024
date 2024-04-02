import 'package:get/get.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/employee/controller/employee_controller.dart';
import 'package:salebee_latest/modules/expense/controller/expense_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/lead/controller/lead_controller.dart';
import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';
import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/modules/task/controller/task_controller.dart';
import 'package:salebee_latest/modules/visit/controller/visit_controller.dart';



class ExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseController>(
          () => ExpenseController(),
    );
  }
}
