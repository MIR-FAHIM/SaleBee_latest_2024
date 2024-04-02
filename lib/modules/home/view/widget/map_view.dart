import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/home/view/widget/main_drawer_widget.dart';

import 'package:salebee_latest/modules/splash_screen/controller/splash_controller.dart';
import 'package:salebee_latest/services/auth_services.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';
import 'package:salebee_latest/utils/ui_support.dart';

class MapView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
   double lat = Get.arguments[0];
   double lon = Get.arguments[1];
    Size size = MediaQuery.of(context).size;
    print("lat lon in map are $lat and $lon");

    return Obx(() {
      return Scaffold(
          endDrawer: MainDrawerWidget(),
          appBar: AppBar(
            title: Text(
              "Hellow,  ${Get.find<AuthService>().currentUser.value.result!.userName}",
              style: TextStyle(fontSize: 12),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    zoomControlsEnabled: true,
                    scrollGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          lat, lon),
                      zoom: 15,
//target: LatLng(23.797911, 90.414391),
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: LatLng(
                            lat,lon),
                        infoWindow: const InfoWindow(
                          title: 'Selected Location',
                        ),
                      ),
                    }),
              ),
            ],
          ));
    });
  }
}
//
