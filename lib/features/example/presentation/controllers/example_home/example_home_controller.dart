import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jbbase_app/base/base.dart';
import 'package:jbbase_app/features/authentication/authentication.dart';
import 'package:jbbase_app/features/example/domain/usecases/example/user_use_case.dart';
import 'package:jbbase_app/utils/service/auth_service.dart';

import 'example_home_input.dart';

class ExampleHomeController extends BaseController<ExampleHomeInput> {
  late Rx<String> username;
  late Rx<String> password;

  LocalStorage get _localStorage => Get.find<LocalStorage>();
  UserUseCase get _userUseCase => Get.find<UserUseCase>();

  @override
  void onInit() {
    super.onInit();
    username = input.username.obs;
    password = input.password.obs;
    testLog();
  }

  void addX() {
    username.value += 'X';
    password.value += 'X';
  }

  void removeX() {
    username.value = username.value.substring(0, username.value.length - 1);
    password.value = password.value.substring(0, password.value.length - 1);
  }

  void backToLogin() {
    Get.find<AuthService>().logout();
    N.toLandingPage();
  }

  void pushToSetting() {
    N.toChangeLanguage();
  }

  void switchTheme() {
    final newThemeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(newThemeMode);
    _localStorage.saveThemeMode(newThemeMode);
  }

  void printUser() async {
    final box = await Hive.openBox<UserModel>('UserModel');
    for (var key in box.keys) {
      L.debug('key: $key, value: ${box.get(key)}');
      L.debug(UserMapper().mappingEntity(box.get(key)!));
    }
  }

  void addUser() async {
    /*
    final box = await Hive.openBox<UserModel>('user');
    // await box.clear();

    final person = UserModel()
      ..name = 'Dave'
      ..age = 22;
    L.debug(await box.add(person));
    L.debug(box.getAt(0));

    L.debug('Number of persons: ${box.length}');
    L.debug("Dave's first key: ${person.key}");

    person.name = 'Lucas';
    person.save(); // Update object

    // person.delete(); // Remove object from Hive
    L.debug('Number of persons: ${box.length}');

    // box.put('someKey', person);
    L.debug("Lisa's second key: ${person.key}");
    L.debug('Number of persons: ${box.length}');
    */
    _userUseCase.addUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          print('onSubscribe');
        },
        onCompleted: () {
          print('onCompleted');
        },
        onSuccess: (i) {
          print('onSuccess $i');
        },
      ),
      input: User()
        ..name = 'Dave'
        ..age = 22,
    );
  }

  void removeUser() async {
    _userUseCase.clearUseCase.execute();
  }

  void testLog() {
    L.verbose('Verbose log');
    L.debug('Debug log');
    L.info('Info log');
    L.warning('Warning log');
    L.error('Error log');
    L.wtf('What a terrible failure log');
  }
}
