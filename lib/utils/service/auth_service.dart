import 'package:get/get.dart';
import 'package:int_quest/data/providers/local/storage_provider.dart';

class AuthService extends GetxService {
  StorageProvider _storageProvider = Get.find();
  // TokenModel? tokenModel;

  @override
  void onInit() {
    super.onInit();
    // tokenModel = _storageProvider.getToken();

    // _storageProvider.addTokenListener((TokenModel? token) {
    //   if (token == null) {
    //     Get.offAllNamed(AppRoute.routeLoginScreen());
    //   }
    //   tokenModel = token;
    // });
  }

  // bool hasLogin() => tokenModel != null;
  bool hasLogin() => true;
}
