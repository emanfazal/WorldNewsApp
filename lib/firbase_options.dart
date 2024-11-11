import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: 'AIzaSyClF5cLMgwyAIYQhK9x7ddWc1k3LaarsYw',
      appId: '1:177330646050:android:1a1c688ca43cf4671c6e7b',
      messagingSenderId: '177330646050',
      projectId: 'worldnewsapp-fe630',
      storageBucket: 'worldnewsapp-fe630.appspot.com',
    );
  }
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClF5cLMgwyAIYQhK9x7ddWc1k3LaarsYw',
    appId: '1:177330646050:android:1a1c688ca43cf4671c6e7b',
    messagingSenderId: '177330646050',
    projectId: 'worldnewsapp-fe630',
    storageBucket: 'worldnewsapp-fe630.appspot.com',
  );
}
