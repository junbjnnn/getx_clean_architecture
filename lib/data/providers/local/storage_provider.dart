import 'package:get_storage/get_storage.dart';

class StorageKey {
  static const String keyUserUid = 'user_uid';
}

class StorageProvider {
  final GetStorage _getStorage = GetStorage();
}

extension StorageProviderUid on StorageProvider {
  String? get uid => _getStorage.read(StorageKey.keyUserUid);

  Future<void> saveUid(String uid) =>
      _getStorage.write(StorageKey.keyUserUid, uid);

  Future<void> removeUid() => _getStorage.remove(StorageKey.keyUserUid);
}
