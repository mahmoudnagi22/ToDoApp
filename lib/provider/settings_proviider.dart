import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode carrenTheme = ThemeMode.light;

  void changeAppTheme(ThemeMode newTheme) {
    if (carrenTheme == newTheme) return;
    carrenTheme = newTheme;
    notifyListeners();
  }
}