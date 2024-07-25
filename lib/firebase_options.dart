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
    apiKey: 'AIzaSyBcL6Iz2YyuXjC0fgVuzyZJ58IbfMgIcos',
    appId: '1:24001240351:web:a52dd221f5c2135b54e42a',
    messagingSenderId: '24001240351',
    projectId: 'campusmart-5aac2',
    authDomain: 'campusmart-5aac2.firebaseapp.com',
    storageBucket: 'campusmart-5aac2.appspot.com',
    measurementId: 'G-T0T3JBZSXG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_ankTrYn-9V7Ck2hx8FCfK6_vii7rEKw',
    appId: '1:24001240351:android:7023ac9a8f4d957054e42a',
    messagingSenderId: '24001240351',
    projectId: 'campusmart-5aac2',
    storageBucket: 'campusmart-5aac2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrFFsv9zoRh6QwRx0XZZrMZ_yng6QzAj8',
    appId: '1:24001240351:ios:cbfabf5a23d16d3054e42a',
    messagingSenderId: '24001240351',
    projectId: 'campusmart-5aac2',
    storageBucket: 'campusmart-5aac2.appspot.com',
    iosBundleId: 'com.pollex.campus-mart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrFFsv9zoRh6QwRx0XZZrMZ_yng6QzAj8',
    appId: '1:24001240351:ios:af85f04b9ccb144f54e42a',
    messagingSenderId: '24001240351',
    projectId: 'campusmart-5aac2',
    storageBucket: 'campusmart-5aac2.appspot.com',
    iosClientId: '24001240351-7tt3l65cgua68aqtl1md4kjmajj37vt8.apps.googleusercontent.com',
    iosBundleId: 'com.example.campusMart',
  );
}