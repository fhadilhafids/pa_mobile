// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB3sqI0jMzhyAawGiGGBxW5j9qjsyfdATc',
    appId: '1:73557118298:web:10646879bef3b3a887f763',
    messagingSenderId: '73557118298',
    projectId: 'pa-mobile-18279',
    authDomain: 'pa-mobile-18279.firebaseapp.com',
    storageBucket: 'pa-mobile-18279.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ70_7Ihn6SfyfYn3_g4wOQJaEYwWRseU',
    appId: '1:73557118298:android:74fb30f88f70445687f763',
    messagingSenderId: '73557118298',
    projectId: 'pa-mobile-18279',
    storageBucket: 'pa-mobile-18279.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKuwfEKluhCPuIP5Zkas96PDtBB60l4ss',
    appId: '1:73557118298:ios:bb77db876377c58f87f763',
    messagingSenderId: '73557118298',
    projectId: 'pa-mobile-18279',
    storageBucket: 'pa-mobile-18279.appspot.com',
    iosBundleId: 'com.example.paMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKuwfEKluhCPuIP5Zkas96PDtBB60l4ss',
    appId: '1:73557118298:ios:84924866240ff90087f763',
    messagingSenderId: '73557118298',
    projectId: 'pa-mobile-18279',
    storageBucket: 'pa-mobile-18279.appspot.com',
    iosBundleId: 'com.example.paMobile.RunnerTests',
  );
}
