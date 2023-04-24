import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static Color primarySwatch = Colors.orange;
  static Color primaryColor = Color(0xFF3f94fe);
  static Color primaryColorLight = Color.fromARGB(255, 255, 119, 74);
  static Color primaryColorDark = Color.fromARGB(255, 190, 51, 5);
  static Color backgroundColor = Color(0xFFFFFFFF);
  static Color backgroundColorLight = Color(0xFFFFFFFF);
  static Color backgroundColorDark = Color(0xFFF9F9F9);
  static Color dividerColor = Color(0x2CF3FFF3);
  static Color textPinkColor = Color(0xFFfa8a80);
  static Color textColor = Color(0xFF272727);
  static Color textColorDark = Color(0xFF152715);
  static Color textColorLight = Color(0xFF4C4C4C);
  static Color disabledColorLight = Color(0xFFF3F3F3);
  static Color disabledColor = Color(0xFFC3C5C3);
  static Color disabledColorDark = Color(0xFF7C7C7C);
  static Color secondaryColor = Color(0xFF388E8A);
  static Color secondaryColorLight = Color(0xFF66BB97);
  static Color secondaryColorDark = Color(0xFF1F7954);
  static Color successColor = Color(0xFF47AD55);
  static Color errorColor = Color(0xFFC04848);
  static Color warningColor = Color(0xFFAD9A47);
  static Color brightColor = Color(0xFFF1F1F1);
  static Color blueColor = Color(0xFF3f94fe);
  static Color goldColor = Color.fromARGB(255, 255, 235, 57);
  static Color oldPaperColor = Color(0xFFFFF9C4);
  static Color greyColor = Color(0xFF898989);
  static Color greyColorLight = Color(0xFF898989);
  static Color greyColorDark = Color.fromARGB(255, 94, 94, 94);

  static List<BoxShadow> boxShadows = [
    BoxShadow(
        offset: Offset(2, 2),
        blurRadius: 2,
        color: AppTheme.greyColorLight.withOpacity(0.5))
  ];

  static ThemeData get light => ThemeData(
      scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: true,
          thickness: MaterialStateProperty.all(8.h),
          thumbColor: MaterialStateProperty.all(Colors.black),
          radius: Radius.circular(8.h),
          trackColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
          minThumbLength: 8.h),
      brightness: Brightness.light,
      fontFamily: "Roboto",
      primarySwatch: Colors.blue,
      primaryColor: blueColor,
      primaryColorLight: blueColor,
      primaryColorDark: primaryColorDark,
      backgroundColor: backgroundColor);

  // dark mode
  static ThemeData get dark => ThemeData(
      scrollbarTheme: ScrollbarThemeData(
          isAlwaysShown: true,
          thickness: MaterialStateProperty.all(8.h),
          thumbColor: MaterialStateProperty.all(Colors.black),
          radius: Radius.circular(8.h),
          trackColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
          minThumbLength: 8.h),
      brightness: Brightness.dark,
      fontFamily: "Cabin",
      primarySwatch: Colors.orange,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      backgroundColor: backgroundColor);

  //   ThemeData _darkTheme = ThemeData(
  // accentColor: Colors.red,
  // brightness: Brightness.dark,
  // primaryColor: Colors.amber,
  // buttonTheme: ButtonThemeData(
  //   buttonColor: Colors.amber,
  //   disabledColor: Colors.grey,
  // ));
}
