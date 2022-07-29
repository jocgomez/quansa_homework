import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:quansa_homework/data/services/storage_service.dart';
import 'package:quansa_homework/firebase_options.dart';

class FirebaseStorageService implements StorageService {
  static FirebaseStorageService _instance = FirebaseStorageService();
  static firebase_storage.FirebaseStorage? storage;

  @override
  Future<FirebaseStorageService> initializeService() async {
    _instance = FirebaseStorageService();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storage = firebase_storage.FirebaseStorage.instance;
    return _instance;
  }

  /// Se define la ruta donde se guardaran las fotos
  /// Se guarda y se obtiene la url de la foto almacenada
  @override
  Future<String?> uploadFile(File photo, String todoId) async {
    const String destination = 'todosImages/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(todoId);
      await ref.putFile(photo);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error al subir la foto: $e');
      return null;
    }
  }

  /// Remueve la foto del storage a partir de la url
  @override
  Future removeFile(String photoUrl) async {
    firebase_storage.FirebaseStorage.instance.refFromURL(photoUrl).delete();
  }
}
