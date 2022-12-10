import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/token_model.dart';

part 'refresh_token_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class RefreshTokenAPI {
  factory RefreshTokenAPI(Dio dioBuilder) = _RefreshTokenAPI;

  @POST('/token')
  Future<TokenModel> refreshToken(@Field('refresh_token') String refreshToken);
}
