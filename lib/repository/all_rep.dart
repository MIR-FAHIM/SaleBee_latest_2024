import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:salebee_latest/api_provider/api_provider.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/services/auth_services.dart';

class AllRepository {
  //"https://${textSubDomainController.text.toString()}.salebee.net/api/Salebee/CheckDomain?hostname=${textSubDomainController.text.toString()}");

  Future checkDomain(Map body, String domain) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICall(
        "https://$domain.salebee.net/api/Salebee/CheckDomain?hostname=$domain",
        body);

    //print('user number: ${response['message']}');
    return response;
  }

  uploadExpenseImage({
    String? token,
    String? eexpenseId,
    List<File>? listImages,
  }) async {
    Map<String, String> data = {
      "Token": token!,
      "ExpenseId": eexpenseId!,
    };

    // string to uri"
    var uri = Uri.parse(ApiUrl.addExpenseImage);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    for (int i = 0; i < listImages!.length; i++) {
      print("hlw 1");
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(listImages[i].openRead()));
      // get file length
      print("hlw 2");
      var length = await listImages[i].length();
      print("hlw 3");
      var multipartFile = new http.MultipartFile(
          'listing_nid[]', stream, length,
          filename: basename(listImages[i].path));
      print("hlw 4");
      request.files.add(multipartFile);
    }

    request.fields.addAll(data);
    request.headers.addAll(
      {
        "Content-Type": "application/json",
      },
    );
    // send
    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(response.body);

    // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print("hlw everyone $value");
    //    a = value;
    // });
    // print("hlw sujkkur ${response.stream}");
    var bb = jsonDecode(response.body);
    return bb;
  }

  Future getMyTask(Map body) async {
    APIManager _manager = APIManager();
    var response =
        await _manager.postAPICallWithEncodedBody(ApiUrl.myTask, body, header: {
      'Content-Type': 'application/json',
    });

    print('get my task resp: $response');
    return response;
  }

  Future addTask(Map body) async {
    APIManager _manager = APIManager();
    var response =
        await _manager.postAPICallWithEncodedBody(ApiUrl.addTask, body, header: {
      'Content-Type': 'application/json',
    });

    print('get my task resp: $response');
    return response;
  }

  Future addExpense(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addExpense, body, header: {
      'Content-Type': 'application/json',
    });

    print('add expense resp: $response');
    return response;
  }

  Future addLead(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addLead, body, header: {
      'Content-Type': 'application/json',
    });

    print('add expense resp: $response');
    return response;
  }
  Future getProduct(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getProduct, body, header: {
      'Content-Type': 'application/json',
    });

    print('get product resp: $response');
    return response;
  }

  Future getAllTask(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.allTaskNew, body, header: {
      'Content-Type': 'application/json',
    });

    print('get all task resp: $response');
    return response;
  }

  Future getAssingedBySomeOneTask(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager.postAPICallWithEncodedBody(
        ApiUrl.assigendBySomeOneTask, body,
        header: {
          'Content-Type': 'application/json',
        });

    print('get assinged to me task resp: $response');
    return response;
  }

  Future getAssignedByMeTask(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.assingedByMeTask, body, header: {
      'Content-Type': 'application/json',
    });

    print('get assigned by me task resp: $response');
    return response;
  }

  Future getAllEmployee(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getALlEmployee, body, header: {
      'Content-Type': 'application/json',
    });

    print('get all employee resp: $response');
    return response;
  }

  Future getPermittedMenu(Map body) async {
    String encodedToken = Uri.encodeComponent(Get.find<AuthService>().currentUser.value.result!.userToken!);

    APIManager _manager = APIManager();
    var response = await _manager
        .get("${ApiUrl.permittedMenu}?Token=$encodedToken",);

    print('get permitted menu resp: $response');
    return response;
  }

  Future getVisit(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getAllVisitList, body, header: {
      'Content-Type': 'application/json',
    });

    print('get visit resp: $response');
    return response;
  }

  Future getEmpIdVisit(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getEmpIdVisit, body, header: {
      'Content-Type': 'application/json',
    });

    print('get emp id visit resp: $response');
    return response;
  }

  Future getTaskStatus() async {
    String encodedToken = Uri.encodeComponent(Get.find<AuthService>().currentUser.value.result!.userToken!);
    APIManager _manager = APIManager();
    var response = await _manager
        .get("${ApiUrl.getTaskStatus}?Token=$encodedToken",);

    print('get task status resp: $response');
    return response;
  }
  Future updateTaskStatus(taskId, statusId) async {
    String encodedToken = Uri.encodeComponent(Get.find<AuthService>().currentUser.value.result!.userToken!);
    APIManager _manager = APIManager();
    var response = await _manager
        .get("${ApiUrl.updateTaskStatus}?Token=$encodedToken&TaskID=$taskId&StatusID=$statusId",);

    print('update task status resp: $response');
    return response;
  }
  Future getTaskType() async {
    String encodedToken = Uri.encodeComponent(Get.find<AuthService>().currentUser.value.result!.userToken!);
    APIManager _manager = APIManager();
    var response = await _manager
        .get("${ApiUrl.getTaskType}?Token=$encodedToken",);

    print('get task type resp: $response');
    return response;
  }

  Future getProspectById(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getALlProspectById, body, header: {
      'Content-Type': 'application/json',
    });

    print('get prospect by id resp: $response');
    return response;
  }

  Future getNewProspectList(String? token) async {
    APIManager _manager = APIManager();
    var response = await _manager.get(
      "${ApiUrl.getNewProspectList}?Token=${Uri.encodeComponent(token!)}",
    );

    print('get prospect new resp: $response');
    return response;
  }

  Future getLead(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getALlLead, body, header: {
      'Content-Type': 'application/json',
    });

    print('get lead resp: $response');
    return response;
  }

  Future getEmployee(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getALlEmployee, body, header: {
      'Content-Type': 'application/json',
    });

    print('get emp list resp: $response');
    return response;
  }

  Future getAllExpense(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getAllExpense, body, header: {
      'Content-Type': 'application/json',
    });

    print('get all expense list resp: $response');
    return response;
  }
  Future updateExpenseStatus(Map body, id, statusId) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody("${ApiUrl.updateExpenseStatus}?expenseClaimId=$id&statusId=$statusId", body, header: {
      'Content-Type': 'application/json',
    });

    print('update expense status expense resp: $response');
    return response;
  }
  Future addExpenseNew(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addExpenseClaim, body, header: {
      'Content-Type': 'application/json',
    });

    print('add expense resp: $response');
    return response;
  }

  Future getProspectStatus(token) async {
    print("status token is $token");
    APIManager _manager = APIManager();
    var response = await _manager
        .getWithHeader("${ApiUrl.getALlProspectStatus}?Token=$token", {
      'Content-Type': 'application/json',
    });

    print('get prospect status: $response');
    return response;
  }
  Future updateProspectStatus(token,String prosId, String  stage) async {
    print("status token is $token");
    APIManager _manager = APIManager();
    var response = await _manager
        .get("${ApiUrl.updateProspect}?Token=$token&ProspectID=$prosId&ProspectStage=$stage",);

    print('update prospect status: $response');
    return response;
  }

  Future getLeadStatus(token) async {
    print("status token is $token");
    APIManager _manager = APIManager();
    var response =
        await _manager.getWithHeader("${ApiUrl.getLeadStatus}?Token=$token", {
      'Content-Type': 'application/json',
    });

    print('get lead status: $response');
    return response;
  }

  Future getFollowUpById(Map body) async {
    //   https://nexzen.salebee.net/api/Salebee/GetAllProspectStage?Token=EZ8UOQ9vIhuX4iPc43nR2ApdsEM7Ad80i4si3vGJ7J3Snz+ZPVeQIzWB7P3EZERUCl2wQzsB3zSLiyLe8YnsnYPhwd5UA4UPFpeH3D9FIaM=
    //   https://nexzen.salebee.net/api/Salebee/GetAllProspectStage?Token=EZ8UOQ9vIhuX4iPc43nR2ApdsEM7Ad80i4si3vGJ7J3Snz%2BZPVeQIzWB7P3EZERUCl2wQzsB3zSLiyLe8YnsnYPhwd5UA4UPFpeH3D9FIaM%3D
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.getAllFollowUpByFilter, body, header: {
      'Content-Type': 'application/json',
    });

    print('get  followup  resp: $response');
    return response;
  }

  Future addCheckIN(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addCheckIn, body, header: {
      'Content-Type': 'application/json',
    });

    print('get check in  resp: $response');
    return response;
  }

  Future addCheckutt(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addCheckOut, body, header: {
      'Content-Type': 'application/json',
    });

    print('get check out  resp: $response');
    return response;
  }

  Future getEmpAttendance(
    Map body,
  ) async {
    APIManager _manager = APIManager();
    var response = await _manager.postAPICallWithEncodedBody(
        "${ApiUrl.getEmpAttendance}EmployeeId=${Get.find<AuthService>().currentUser.value.result!.employeeId!.toString()}",
        body,
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

    print('get emp attendance  resp: $response');
    return response;
  }

  Future getMyReportByMonth(Map body, String empId, String month) async {
    APIManager _manager = APIManager();
    var response = await _manager.postAPICallWithEncodedBody(
        "${ApiUrl.getEmployeeAttendanceByMonth}?EmployeeId=$empId&MonthId=$month",
        body,
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

    print('get emp attendance  resp by month: $response');
    return response;
  }

  Future getAllDalyEmpAttendance(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager.postAPICallWithEncodedBody(
        ApiUrl.allDailyEmpAttendance, body, header: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    print('get all emp daily attendance  resp: $response');
    return response;
  }

  Future updateTask(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.updateTask, body, header: {
      'Content-Type': 'application/json',
    });

    print('update task resp: $response');
    return response;
  }

  Future addVisit(Map body) async {
    APIManager _manager = APIManager();
    var response = await _manager
        .postAPICallWithEncodedBody(ApiUrl.addVisit, body, header: {
      'Content-Type': 'application/json',
    });

    print('add visit resp: $response');
    return response;
  }
}
