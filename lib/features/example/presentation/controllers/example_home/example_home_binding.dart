import 'package:get/get.dart';
import 'example_home_controller.dart';

class ExampleHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ExampleHomeController.new);
  }
}
