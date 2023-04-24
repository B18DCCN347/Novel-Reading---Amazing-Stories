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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCGr7MtmtMWEFxXpnEqjzmP5JFN26H_4rg',
    appId: '1:563939260698:web:17632307536b8f4d0354a3',
    messagingSenderId: '563939260698',
    projectId: 'novel-reading',
    authDomain: 'novel-reading.firebaseapp.com',
    storageBucket: 'novel-reading.appspot.com',
    measurementId: 'G-RT99RGR3RB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuR6lZ0Hnlb9lcwApCg3Qck95h4XGbHTI',
    appId: '1:563939260698:android:19793a709ea4f1a40354a3',
    messagingSenderId: '563939260698',
    projectId: 'novel-reading',
    storageBucket: 'novel-reading.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxWf9rBR-YryfiSD_ZcxAUWoUiiuGILaE',
    appId: '1:563939260698:ios:6f08f39ae745564e0354a3',
    messagingSenderId: '563939260698',
    projectId: 'novel-reading',
    storageBucket: 'novel-reading.appspot.com',
    iosClientId: '563939260698-9ui8sjo1ljhgf3od4iqltuft44c0cigj.apps.googleusercontent.com',
    iosBundleId: 'com.novelwordstudio.booklovenovelfull',
  );
}
