import 'package:jbbase_app/features/example/presentation/presentation.dart';

import '../../../../authentication/domain/domain.dart';
import 'tabbar_controller.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    ExampleHomeBinding().dependencies();
    ExampleHomeListBinding().dependencies();
    Get.lazyPut(
      () => TabbarController(Get.find(), Get.find()),
    );
  }
}
