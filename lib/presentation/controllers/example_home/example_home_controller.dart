import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:int_quest/base/presentation/base_controller.dart';
import 'package:int_quest/presentation/controllers/example_home_detail/example_home_detail_input.dart';
import 'package:int_quest/utils/config/app_route.dart';

class ExampleHomeController extends BaseController {
  final testTextEditingController = TextEditingController();

  void onPushToDetail(ExampleHomeDetailInput input) {
    input.username += testTextEditingController.text;
    input.password += testTextEditingController.text;
    Get.toNamed(
      AppRoute.routeExampleHomeDetailScreen,
      arguments: input,
    );
  }
}
