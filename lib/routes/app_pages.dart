import 'package:get/get.dart';
import 'package:salebee_latest/modules/attendance/binding/attendance_binding.dart';
import 'package:salebee_latest/modules/attendance/view/attendance_view.dart';
import 'package:salebee_latest/modules/attendance/view/emp_by_month_report_table.dart';
import 'package:salebee_latest/modules/attendance/view/reason.dart';
import 'package:salebee_latest/modules/auth/binding/auth_binding.dart';
import 'package:salebee_latest/modules/auth/view/login_page.dart';
import 'package:salebee_latest/modules/auth/view/sub_domain_page.dart';
import 'package:salebee_latest/modules/employee/binding/employee_binding.dart';
import 'package:salebee_latest/modules/employee/view/employee.view.dart';
import 'package:salebee_latest/modules/expense/binding/expense_binding.dart';
import 'package:salebee_latest/modules/expense/view/add_expense.dart';
import 'package:salebee_latest/modules/expense/view/expense_view.dart';
import 'package:salebee_latest/modules/follow_up/binding/follow_up_binding.dart';
import 'package:salebee_latest/modules/follow_up/view/add_follow_up.dart';
import 'package:salebee_latest/modules/follow_up/view/follow_up_view.dart';
import 'package:salebee_latest/modules/home/binding/home_binding.dart';
import 'package:salebee_latest/modules/home/view/change_pass_view.dart';
import 'package:salebee_latest/modules/home/view/home_view.dart';
import 'package:salebee_latest/modules/home/view/widget/map_view.dart';
import 'package:salebee_latest/modules/lead/binding/lead_binding.dart';
import 'package:salebee_latest/modules/lead/view/add_lead.dart';
import 'package:salebee_latest/modules/lead/view/lead_view.dart';
import 'package:salebee_latest/modules/prospect/binding/prospect_binding.dart';
import 'package:salebee_latest/modules/prospect/view/prospect_details.dart';
import 'package:salebee_latest/modules/prospect/view/prospect_view.dart';
import 'package:salebee_latest/modules/splash_screen/binding/splash_binding.dart';
import 'package:salebee_latest/modules/splash_screen/view/splash_screeen_view.dart';
import 'package:salebee_latest/modules/task/binding/task_biding.dart';
import 'package:salebee_latest/modules/task/view/add_task_view.dart';
import 'package:salebee_latest/modules/task/view/task_view.dart';
import 'package:salebee_latest/modules/visit/binding/visit_biding.dart';
import 'package:salebee_latest/modules/visit/view/visit_list_by_prospect.dart';
import 'package:salebee_latest/modules/visit/view/visit_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () =>  SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SUBDOMAIN,
      page: () =>  SsubDomainView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.CHANGEPASS,
      page: () =>  changePassView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.MAPVIEW,
      page: () =>  MapView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TASKVIEW,
      page: () =>  TaskView(),
      binding: TaskBinding(),
    ),

    GetPage(
      name: _Paths.ADDTASK,
      page: () =>  AddTaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: _Paths.GETVISIT,
      page: () =>  VisitView(),
      binding: VisitBinding(),
    ),

    GetPage(
      name: _Paths.ADDLEAD,
      page: () =>  AddLeadView(),
      binding: LeadBinding(),
    ),

    GetPage(
      name: _Paths.GETVISITBYPROSPECT,
      page: () =>  VisitListByProspectView(),
      binding: VisitBinding(),
    ),
    GetPage(
      name: _Paths.ADDEXPENSE,
      page: () =>  AddExpenseView(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: _Paths.PROSPECTVIEW,
      page: () =>  ProspectView(),
      binding: ProspectBinding(),
    ),
    GetPage(
      name: _Paths.PROSPECTVIEWDETAIL,
      page: () =>  ProspectDetailsView(),
      binding: ProspectBinding(),
    ),
    GetPage(
      name: _Paths.LEADVIEW,
      page: () =>  LeadView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCEVIEW,
      page: () =>  AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.REASONVIEW,
      page: () =>  AttendanceReason(),
      binding: AttendanceBinding(),
    ),

    GetPage(
      name: _Paths.EMPMONTHTABLE,
      page: () =>  EmpByMonthReportTable(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWUPVIEW,
      page: () =>  FollowUpView(),
      binding: FollowUpBinding(),
    ),

    GetPage(
      name: _Paths.ADDFOLLOWUP,
      page: () =>  AddFollowUpView(),
      binding: FollowUpBinding(),
    ),

    GetPage(
      name: _Paths.EMPLIST,
      page: () =>  EmployeeListView(),
      binding: EmployeeBinding(),
    ),


    GetPage(
      name: _Paths.EXPENSEVIEW,
      page: () =>  ExpenseView(),
      binding: ExpenseBinding(),
    ),

  ];
}
