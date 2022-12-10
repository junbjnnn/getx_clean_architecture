import '../pretty_json_mixin.dart';
import 'error_field.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ErrorResponse with PrettyJsonMixin {
  @JsonProperty(name: 'error/code')
  String? code;

  @JsonProperty(name: 'error/title')
  String? title;

  @JsonProperty(name: ['error/message', 'message'])
  String? message;

  @JsonProperty(name: 'error/errors')
  List<ErrorField>? errors;
}
