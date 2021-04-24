import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImageToFireStore {
  final String path;
  final File file;

  UploadImageToFireStore({this.path, this.file});

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAndGetUrl() async {
    Reference reference = _firebaseStorage
        .ref(path)
        .child(DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await reference.putFile(file);

    String url = await reference.getDownloadURL();
    return url.toString();
  }
}

class UploadVideoToFireStore {
  final String path;
  final Uint8List bytes;

  UploadVideoToFireStore({this.path, this.bytes});

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAndGetUrl() async {
    Reference reference = _firebaseStorage
        .ref(path)
        .child(DateTime.now().millisecondsSinceEpoch.toString() + ".mp4");
    await reference.putData(bytes);

    String url = await reference.getDownloadURL();
    return url.toString();
  }
}
