
import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';

class MyTextStyles{
  static TextStyle? appBarTextStyle = TextStyle(
    color:  ColorsManager.whiteColor,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle? cardTiteleTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blueColor);
  static TextStyle? settingsItemLabelTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF303030));
}