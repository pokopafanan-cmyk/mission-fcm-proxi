import 'package:flutter/material.dart';

class AppFontWeight {


  static FontWeight fw1 = FontWeight.w100;
  static FontWeight fw2 = FontWeight.w200;
  static FontWeight fw3 = FontWeight.w300;
  static FontWeight fw4 = FontWeight.w400;
  static FontWeight fw5 = FontWeight.w500;
  static FontWeight fw6 = FontWeight.w600;
  static FontWeight fw7 = FontWeight.w700;
  static FontWeight fw8 = FontWeight.w800;
  static FontWeight fw9 = FontWeight.w900;


}

class AppSize {

  static double screenPadding = 15.0;

  static double spacingDefault = 15;

  static double spacingDefaultPadding = 15;
  static double fieldFontSize = 14;
  static double fieldMarginBottom = 20;










  static double getHeight({
    required BuildContext context,
    required double height,
  }) => MediaQuery.of(context).size.height * height;

  static double getWidth({
    required BuildContext context,
    required double width,
  }) => MediaQuery.of(context).size.width * width;
}
