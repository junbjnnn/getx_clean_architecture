import '../../../domain/domain.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterFcmTokenUseCase(Get.find()));

    Get.lazyPut(
      () => LoginWithEmailUseCase(Get.find(), Get.find()),
    );
    Get.lazyPut(
      () => LoginController(Get.find()),
    );
  }
}
