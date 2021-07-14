import 'package:int_quest/domain/models/user.dart';
import 'package:int_quest/domain/usecases/auth/login_uc.dart';
import 'package:int_quest/domain/usecases/auth/register_uc.dart';

abstract class AuthRepo {
  Future<User> loginByGoogle();
  Future<User> loginByEmail(LoginEmailInput input);

  Future<User> registerByEmail(RegisterEmailInput input);
  Future<bool> sendEmailVerification();

  Future<bool> logOut();
}
