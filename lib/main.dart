//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/services/location_service.dart';
import 'package:salebee_latest/services/services.dart';


initAllServices() async {
  Get.log('starting all services ...');
  await SharedPreff.to.initial();
  await GetStorage.init();
  // await Get.putAsync<SettingsService>(() async => SettingsService());
  await Get.putAsync<AuthService>(() async => AuthService());
  Get.log('All services started...');
  await Get.putAsync<LocationService>(() async => LocationService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await initAllServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SaleBee",
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'PublicSans',
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
