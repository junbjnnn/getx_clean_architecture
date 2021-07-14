import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/login_controller.dart';
import 'package:int_quest/presentation/views/login/login_page.dart';
import 'package:int_quest/utils/service/auth_service.dart';

class AppRoute {
  static String routeHomeScreen() => '/';
  static String routeLoginScreen() => '/login';
  static String routeRegisterScreen() => '/register';

  static List<GetPage> generateGetPages() => [
        GetPage(
          name: routeLoginScreen(),
          page: () => LoginPage(),
          binding: LoginBinding(),
          transition: Transition.cupertino,
        ),
      ];
}

class AuthenMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route, {Object? arguments}) {
    var isLogged = Get.find<AuthService>().hasLogin();
    return isLogged
        ? null
        : RouteSettings(
            name: AppRoute.routeLoginScreen(), arguments: arguments);
  }
}
