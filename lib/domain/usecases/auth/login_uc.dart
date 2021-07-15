import 'package:int_quest/base/domain/base_usecase.dart';
import 'package:int_quest/domain/entities/user.dart';
import 'package:int_quest/domain/repositories/auth_repo.dart';

class LoginEmailInput {
  LoginEmailInput(this.username, this.password);

  final String username;
  final String password;
}

class LoginByEmailUseCase extends UseCaseIO<LoginEmailInput, User> {
  LoginByEmailUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<User> build(LoginEmailInput input) {
    return authRepo.loginByEmail(input);
  }
}

class LoginByGoogleUseCase extends UseCaseO<User> {
  LoginByGoogleUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<User> build() {
    return authRepo.loginByGoogle();
  }
}
