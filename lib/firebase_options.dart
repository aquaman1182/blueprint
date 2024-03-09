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
    apiKey: 'AIzaSyCwKawioRZYla2i6UhLkwT0_auuRgBC3oY',
    appId: '1:670029978353:web:9bb809b81d594eeb976750',
    messagingSenderId: '670029978353',
    projectId: 'blueprint-a3a53',
    authDomain: 'blueprint-a3a53.firebaseapp.com',
    databaseURL: 'https://blueprint-a3a53-default-rtdb.firebaseio.com',
    storageBucket: 'blueprint-a3a53.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEdA278yfwna854X-0I7-jN_X7AqaZeBY',
    appId: '1:670029978353:android:6736b379f3c13f81976750',
    messagingSenderId: '670029978353',
    projectId: 'blueprint-a3a53',
    databaseURL: 'https://blueprint-a3a53-default-rtdb.firebaseio.com',
    storageBucket: 'blueprint-a3a53.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8ry0ox5t9qYSQfyynH_s_Z7lXK8ECzaE',
    appId: '1:670029978353:ios:719df3ea55a85cf1976750',
    messagingSenderId: '670029978353',
    projectId: 'blueprint-a3a53',
    databaseURL: 'https://blueprint-a3a53-default-rtdb.firebaseio.com',
    storageBucket: 'blueprint-a3a53.appspot.com',
    iosBundleId: 'com.example.blueprint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8ry0ox5t9qYSQfyynH_s_Z7lXK8ECzaE',
    appId: '1:670029978353:ios:79d728d5ab8e5051976750',
    messagingSenderId: '670029978353',
    projectId: 'blueprint-a3a53',
    databaseURL: 'https://blueprint-a3a53-default-rtdb.firebaseio.com',
    storageBucket: 'blueprint-a3a53.appspot.com',
    iosBundleId: 'com.example.blueprint.RunnerTests',
  );
}