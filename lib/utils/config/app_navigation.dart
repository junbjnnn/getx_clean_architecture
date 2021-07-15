import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/example_home_detail/example_home_detail_input.dart';
import 'package:int_quest/utils/config/app_route.dart';

enum RouteType { to, off, offAll, offUntil, offAndTo }

class N {
  static void toHome({RouteType? type}) {
    _baseNavigate(
      name: AppRoute.routeExampleHomeScreen,
      type: type,
    );
  }

  static void toHomeDetail({
    required ExampleHomeDetailInput input,
    RouteType? type,
  }) {
    _baseNavigate(
      name: AppRoute.routeExampleHomeDetailScreen,
      type: type,
      arguments: input,
    );
  }

  static void _baseNavigate({
    required String name,
    RouteType? type,
    dynamic arguments,
    dynamic result,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    RoutePredicate? predicate,
  }) {
    switch (type ?? RouteType.to) {
      case RouteType.to:
        Get.toNamed(
          name,
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters,
        );
        break;
      case RouteType.off:
        Get.offNamed(
          name,
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters,
        );
        break;
      case RouteType.offAll:
        Get.offAllNamed(
          name,
          predicate: predicate,
          arguments: arguments,
          id: id,
          parameters: parameters,
        );
        break;
      case RouteType.offUntil:
        if (predicate == null) break;

        Get.offNamedUntil(
          name,
          predicate,
          id: id,
          arguments: arguments,
          parameters: parameters,
        );
        break;
      case RouteType.offAndTo:
        Get.offAndToNamed(
          name,
          arguments: arguments,
          id: id,
          result: result,
          parameters: parameters,
        );
        break;
    }
  }
}
