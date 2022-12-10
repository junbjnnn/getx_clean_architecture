import 'package:jbbase_app/features/example/presentation/presentation.dart';

import '../../../../authentication/domain/domain.dart';
import 'tabbar_controller.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetUserDataUseCase(Get.find(), Get.find()));
    Get.lazyPut(() => GetMasterDataUseCase(Get.find(), Get.find()));
    ExampleHomeBinding().dependencies();
    ExampleHomeListBinding().dependencies();
    Get.lazyPut(
      () => TabbarController(Get.find(), Get.find()),
    );
  }
}
