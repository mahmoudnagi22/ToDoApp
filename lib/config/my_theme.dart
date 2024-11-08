import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/core/my_text_styles.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    indicatorColor: Colors.white,
    primaryColor: ColorsManager.blueColor,
    canvasColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      centerTitle: true,
      titleTextStyle:  TextStyle(
        color:  ColorsManager.whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.lightScaffold,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 32,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorsManager.whiteColor,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    cardTheme: const CardTheme(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      color: Colors.transparent,
      elevation: 0,
    ),
    dividerColor: ColorsManager.blueColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.whiteColor, width: 4),
      ),
      elevation: 12,
      iconSize: 26,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorsManager.blueColor),
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF303030),
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color(0xFF383838),
      ),
      headlineSmall: TextStyle(
        color: ColorsManager.greyTextBottomSheet,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    indicatorColor: Color(0xFF141922),
    primaryColor: ColorsManager.blueColor,
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      centerTitle: true,
      titleTextStyle:  TextStyle(
        color:  ColorsManager.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 32,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorsManager.blackAccent,
      shape: CircularNotchedRectangle(),
      elevation: 14,
    ),
    cardTheme: const CardTheme(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      color: ColorsManager.blackAccent,
      elevation: 20,
    ),
    dividerColor: ColorsManager.blueColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.whiteColor, width: 4),
      ),
      backgroundColor: ColorsManager.blackAccent,
      elevation: 12,
      iconSize: 26,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.blackAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorsManager.blueColor),
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: ColorsManager.whiteColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ColorsManager.whiteColor,
      ),
      headlineSmall: TextStyle(
        color: ColorsManager.greyTextBottomSheet,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headlineLarge: TextStyle(
        color: ColorsManager.greyTextBottomSheet,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),

    ),
  );
}
