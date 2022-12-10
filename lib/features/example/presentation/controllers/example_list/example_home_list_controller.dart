import 'package:hive/hive.dart';
import 'package:jbbase_app/base/base.dart';
import 'package:jbbase_app/features/authentication/authentication.dart';

class ExampleHomeListController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  void printUser() async {
    final box = await Hive.openBox<UserModel>('user');
    for (var key in box.keys) {
      L.debug('key: $key, value: ${box.get(key)}');
      L.debug(UserMapper().mappingEntity(box.get(key)!));
    }
  }
}
