

import 'package:salebee_latest/api_provider/api_provider.dart';
import 'package:salebee_latest/api_provider/api_url.dart';

class AuthRepository {
  //"https://${textSubDomainController.text.toString()}.salebee.net/api/Salebee/CheckDomain?hostname=${textSubDomainController.text.toString()}");


  Future checkDomain(Map body, String domain) async {


    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICall("https://$domain.salebee.net/api/Salebee/CheckDomain?hostname=$domain", body);

    //print('user number: ${response['message']}');
    return response;
  }

  Future loginRep(Map body) async {


    APIManager _manager = APIManager();
    var response =
    await _manager.postAPICallWithEncodedBody(ApiUrl.login, body, header: {'Content-Type': 'application/json',});

    print('login resp: $response');
    return response;
  }

  Future changePassRep(Map body) async {


    APIManager _manager = APIManager();
    var response =
    await _manager.postAPICallWithEncodedBody(ApiUrl.changePass, body, header: {'Content-Type': 'application/json',});

    print('change pass resp: $response');
    return response;
  }

}
