import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jbbase_app/features/authentication/data/providers/local/user_storage_ex.dart';

class LocalStorage {
  final _getStorage = GetStorage();

  final _secureStorage = const FlutterSecureStorage();

  GetStorage get getStorage => _getStorage;

  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<void> removeAllData() async {
    final localStorage = Get.find<LocalStorage>();
    final locale = localStorage.locale;
    final themeMode = localStorage.themeMode;
    await Future.wait([
      _getStorage.erase(),
      _secureStorage.deleteAll(),
    ]);
    if (locale != null) {
      await Future.wait([
        localStorage.saveLocale(locale),
        localStorage.saveThemeMode(themeMode),
      ]);
    }
  }
}
