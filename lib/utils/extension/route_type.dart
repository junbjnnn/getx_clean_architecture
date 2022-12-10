import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:jbbase_app/utils/config/app_route.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

enum RouteType { push, pushReplacement, pushAndRemoveUntil, popUntil }

extension RouteTypeExtension on RouteType {
  void navigate({
    required String name,
    dynamic arguments,
    bool canSwipe = true,
    bool animation = true,
    bool fadeTransition = false,
  }) {
    Get.log('${this.name} $name');
    final getPage = AppRoute.getPage(name);
    final context = Get.context;
    if (getPage == null || context == null) return;

    getPage.binding?.dependencies();
    final route = SwipeablePageRoute(
      builder: (_) => getPage.page(),
      settings: RouteSettings(name: name, arguments: arguments),
      fullscreenDialog: fadeTransition,
      transitionDuration: animation ? null : Duration.zero,
      transitionBuilder: fadeTransition
          ? (context, animation, secondaryAnimation, isSwipeGesture, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
          : null,
    );
    switch (this) {
      case RouteType.push:
        Navigator.push(context, route).then((_) {
          RouterReportManager.reportRouteDispose(route);
        });
        break;
      case RouteType.pushReplacement:
        Navigator.pushReplacement(context, route).then((_) {
          RouterReportManager.reportRouteDispose(route);
        });
        break;
      case RouteType.pushAndRemoveUntil:
        Navigator.pushAndRemoveUntil(context, route, (route) => route.settings.name == name).then((_) {
          RouterReportManager.reportRouteDispose(route);
        });
        break;
      case RouteType.popUntil:
        Navigator.popUntil(context, (route) => route.settings.name == name);
        break;
    }
  }
}
