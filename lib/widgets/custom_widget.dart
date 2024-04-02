//Custom Text-field Widgets for Profile and Account

// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/farhana_color_constant.dart';

Widget CustomTextField({
  required BuildContext context,
  required controller,
  required String title,
  required bool obsecure,
  required String hint,
  required readonly,
  IconData? iconName,
  VoidCallback? onPress,

  keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //title of TextFiled
      title.text.size(12).normal.color(titleTextColor).make(),
      8.heightBox,

      //TextFiled
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            15.widthBox,
            Expanded(
                child: TextField(
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  readOnly: readonly,
                  keyboardType: keyboardType,
                  controller: controller,
                  obscureText: obsecure,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap:onPress,


                      child: Icon(
                        iconName,
                        size: 20,
                        color: titleTextColor,
                      ),
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(color: titleTextColor, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ))
          ],
        ),
      )
          .box
          .height(45)
          .width(Get.width * 0.9)
          .roundedSM
          .color(Vx.gray100)
          .border(style: BorderStyle.solid, width: 1, color: borderColor)
          .make(),
    ],
  );
}