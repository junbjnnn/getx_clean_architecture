import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/example_home/example_home_binding.dart';
import 'package:int_quest/presentation/controllers/example_home_detail/example_home_detail_binding.dart';
import 'package:int_quest/presentation/controllers/example_login/example_login_binding.dart';
import 'package:int_quest/presentation/views/example_home/example_home_page.dart';
import 'package:int_quest/presentation/views/example_home_detail/example_home_detail_page.dart';
import 'package:int_quest/presentation/views/example_login/example_login_page.dart';
import 'package:int_quest/utils/service/auth_service.dart';

 class AppRoute {
  static String routeHomeScreen = '/';
  static String routeDetailScreen = '/detail';

  // Example
  static String routeExampleLoginScreen = '/example_login';
  static String routeExampleHomeScreen = '/example_home';
  static String routeExampleHomeDetailScreen =
      '$routeExampleHomeScreen$routeDetailScreen';

  static List<GetPage> generateGetPages = [
    GetPage(
      name: routeExampleLoginScreen,
      page: () => ExampleLoginPage(),
      binding: ExampleLoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: routeExampleHomeScreen,
      page: () => ExampleHomePage(),
      binding: ExampleHomeBinding(),
      transition: Transition.cupertino,
      children: [
        GetPage(
          name: routeDetailScreen,
          page: () => ExampleHomeDetailPage(),
          binding: ExampleHomeDetailBinding(),
          transition: Transition.cupertino,
        ),
      ],
    ),
  ];
}

class AuthenMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route, {Object? arguments}) {
    final isLogged = Get.find<AuthService>().hasLogin();
    return isLogged
        ? null
        : RouteSettings(
            name: AppRoute.routeExampleLoginScreen,
            arguments: arguments,
          );
  }
}
