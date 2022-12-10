import '../pretty_json_mixin.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ErrorField with PrettyJsonMixin {
  String? code;

  String? field;

  String? message;
}
