import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/firebase_options.dart';

class FirebaseStorageService implements StorageService {
  static FirebaseStorageService _instance = FirebaseStorageService();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<FirebaseStorageService> initializeService() async {
    _instance = FirebaseStorageService();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return _instance;
  }

  @override
  Future uploadFile(File photo, String todoId) async {
    const String destination = 'todosImages/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(todoId);
      await ref.putFile(photo);
    } catch (e) {
      print('error occured uploading file');
      return null;
    }
  }

  @override
  Future getFile(String todoId) async {
    try {
      String downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('todosImages/$todoId.jpeg')
          .getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('error occured reading file');
      return null;
    }
  }
}
