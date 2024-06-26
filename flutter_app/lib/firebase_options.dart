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
    apiKey: 'AIzaSyCEC7MARvaJew_XZwtInuRjDNZnjkQ_15s',
    appId: '1:217960647728:web:551f1c342289b709f271f5',
    messagingSenderId: '217960647728',
    projectId: 'test2-4def8',
    authDomain: 'test2-4def8.firebaseapp.com',
    storageBucket: 'test2-4def8.appspot.com',
    measurementId: 'G-EKX0WD16P0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUTgXhf3fxwHex13nYoInTutL-PziIOF0',
    appId: '1:217960647728:android:9dda2e1a2776c2f0f271f5',
    messagingSenderId: '217960647728',
    projectId: 'test2-4def8',
    storageBucket: 'test2-4def8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuTs_6CqBTAInYywFQkyIOc0vC7NlCJUs',
    appId: '1:217960647728:ios:cdc5e18368c29cf3f271f5',
    messagingSenderId: '217960647728',
    projectId: 'test2-4def8',
    storageBucket: 'test2-4def8.appspot.com',
    iosClientId: '217960647728-r2jn7gfjak5cs5v893g21vdhcgcfefij.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuTs_6CqBTAInYywFQkyIOc0vC7NlCJUs',
    appId: '1:217960647728:ios:cdc5e18368c29cf3f271f5',
    messagingSenderId: '217960647728',
    projectId: 'test2-4def8',
    storageBucket: 'test2-4def8.appspot.com',
    iosClientId: '217960647728-r2jn7gfjak5cs5v893g21vdhcgcfefij.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApp',
  );
}
