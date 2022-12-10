import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:jiffy/jiffy.dart';

class CustomDateTimeConverter implements ICustomConverter<DateTime> {
  const CustomDateTimeConverter() : super();

  @override
  DateTime fromJSON(dynamic jsonValue, DeserializationContext context) {
    return Jiffy(jsonValue, "yyyy-MM-dd'T'HH:mm:ss").dateTime;
  }

  @override
  dynamic toJSON(DateTime object, SerializationContext context) {
    return object.toIso8601String();
  }
}
