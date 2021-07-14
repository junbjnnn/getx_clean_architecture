import 'package:get/get.dart';

import 'example_home_detail_controller.dart';

class ExampleHomeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExampleHomeDetailController());
  }
}
