import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salebee_latest/models/auth/login_model.dart';
import 'package:salebee_latest/models/auth/new_prospect_list_model.dart';

class AuthService extends GetxService {
  final currentUser = LoginResponseModel().obs;
  final prospectModel = ProspectNewListModel().obs;
  late GetStorage _box;
  final used = false.obs;
  final logged = false.obs;
  final loggedKey = false.obs;
  final checkProspectBool = false.obs;
  final checkDomainBool = false.obs;
  final deviceToken = ''.obs;
  final domainName = ''.obs;
  final getNewProspectLocal = <ProspectList>[].obs;
  final language_key = 'en_US'.obs;

  AuthService() {
    _box = GetStorage();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    _box = GetStorage();
    getAll();
    getCurrentUser();
    super.onInit();
  }

  getAll() {
    getLogged();
    checkLogged();
    checkDomain();
    checkProspect();

  }

  setFirstUseOrNot() async {
    _box.write('used', true);
    getUsed();
  }

  getUsed() {
    if (_box.hasData('used')) {
      used.value = _box.read('used');
    }
  }

  getLogged() {
    if (_box.hasData('logged')) {
      logged.value = _box.read('logged');
    }
  }

  checkLogged() {
    if (_box.hasData('logged')) {
      loggedKey.value = true;
    } else {
      loggedKey.value = false;
    }
  }

  setProspect(ProspectNewListModel model) {
    _box.write('prospectList', model.toJson());
    //getCurrentUser();
  }
  checkProspect() {
    if (_box.hasData('prospectList')) {
      checkProspectBool.value = true;
    } else {
      checkProspectBool.value = false;
    }
  }
  removeProspect(){
    _box.remove('prospectList');
  }


  setDomain(String domain) {
    _box.write('domainName', domain);
    //getCurrentUser();
  }
  getDomain() {
    domainName.value = _box.read('domainName');
  }

  checkDomain() {
    if (_box.hasData('domainName')) {
      checkDomainBool.value = true;
      getDomain() ;
    } else {
      checkDomainBool.value = false;
    }
  }
  removeDomain(){
    _box.remove('domainName');
  }

  setUser(LoginResponseModel user) async {
    _box.write('currentUser', user.toJson());
    getCurrentUser();
  }

  setLogged() async {
    _box.write('logged', true);
  }

  removeLogged() async {
    _box.remove(
      'logged',
    );
    return logged.value;
  }

  getCurrentUser() {
    if (_box.hasData('currentUser')) {
      currentUser.value = LoginResponseModel.fromJson(_box.read('currentUser'));
      print("${_box.read('currentUser')}");
    }
    print('customer data: ${currentUser.value.result!.userName}');
  }

  getProspectList() {
    if (_box.hasData('prospectList')) {
      prospectModel.value =
          ProspectNewListModel.fromJson(_box.read('prospectList'));
      getNewProspectLocal.value = prospectModel.value.result!.prospects;
      print("my prospect from local data ${_box.read('prospectList')}");
    }
    print('prospect data: ${getNewProspectLocal.value.length}');
  }

  Future removeCurrentUser() async {
    currentUser.value = LoginResponseModel();
    await _box.remove('currentUser');
  }

  // bool get isAuth => currentUser.value.user!.accToken! == null ? false : true;

//  String get apiToken => currentUser.value.user!.accToken!;

  getLanguage() async {
    language_key.value = GetStorage().read<String>('language') ?? 'en_US';
  }

// Future<void> getDeviceToken() async {
//   deviceToken.value = await FirebaseMessaging.instance.getToken() ?? '';
//
//   print('AuthService.getDeviceToken:${deviceToken.value}');
// }
}
