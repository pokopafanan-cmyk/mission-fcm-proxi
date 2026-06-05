import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class AppTheme {

  static final themeData = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
    ),
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.whiteColor,
    appBarTheme: AppBarTheme(
      // elevation: 0,
      // foregroundColor: Colors.white,
      backgroundColor: AppColor.whiteColor,
      surfaceTintColor: Colors.white,
      iconTheme: IconThemeData(color: const Color(0xFF0973B6),),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      // fillColor: Color.fromRGBO(223, 226, 232, 0.61),
      fillColor: Color(0xFFECEBEB),
      alignLabelWithHint: false,
      labelStyle: TextStyle(color: Color(0xFF6F7380), fontSize: 14,),
      hintStyle: TextStyle(color: Color(0xFF6F7380), fontSize: 14,),
      // contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      constraints: BoxConstraints(minHeight: 48),
    )
  );

  static OutlineInputBorder fieldBorder({Color? color, double? width}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color ?? AppColor.primaryColor,
          width: width ?? 1.0,
        ),
      );

}

