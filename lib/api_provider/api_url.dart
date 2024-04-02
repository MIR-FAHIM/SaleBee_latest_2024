import 'package:salebee_latest/services/services.dart';

class ApiUrl {
  String api_token = '';
  static String googleMapApiKey = '';
  static String baseUrl =
      "https://${SharedPreff.to.prefss.getString("domain")}.salebee.net/api/Salebee";
  static String mainUrl =
      "https://${SharedPreff.to.prefss.getString("domain")}.salebee.net/";
  static String login = '$baseUrl/Login';
  static String changePass = '$baseUrl/ChangePassword';

  static String addVisit = '$baseUrl/AddEmployeeVisit';
  static String myTask = '$baseUrl/MyTask';
  static String addExpense = '$baseUrl/AddExpenseClaim';
  static String addLead = '$baseUrl/AddLead';
  static String getProduct = '$baseUrl/GetProducts';
  static String addExpenseImage = '$baseUrl/AddExpenseFiles';
  static String assigendBySomeOneTask = '$baseUrl/AllTaskAssignedToMe';
  static String assingedByMeTask = '$baseUrl/AllTaskAssignedByMe';
  static String allTask = '$baseUrl/AllTask';
  static String updateTask = '$baseUrl/UpdateTask';
  static String getAllVisitList = '$baseUrl/GetAllVisitList';
  static String getEmpIdVisit = '$baseUrl/GetEmployeeVisitList';
  static String getALlEmployee = '$baseUrl/AllActiveEmployeeForApp';
  static String getALlProspectById = '$baseUrl/GetAllProspectByAssignedUserId';
  static String getNewProspectList = '$baseUrl/GetAllProspects';
  static String getALlLead = '$baseUrl/GetLead';
  static String getALlProspectStatus = '$baseUrl/GetAllProspectStage';
  static String getLeadStatus = '$baseUrl/GetAllLeadStage';
  static String addCheckIn = '$baseUrl/CheckIn';
  static String addCheckOut = '$baseUrl/CheckOut';
  static String getEmpAttendance = '$baseUrl/GetEmployeeAttendance?';
  static String allDailyEmpAttendance = '$baseUrl/LoadAttendanceDataList';
  static String prospectFollowUpbyId = '$baseUrl/ProspectFollowupById';
  static String allActiveEmpList = '$baseUrl/AllActiveEmployeeForApp';
  static String getAllExpense = '$baseUrl/GetAllExpenseClaim';
  static String addExpenseClaim = '$baseUrl/AddExpenseClaim';
  static String updateExpenseStatus = '$baseUrl/UpdateExpenseStatus';
  static String getEmployeeAttendanceByMonth = '$baseUrl/GetEmployeeAttendanceByMonth';
  static String addExpenseFile = '$baseUrl/AddExpenseFiles';
  static String addFollowUp = '$baseUrl/AddProspectFollowupLogActivity';
  static String permittedMenu = '$baseUrl/GetAllPermittedMenu';

}
