import '../../../../authentication/domain/domain.dart';
import 'root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RootController(Get.find(), Get.find()),
    );
  }
}
