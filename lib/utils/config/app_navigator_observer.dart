import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:jbbase_app/utils/service/log_service.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class AppNavigatorObserver extends GetObserver {
  static const _enableLog = true;

  AppNavigatorObserver();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (_enableLog) {
      L.info('didPush from ${previousRoute?.settings.name} to ${route.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (_enableLog) {
      L.info('didPop ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (_enableLog) {
      L.info('didRemove ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
    if (route is SwipeablePageRoute) {
      RouterReportManager.reportRouteDispose(route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_enableLog) {
      L.info('didReplace ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
    }
    if (oldRoute is GetPageRoute) {
      RouterReportManager.reportRouteDispose(oldRoute);
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    L.info('didStartUserGesture ${route.settings.name} previous ${previousRoute?.settings.name}');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    L.info('didStopUserGesture');
  }
}
