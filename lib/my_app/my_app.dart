import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/config/my_theme.dart';
import 'package:to_do_app/core/routes_manager.dart';
import 'package:to_do_app/provider/settings_proviider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.loginRoute,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.carrenTheme,
    );
  }
}
