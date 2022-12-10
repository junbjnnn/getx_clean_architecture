import 'package:get/get.dart';

import 'example_home_list_controller.dart';

class ExampleHomeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ExampleHomeListController.new);
  }
}
