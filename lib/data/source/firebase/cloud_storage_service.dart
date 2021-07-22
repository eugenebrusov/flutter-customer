
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService._(this._firebaseStorage);

  factory FirebaseStorageService({@required FirebaseStorage firebaseStorage}) {
    return FirebaseStorageService._(firebaseStorage);
  }

  final FirebaseStorage _firebaseStorage;

  Future<dynamic> productImageUrlFuture(String image) =>
      _firebaseStorage.ref().child(image).getDownloadURL();
}