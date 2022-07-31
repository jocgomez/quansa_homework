import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance = LocalStorageService();
  static SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  SharedPreferences? _getPreferences() {
    return _preferences;
  }

  String? getString(String key) {
    return _getPreferences()?.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return _getPreferences()?.setString(key, value) ?? Future(() => false);
  }
}
