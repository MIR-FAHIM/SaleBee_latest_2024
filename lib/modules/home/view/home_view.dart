
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/modules/auth/controller/auth_controller.dart';
import 'package:salebee_latest/modules/home/controller/home_controller.dart';
import 'package:salebee_latest/modules/home/view/widget/dragable_widget.dart';
import 'package:salebee_latest/modules/home/view/widget/main_drawer_widget.dart';
import 'package:salebee_latest/services/auth_services.dart';



class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.advancedStatusCheck();
    Size size = MediaQuery.of(context).size;
        return Obx(
           () {
            return Scaffold(
                endDrawer: MainDrawerWidget(),
              appBar: AppBar(
                 title: Text("Hellow,  ${Get.find<AuthService>().currentUser.value.result!.userName}",style: TextStyle(fontSize: 12),),
              ),
              body:
              size.height < 550
                  ?Center(
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 1.3,
                      transform: Matrix4.translationValues(
                          -(size.width / 2), 0.0, 0.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),

                    // Profile picture in the center
                    Container(
                      transform: Matrix4.translationValues(
                          -(size.width / 4.5), (size.height / 5.5), 0.0),
                      child:Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!.startsWith("/", 0)
                          ? CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            ApiUrl.mainUrl+Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!),
                      )
                          : CircleAvatar(
                        radius: 100,
                        backgroundImage:
                        NetworkImage(Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!),
                      ),
                    ),
                    // Draggable menu buttons
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[0].label!,
                      image: controller.menuItems[0].image!,

                      index: 0,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 180.0 + 100.0 * sin(2 *4 * pi / 2),
                      left: 160.0 + 0.0 * cos(2 * 2 * pi / 5),
                    ),
                    //first before
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[1].label!,
                      image: controller.menuItems[1].image!,

                      index: 1,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 80.0 + 130.0 * sin(0 * 2 * pi / 2),
                      left: 120.0 + 10.0 * cos(0 * 2 * pi / 4),
                    ),
                    //first one
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[2].label!,
                      image: controller.menuItems[2].image!,

                      index: 2,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 20.0 + 100.0 * sin(2 *4 * pi / 2),
                      left: 180.0 + 200.0 * cos(2 * 2 * pi / 5),
                    ),
                    // last one
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[3].label!,
                      image: controller.menuItems[3].image!,

                      index: 3,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 80.0 + 270.0 * sin(3 * 2 * pi / 15),
                      left: 180.0 + 200.0 * cos(3 * 2 * pi / 5),
                    ),
                    //last before
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[4].label!,
                      image: controller.menuItems[4].image!,
                      index: 4,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 100.0 + 200.0 * sin(3 * 2 * pi / 15),
                      left: 100.0 + 50.0 * cos(4 * 2 * pi / 5),
                    ),
                  ],
                ),
              )
                  :
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 1.4,
                      transform: Matrix4.translationValues(
                          -(size.width / 3), 0.0, 0.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),

                    // Profile picture in the center
                    Container(
                      transform: Matrix4.translationValues(
                          -(size.width / 4.5), (size.height / 5.5), 0.0),
                      child:Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!.startsWith("/", 0)
                          ? CircleAvatar(
                        radius: 140,
                        backgroundImage: NetworkImage(
                            ApiUrl.mainUrl+Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!),
                      )
                          : CircleAvatar(
                        radius: 140,
                        backgroundImage:
                        NetworkImage(Get.find<AuthService>().currentUser.value.result!.userProfileImageLink!),
                      ),
                    ),
                    // Draggable menu buttons
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[0].label!,
                      image: controller.menuItems[0].image!,

                      index: 0,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 250.0 + 100.0 * sin(2 *4 * pi / 2),
                      left: 240.0 + 0.0 * cos(2 * 2 * pi / 5),
                    ),
                    //first before
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[1].label!,
                      image: controller.menuItems[1].image!,

                      index: 1,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 100.0 + 130.0 * sin(0 * 2 * pi / 2),
                      left: 170.0 + 10.0 * cos(0 * 2 * pi / 4),
                    ),
                    //first one
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[2].label!,
                      image: controller.menuItems[2].image!,

                      index: 2,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 40.0 + 100.0 * sin(2 *4 * pi / 2),
                      left: 200.0 + 200.0 * cos(2 * 2 * pi / 5),
                    ),
                    // last one
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[3].label!,
                      image: controller.menuItems[3].image!,

                      index: 3,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 200.0 + 270.0 * sin(3 * 2 * pi / 15),
                      left: 200.0 + 200.0 * cos(3 * 2 * pi / 5),
                    ),
                    //last before
                    DraggableCircularButton(
                      key: GlobalKey(),
                      label: controller.menuItems[4].label!,
                      image: controller.menuItems[4].image!,
                      index: 4,
                      onDrop: (int oldIndex, int newIndex) {
                        final  temp = controller.menuItems[oldIndex];
                        controller.menuItems[oldIndex] = controller.menuItems[newIndex];
                        controller.menuItems[newIndex] = temp;
                      },
                      top: 200.0 + 200.0 * sin(3 * 2 * pi / 15),
                      left: 150.0 + 50.0 * cos(4 * 2 * pi / 5),
                    ),
                  ],
                ),
              )
            );
          }
        );

  }
}
//
