import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum RouteType { to, off, offAll, offUntil, offAndTo }

extension RouteTypeExtension on RouteType {
  void navigate({
    required String name,
    dynamic arguments,
    dynamic result,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    RoutePredicate? predicate,
  }) {
    switch (this) {
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
