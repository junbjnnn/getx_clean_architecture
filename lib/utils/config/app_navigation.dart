import 'package:jbbase_app/features/example/example.dart';
import 'package:jbbase_app/utils/extension/route_type.dart';

import 'app_route.dart';

class N {
  static void popUntilRoot() {
    Get.until((route) => route.isFirst);
  }

  static void closeAllDialog() {
    Get.until((route) => Get.isDialogOpen == false);
  }

  static void toHome({
    required ExampleHomeInput input,
    RouteType type = RouteType.pushAndRemoveUntil,
  }) {
    type.navigate(name: AppRoute.tabbar, arguments: input, fadeTransition: true);
  }

  static void toLandingPage({RouteType type = RouteType.pushAndRemoveUntil}) {
    type.navigate(name: AppRoute.LA10, fadeTransition: true);
  }

  // Authentication
  static void toLogin({RouteType type = RouteType.push}) {
    type.navigate(name: AppRoute.LO10);
  }

  static void toForgotPassword({RouteType type = RouteType.push}) {
    type.navigate(name: AppRoute.LO20);
  }

  static void toRegister({RouteType type = RouteType.push}) {
    type.navigate(name: AppRoute.RE10);
  }

  // Example
  static void toChangeLanguage({RouteType type = RouteType.push}) {
    type.navigate(name: AppRoute.SE10);
  }
}
