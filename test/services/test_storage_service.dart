import 'dart:io';

import 'package:quansa_homework/data/services/storage_service.dart';

class TestStorageService implements StorageService {
  @override
  Future<StorageService> initializeService() async {
    return this;
  }

  @override
  Future removeFile(String todoId) async {
    return true;
  }

  @override
  Future uploadFile(File photo, String todoId) async {
    return 'https://firebasestorage.googleapis.com/v0/b/quansa-homework.appspot.com/o/todosImages%2FOvMZBs9.jpeg?alt=media&token=08e91e36-77da-455c-bd1e-de1d6a8fb1ab';
  }
}
