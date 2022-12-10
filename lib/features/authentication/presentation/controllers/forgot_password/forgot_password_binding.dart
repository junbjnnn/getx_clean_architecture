import '../../../domain/domain.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordUseCase(Get.find()));
    Get.lazyPut(() => ForgotPasswordController(Get.find()));
  }
}
