import 'package:flutter/services.dart';

extension StringExtension on String {
  void copyText() {
    Clipboard.setData(ClipboardData(text: this));
  }

  String commaFormat() {
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

    return replaceAllMapped(reg, (Match match) => '${match[1]},');
  }
}
