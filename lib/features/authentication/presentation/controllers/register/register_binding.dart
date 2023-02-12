import '../../../domain/domain.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterWithEmailUseCase(Get.find()));
    Get.lazyPut(() => RegisterFcmTokenUseCase(Get.find()));

    Get.lazyPut(
      () => LoginWithEmailUseCase(Get.find(), Get.find()),
    );
    Get.lazyPut(
      () => RegisterController(Get.find()),
    );
  }
}
