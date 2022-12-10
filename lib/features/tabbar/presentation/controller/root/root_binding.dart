import '../../../../authentication/domain/domain.dart';
import 'root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetUserDataUseCase(Get.find(), Get.find()));
    Get.lazyPut(() => GetMasterDataUseCase(Get.find(), Get.find()));
    Get.lazyPut(
      () => RootController(Get.find(), Get.find(), Get.find()),
    );
  }
}
