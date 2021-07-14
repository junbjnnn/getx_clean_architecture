import 'package:int_quest/base/presentation/base_controller.dart';
import 'package:int_quest/utils/service/log_service.dart';

import 'example_home_detail_input.dart';

class ExampleHomeDetailController
    extends BaseController<ExampleHomeDetailInput> {
  late String username;
  late String password;

  @override
  void onInit() {
    super.onInit();
    username = input.username;
    password = input.password;
    testLog();
  }

  void testLog() {
    L.v("Verbose log");
    L.d("Debug log");
    L.i("Info log");
    L.w("Warning log");
    L.e("Error log");
    L.wtf("What a terrible failure log");
  }
}
