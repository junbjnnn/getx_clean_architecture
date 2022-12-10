import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';

export 'package:dart_json_mapper/dart_json_mapper.dart';

mixin PrettyJsonMixin {
  @override
  String toString() {
    final encoder = JsonEncoder.withIndent(' ' * 2);

    return encoder.convert(JsonMapper.toMap(this));
  }
}
