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
    apiKey: 'AIzaSyAe0W9Z9aQEWL2cEbcnAnY3GLPXEbIuFR8',
    appId: '1:742061279195:web:6a93f184f73995bc0989fe',
    messagingSenderId: '742061279195',
    projectId: 'recipe-hub-f8bf0',
    authDomain: 'recipe-hub-f8bf0.firebaseapp.com',
    storageBucket: 'recipe-hub-f8bf0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDH0DXQ0EDrWiZ6rLUhqCftO6LnNBiJOkY',
    appId: '1:742061279195:android:d83a905f71fa490b0989fe',
    messagingSenderId: '742061279195',
    projectId: 'recipe-hub-f8bf0',
    storageBucket: 'recipe-hub-f8bf0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnXlhiji--PPmXburYv9mS-_88LRvKFmY',
    appId: '1:742061279195:ios:b30f706f5f973af60989fe',
    messagingSenderId: '742061279195',
    projectId: 'recipe-hub-f8bf0',
    storageBucket: 'recipe-hub-f8bf0.appspot.com',
    iosBundleId: 'com.example.recipeHub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnXlhiji--PPmXburYv9mS-_88LRvKFmY',
    appId: '1:742061279195:ios:d9538171937e143e0989fe',
    messagingSenderId: '742061279195',
    projectId: 'recipe-hub-f8bf0',
    storageBucket: 'recipe-hub-f8bf0.appspot.com',
    iosBundleId: 'com.example.recipeHub.RunnerTests',
  );
}
