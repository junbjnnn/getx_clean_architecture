import '../../../../authentication/domain/domain.dart';
import 'landing_controller.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LandingController.new);
  }
}
