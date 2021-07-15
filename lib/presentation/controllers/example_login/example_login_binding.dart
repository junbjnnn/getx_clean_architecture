import 'package:get/get.dart';
import 'package:int_quest/data/repositories_impl/example_auth_repo_impl.dart';
import 'package:int_quest/domain/usecases/auth/login_uc.dart';

import 'example_login_controller.dart';

class ExampleLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginByGoogleUseCase(Get.find<ExampleAuthRepoImpl>()));
    Get.lazyPut(() => LoginByEmailUseCase(Get.find<ExampleAuthRepoImpl>()));
    Get.lazyPut(
      () => ExampleLoginController(
        loginEmailUseCase: Get.find(),
        loginGoogleUseCase: Get.find(),
      ),
    );
  }
}
