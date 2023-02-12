import 'package:jbbase_app/features/example/example.dart';

class ExampleHomeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserUseCase.new);
    Get.lazyPut(() => ExampleHomeListController(Get.find()));
  }
}
