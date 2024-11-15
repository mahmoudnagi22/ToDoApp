import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/auth/login/login_screen.dart';
import 'package:to_do_app/presentation/auth/register/register_screen.dart';
import 'package:to_do_app/screens/edit/edit_screen/edit_screen.dart';
import 'package:to_do_app/screens/home_screen.dart';

class RoutesManager {
  static const String homeRoute = "/home";
  static const String registerRoute = "/register";
  static const String loginRoute = "/login";
  static const String editRoute = "/edit";

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case registerRoute:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case editRoute:
        return MaterialPageRoute(
          builder: (context) => EditScreen(),
        );
    }
  }
}
