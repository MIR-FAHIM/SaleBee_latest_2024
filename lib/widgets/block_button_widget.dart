import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/common/custom_data.dart';


class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({Key? key, this.color, this.text, this.width, this.radius, this.onPressed}) : super(key: key);

  final Color? color;
  final Widget? text;
  final double? radius;
  final double? width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? size.width * .8,

      child: MaterialButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: this.color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 10)),
        child: this.text,
        elevation: 0,
      ),
    );
  }
}
