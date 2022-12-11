import 'package:get/get.dart';

import '../../../domain/usecases/example/get_users_data_uc.dart';
import 'example_home_list_controller.dart';

class ExampleHomeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GetUsersDataUseCase.new);
    Get.lazyPut(() => ExampleHomeListController(Get.find()));
  }
}
