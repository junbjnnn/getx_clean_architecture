import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../models/token_model.dart';

part 'auth_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class AuthAPI {
  factory AuthAPI(Dio dioBuilder) = _AuthAPI;

  @POST('/register')
  Future<void> registerWithEmail(@Body() EmailPasswordRequest request);

  @POST('/login')
  Future<TokenModel> loginWithEmail(@Body() EmailPasswordRequest request);

  @POST('/reset-password')
  Future<void> resetPassword(@Field() String email);
}

class EmailPasswordRequest {
  final String email;
  final String password;

  EmailPasswordRequest(this.email, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
      };
}
