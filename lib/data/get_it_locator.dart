import 'package:get_it/get_it.dart';
import 'package:quansa_homework/data/services/local_storage_service.dart';
import 'package:quansa_homework/data/services/storage_service.dart';

GetIt locator = GetIt.instance;

class Locator {
  static Future<void> setUpLocator() async {
    locator.registerSingletonAsync<StorageService>(
      () => StorageService().initializeService(),
    );
    locator.registerSingletonAsync<LocalStorageService>(
      () => LocalStorageService.getInstance(),
    );
  }
}
