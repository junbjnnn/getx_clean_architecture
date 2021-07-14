import 'package:int_quest/base/domain/base_usecase.dart';
import 'package:int_quest/domain/models/user.dart';
import 'package:int_quest/domain/repositories/auth_repo.dart';

class LoginEmailInput {
  LoginEmailInput(this.username, this.password);

  final String username;
  final String password;
}

class LoginByEmailUseCase extends UseCase<User, LoginEmailInput> {
  LoginByEmailUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<User> buildUseCase(LoginEmailInput? input) {
    return authRepo.loginByEmail(input!);
  }
}

class LoginByGoogleUseCase extends UseCase<User, void> {
  LoginByGoogleUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<User> buildUseCase(_) {
    return authRepo.loginByGoogle();
  }
}
