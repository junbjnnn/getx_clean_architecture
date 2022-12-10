import 'package:jbbase_app/base/data/model/pretty_json_mixin.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true, name: 'data')
class TokenModel with PrettyJsonMixin {
  @JsonProperty(name: ['access_token', 'token'])
  String? accessToken;

  String? refreshToken;

  @JsonProperty(name: ['expire_in', 'expires_in'])
  int? expireIn;
}
