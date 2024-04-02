import 'package:flutter/material.dart';

class AppColors {
  static Color searchBoxColor = Color(0xffA0C828);
  static Color bottomNavColor = Color(0xff838383);
  static Color secondaryColor = Color(0xff0E153D);
  static Color backgroundColor = Color(0xffffffff);
  static Color textColorWhite = Color(0xffffffff);
  static Color textColorGrey = Colors.grey;

  static Color textColorBlack = Colors.black;

  static Color textColorRed = Colors.red;
  static Color containerColor = Color(0xffFAFAFA);
  static Color colorBlue = Colors.blue;
  static Color appBackGroundBrn = HexColor("#FDF0C3");
  static Color redButton = HexColor("#E39292");

  static Color textColorGreen = HexColor("#139175");
  static Color newAppColor = const Color(0xFF308E72);
  static Color greenButton = HexColor("#92E3A9");
  static Color jaygaTextFldColor = HexColor("#D9F2ED");
  static Color buttonColorYellow = HexColor("#FFCE4E");
  static Color jaygaWhite = HexColor("#FFFCF3");
  static Color jaygaShadowBrwn = HexColor("#FEF5DD");
  static final jaygaAppBackGroundWhite = HexColor("#F2F2F2");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
