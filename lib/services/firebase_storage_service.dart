import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageService {
  Future uploadFile(File photo, String todoId) async {
    return;
  }

  Future getFile() async {
    return;
  }
}

class FirebaseStorageService implements StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future uploadFile(File photo, String todoId) async {
    const String destination = 'todosImages/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(todoId);
      await ref.putFile(photo);
    } catch (e) {
      print('error occured');
      return null;
    }
  }

  @override
  Future getFile() async {
    try {
      String downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('todosImages/')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
