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
    apiKey: 'AIzaSyAtTyfd-LGihPT-s8uQs2Mp6BlLgJ6IB2k',
    appId: '1:863508063918:web:99640162dfd7675b9eaf3f',
    messagingSenderId: '863508063918',
    projectId: 'tweetapp-b113c',
    authDomain: 'tweetapp-b113c.firebaseapp.com',
    storageBucket: 'tweetapp-b113c.appspot.com',
    measurementId: 'G-7ZBSD5Q9N5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqAaVST1paZCPLOU6sZOYO5uV-WO89oiU',
    appId: '1:863508063918:android:5e13eba63e01487a9eaf3f',
    messagingSenderId: '863508063918',
    projectId: 'tweetapp-b113c',
    storageBucket: 'tweetapp-b113c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCty2QYp-tM52PYQbROKdQxr5N2wAHPEn4',
    appId: '1:863508063918:ios:f2a2a507ffdbff4f9eaf3f',
    messagingSenderId: '863508063918',
    projectId: 'tweetapp-b113c',
    storageBucket: 'tweetapp-b113c.appspot.com',
    iosBundleId: 'com.example.tweetapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCty2QYp-tM52PYQbROKdQxr5N2wAHPEn4',
    appId: '1:863508063918:ios:f2a2a507ffdbff4f9eaf3f',
    messagingSenderId: '863508063918',
    projectId: 'tweetapp-b113c',
    storageBucket: 'tweetapp-b113c.appspot.com',
    iosBundleId: 'com.example.tweetapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtTyfd-LGihPT-s8uQs2Mp6BlLgJ6IB2k',
    appId: '1:863508063918:web:f1425fe70111a4879eaf3f',
    messagingSenderId: '863508063918',
    projectId: 'tweetapp-b113c',
    authDomain: 'tweetapp-b113c.firebaseapp.com',
    storageBucket: 'tweetapp-b113c.appspot.com',
    measurementId: 'G-X7P2BYBL8R',
  );
}
