import 'package:flutter/services.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
