
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/data/source/ebda/ebda_service.dart';
import 'package:customer/data/source/firebase/cloud_firestore_service.dart';
import 'package:customer/data/source/firebase/cloud_storage_service.dart';
import 'package:customer/data/source/repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:customer/android/material_app.dart';
import 'package:customer/ios/cupertino_app.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
            create: (_) => Repository(
                ebdaService: EbdaService(),
                cloudFirestoreService: CloudFirestoreService(firestore: Firestore.instance),
                firebaseStorageService: FirebaseStorageService(firebaseStorage: FirebaseStorage.instance)
            ),
            dispose: (_, repository) => repository.dispose()
        ),
      ],
      child: Builder(
        builder: (context) {
          return CupertinoApp();
//          switch (defaultTargetPlatform) {
//            case TargetPlatform.android:
//              return MaterialApp();
//            case TargetPlatform.iOS:
//              return CupertinoApp();
//            default:
//              assert(false, 'Unexpected platform $defaultTargetPlatform');
//              return null;
//          }
        },
      ),
    );
  }
}