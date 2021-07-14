import 'package:get/get.dart';
import 'package:int_quest/data/providers/firestore/user_provider.dart';
import 'package:int_quest/data/providers/local/storage_provider.dart';
import 'package:int_quest/data/repositories_impl/auth_repo_impl.dart';
import 'package:int_quest/utils/service/auth_service.dart';
import 'package:int_quest/utils/service/connectivity_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectStorageProvider();
    injectFirestoreProvider();
    injectRepository();
    injectService();
  }

  void injectStorageProvider() {
    Get.put(StorageProvider());
  }

  void injectFirestoreProvider() {
    Get.lazyPut(() => UserProvider(), fenix: true);
  }

  void injectRepository() {
    Get.put(AuthRepoImpl());
  }

  void injectService() {
    Get.put(AuthService());
    Get.put(ConnectivityService());
  }
}
