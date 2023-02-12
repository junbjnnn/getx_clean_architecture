import 'package:dio/dio.dart';

import '../../base/base.dart';
import '../../features/authentication/authentication.dart';
import '../../features/example/example.dart';
import '../service/auth_service.dart';
import '../service/connectivity_service.dart';
import '../service/permission_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectStorageProvider();
    injectNetworkProvider();
    injectService();
    injectRepository();
    injectUseCase();
  }

  void injectStorageProvider() {
    Get.put(LocalStorage(), permanent: true);
    Get.put(UserStorage());
  }

  void injectNetworkProvider() {
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: true,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      tag: DioBulderType.refresh.name,
      fenix: true,
    );
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: false,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
        dioRefresh: Get.find<DioBuilder>(tag: DioBulderType.refresh.name),
      ),
      tag: DioBulderType.withToken.name,
      fenix: true,
    );
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: true,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      tag: DioBulderType.ignoredToken.name,
      fenix: true,
    );
    Get.lazyPut(
      () => RefreshTokenAPI(Get.find<DioBuilder>(tag: DioBulderType.refresh.name)),
      fenix: true,
    );
    Get.lazyPut(
      () => AuthAPI(Get.find<DioBuilder>(tag: DioBulderType.ignoredToken.name)),
      fenix: true,
    );
    Get.lazyPut(
      () => UserAPI(Get.find<DioBuilder>(tag: DioBulderType.withToken.name)),
      fenix: true,
    );
  }

  void injectService() {
    Get.put(LogServiceImpl());
    Get.put<ConnectivityService>(ConnectivityServiceImpl());
    Get.put<PermissionService>(PermissionServiceImpl());
    Get.put<AuthService>(AuthServiceImpl());
    // Get.put(PushNotificationService());
  }

  void injectRepository() {
    Get.put<AuthRepo>(AuthRepoImpl());
    Get.put<UserRepo>(UserRepoImpl());
  }

  void injectUseCase() {
    Get.put(UserUseCase());
  }
}
