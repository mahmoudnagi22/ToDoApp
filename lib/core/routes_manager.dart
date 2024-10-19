import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_screen.dart';

class RoutesManager{
  static const String homeRoute= "/home";


 static Route<dynamic>? router(RouteSettings settings){
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);

    }
  }
}