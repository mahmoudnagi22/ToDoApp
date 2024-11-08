// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtG56UNQS8QTbSbFnYx2uVG7RRwkI3iL8',
    appId: '1:553108565329:web:cc3495df9b79af6eba3770',
    messagingSenderId: '553108565329',
    projectId: 'todo-56532',
    authDomain: 'todo-56532.firebaseapp.com',
    storageBucket: 'todo-56532.appspot.com',
    measurementId: 'G-XSRLLGFGJ5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnG8ajzsP4Lzx1dQ5U9XoHcV-6SIbVVAg',
    appId: '1:553108565329:android:7f40a09bee4356b8ba3770',
    messagingSenderId: '553108565329',
    projectId: 'todo-56532',
    storageBucket: 'todo-56532.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEWlrsJQ6Glqnjohfh7KsNmtOIei6dmDY',
    appId: '1:553108565329:ios:42a8d5ab69f7f57fba3770',
    messagingSenderId: '553108565329',
    projectId: 'todo-56532',
    storageBucket: 'todo-56532.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEWlrsJQ6Glqnjohfh7KsNmtOIei6dmDY',
    appId: '1:553108565329:ios:42a8d5ab69f7f57fba3770',
    messagingSenderId: '553108565329',
    projectId: 'todo-56532',
    storageBucket: 'todo-56532.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDtG56UNQS8QTbSbFnYx2uVG7RRwkI3iL8',
    appId: '1:553108565329:web:8e9e4bfc039f2cc0ba3770',
    messagingSenderId: '553108565329',
    projectId: 'todo-56532',
    authDomain: 'todo-56532.firebaseapp.com',
    storageBucket: 'todo-56532.appspot.com',
    measurementId: 'G-DKY0DVHKNE',
  );

}