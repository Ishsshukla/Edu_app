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
    apiKey: 'AIzaSyC_DX90O2SCzJHFduIz188BHH4WiVeHz3U',
    appId: '1:370513350511:web:fee0322e3275d9d125629a',
    messagingSenderId: '370513350511',
    projectId: 'client1-c2a89',
    authDomain: 'client1-c2a89.firebaseapp.com',
    storageBucket: 'client1-c2a89.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHGSFU1IrE2tpHQdvjDf032-AGtwZwGi8',
    appId: '1:370513350511:android:a8220f16f680e27525629a',
    messagingSenderId: '370513350511',
    projectId: 'client1-c2a89',
    storageBucket: 'client1-c2a89.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZYW7frog5vnN7vR5q98imoW-3Nz9-Ea0',
    appId: '1:370513350511:ios:01b7741b48ff856625629a',
    messagingSenderId: '370513350511',
    projectId: 'client1-c2a89',
    storageBucket: 'client1-c2a89.appspot.com',
    androidClientId: '370513350511-3i2opprhvrtdcpmtr54735iae00596tp.apps.googleusercontent.com',
    iosClientId: '370513350511-n3ptb4edupd0qnekm5d1t1easi7ns664.apps.googleusercontent.com',
    iosBundleId: 'com.example.uig',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZYW7frog5vnN7vR5q98imoW-3Nz9-Ea0',
    appId: '1:370513350511:ios:1de3850c49bb7a6825629a',
    messagingSenderId: '370513350511',
    projectId: 'client1-c2a89',
    storageBucket: 'client1-c2a89.appspot.com',
    androidClientId: '370513350511-3i2opprhvrtdcpmtr54735iae00596tp.apps.googleusercontent.com',
    iosClientId: '370513350511-c6k0ll6nb5p5049nmklbsau0q1n7q471.apps.googleusercontent.com',
    iosBundleId: 'com.example.uig.RunnerTests',
  );
}