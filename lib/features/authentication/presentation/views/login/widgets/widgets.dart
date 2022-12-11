import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';

part 'widgets.g.dart';

@swidget
Widget successWidget({String? value, double height = 100}) {
  return Container(
    color: Colors.green,
    height: height,
    width: Get.width,
    child: Center(child: Text('$value')),
  );
}

@swidget
Widget loginErrorWidget({String? msg, double height = 100}) {
  return Container(
    color: Colors.red,
    height: height,
    width: Get.width,
    child: Center(child: Text('A error occurred: $msg')),
  );
}
