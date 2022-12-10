import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/user_model.dart';

part 'user_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class UserAPI {
  factory UserAPI(Dio dioBuilder) = _UserAPI;

  @GET('/me')
  Future<UserModel> getUserData();

  @DELETE('/me')
  Future<void> deleteAccount();

  @POST('/me/devices')
  Future<void> registerFcmToken(@Field('fcm_token') String token);

  @POST('/logout')
  Future<void> logout();
}
