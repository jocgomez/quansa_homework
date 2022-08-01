import 'package:quansa_homework/data/services/local_storage_service.dart';

class TestLocalStorageService implements LocalStorageService {
  /// Variable local poara probar el guardado de datos en local storage
  String? todoItems;

  static Future<TestLocalStorageService> getInstance() async {
    return TestLocalStorageService();
  }

  @override
  String? getString(String key) {
    if (key == 'todos') {
      return todoItems;
    }
    return null;
  }

  @override
  Future<bool> setString(String key, String value) async {
    if (key == 'todos') {
      todoItems = value;
      return true;
    }
    return false;
  }
}
