import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/my_app/my_app.dart';
import 'package:to_do_app/provider/settings_proviider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await FirebaseFirestore.instance.disableNetwork();
  runApp(  ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: MyApp()));
}

