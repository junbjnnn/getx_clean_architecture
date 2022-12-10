import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';

class AppTextStyle {
  static TextStyle w500s16(Color? color) {
    return _styleWith(FontWeight.w500, 16, color: color);
  }

  static TextStyle _styleWith(
    FontWeight weight,
    double size, {
    Color? color,
    double? height,
    FontStyle style = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size,
      fontFamily: FontFamily.sFProDisplay,
      color: color,
      fontStyle: style,
      height: height,
      decoration: decoration,
    );
  }
}
