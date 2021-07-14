import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BaseController<T> extends SuperController {
  late final T input;

  @override
  void onInit() {
    super.onInit();
    input = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
