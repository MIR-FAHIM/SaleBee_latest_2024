import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salebee_latest/common/Color.dart';
import 'package:salebee_latest/common/custom_data.dart';
import 'package:salebee_latest/widgets/block_button_widget.dart';
import 'package:shimmer/shimmer.dart';


class Ui {
  static GetSnackBar SuccessSnackBar({String title = 'Success', required String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message.tr, style: Get.textTheme.caption!.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
    );
  }

  static GetSnackBar ErrorSnackBar({String title = 'Something went wrong!', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message.tr, style: Get.textTheme.caption!.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  static GetSnackBar AuthenticationErrorSnackBar({required String title, required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message.tr, style: Get.textTheme.caption!.merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar defaultSnackBar({String title = 'Alert', required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6!.merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message, style: Get.textTheme.caption!.merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar({String title = 'Notification', required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr, style: TextStyle(color: AppColors.primaryColor)),
      messageText: Text(message, style: TextStyle(color: AppColors.homeTextColor3)),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static BoxDecoration getBoxDecoration({
    Color? color,
    double? radius,
    Border? border,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(color: const Color(0xFF652981).withOpacity(0.3), blurRadius: 2, offset: const Offset(0, 2)),
      ],
      //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration getBoxDecorationImage({Color? color, double? radius, Border? border, Gradient? gradient, String image = ''}) {
    return BoxDecoration(
        //  color: color ?? Get.theme.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        // boxShadow: [
        //   BoxShadow(
        //       color: Get.theme.focusColor.withOpacity(0.1),
        //       blurRadius: 5,
        //       offset: Offset(0, 5)),
        // ],
        border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
        gradient: gradient,
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill

            //CachedNetworkImageProvider(image), fit: BoxFit.fill),
            ));
  }

  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static AlignmentDirectional getAlignmentDirectional(String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static InkWell getIconButton(
      {var icon, double? height, Color? textColor, double horrizontal = 0.0, double vertical = 0.0, double? width, double? radius = 0.0, Color? color, Color? iconColor, text, VoidCallback? press}) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.only(left: horrizontal, right: horrizontal, top: vertical, bottom: vertical),
        height: height,
        width: width,
        decoration: getBoxDecoration(color: color, radius: radius), //BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius!)),
        child: icon != null
            ? Center(
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(color: textColor ?? Get.theme.textTheme.bodyText1!.color),
                ),
              ),
      ),
    );
  }

  static SizedBox customButton(
      {String? text, VoidCallback? press, Color? color, double width = double.infinity, double height = 56, double radius = 20, double fontSize = 18.0, Color textColor = Colors.white}) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          primary: Colors.white,
          backgroundColor: color,
        ),
        onPressed: press,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }

  static InputDecoration getInputDecoration({String hintText = '', String? errorText, IconData? iconData, Widget? suffixIcon, Widget? suffix, String? imageData, imageColor}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.bodySmall,
      prefixIcon: imageData == null
          ? iconData != null
              ? Icon(
                  iconData,
                  color: const Color(0xFF652981),
                ).marginOnly(right: 14)
              : Wrap()
          : Image.asset(
              imageData,
              color: const Color(0xFF652981),
            ).marginOnly(right: 14),
      prefixIconConstraints: const BoxConstraints.expand(width: 38, height: 38),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      focusColor: const Color(0xFF652981),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  static InputDecoration getInputDecorationWithIcon({String hintText = '', String? errorText, IconData? iconData, Widget? suffixIcon, Widget? suffix, imageColor}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      focusColor: const Color(0xFF652981),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  static Widget customSuffixIcon({svgIcon}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        20,
        20,
        20,
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: 18,
      ),
    );
  }

  static Widget shimmerLoader({double? width = 200, double? height = 100, Color? baseColor, Color? highlightColor}) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade50,
      highlightColor: highlightColor ?? Colors.grey.shade200,
      child: Container(height: height, width: width, decoration: Ui.getBoxDecoration()),
    );
  }

  static Widget customLoader() {
    return SpinKitCubeGrid(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: const Color(0xFF652981),
          ),
        );
      },
    );
  }

  static customLoaderSplash() {
    return SpinKitThreeBounce(
      size: 25,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
        );
      },
    );
  }

  static customLoaderDialog() {
    return Get.dialog(SpinKitCubeGrid(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: const Color(0xFF652981),
          ),
        );
      },
    ));
  }

  static customLoaderDialogWithMessage() {
    return Get.defaultDialog(
        title: '',
        radius: 8,
        content: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            width: Get.size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SpinKitThreeBounce(
                  size: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Please Wait'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  static customLoaderDialogWithMEssage() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40),
      child: Container(
        height: 120,
        width: Get.size.width,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SpinKitThreeBounce(
              size: 30,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: index.isEven ? Colors.blue.shade500 : Colors.deepOrange,
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Please Wait'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  static InputDecoration getInputDecorationWithoutCounter(
      {String hintText = '', String? errorText, IconData? iconData, Widget? suffixIcon, Widget? suffix, String? imageData, String? counterText, imageColor}) {
    return InputDecoration(
      counterText: counterText,
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      prefixIcon: imageData == null
          ? iconData != null
              ? Icon(
                  iconData,
                  color: const Color(0xFF652981),
                ).marginOnly(right: 14)
              : Wrap()
          : Image.asset(
              imageData,
              color: const Color(0xFF652981),
            ).marginOnly(right: 14),
      prefixIconConstraints: const BoxConstraints.expand(width: 38, height: 38),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      focusColor: const Color(0xFF652981),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  static noDataFound() {
    return Lottie.asset(
      'assets/nodata.json',
    );
  }

  static showAwesomeDialog(String title, String description, Color? color, VoidCallback? onTap,
      {bool showClose = false, bool isBarrierDismiss = true, String type = 'info', String okay = 'Yes, Proceed'}) {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: type == 'info' ? DialogType.INFO_REVERSED : DialogType.NO_HEADER,
      borderSide: BorderSide(
        color: Get.theme.primaryColor,
        width: 1,
      ),
      btnOkColor: color ?? Colors.yellow.shade500,
      width: Get.size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(25),
      ),
      dismissOnTouchOutside: isBarrierDismiss,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,

      title: title,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      desc: description,
      descTextStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      showCloseIcon: false,

      btnCancel: Column(
        children: [
          BlockButtonWidget(
            color: Get.theme.primaryColor,
            onPressed: onTap,
            text: Text(
              okay,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: size.width * .03,
          ),
          showClose
              ? BlockButtonWidget(
                  color: Colors.red,
                  onPressed: () {
                    Get.back();
                  },
                  text: const Text(
                    'No, Close',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : Wrap(),
          SizedBox(
            height: size.width * .03,
          ),
        ],
      ),

      // btnCancelOnPress: () {
      //   Get.back();
      // },
    ).show();
  }

  static Widget offsetPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text(
              "Flutter Open",
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Flutter Tutorial",
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        icon: const Icon(Icons.arrow_drop_down),
        offset: const Offset(50, 50),
      );
}
