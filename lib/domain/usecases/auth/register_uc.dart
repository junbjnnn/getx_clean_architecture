import 'package:int_quest/base/domain/base_usecase.dart';
import 'package:int_quest/domain/models/user.dart';
import 'package:int_quest/domain/repositories/auth_repo.dart';

class RegisterEmailInput {
  RegisterEmailInput(this.username, this.password);
  final String username;
  final String password;

  RegisterEmailInput toRequest() {
    return RegisterEmailInput(username, password);
  }
}

class RegisterByEmailUseCase extends UseCase<User, RegisterEmailInput> {
  RegisterByEmailUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<User> buildUseCase(RegisterEmailInput? input) {
    return authRepo.registerByEmail(input!.toRequest());
  }
}

class SendEmailVerificationUseCase extends UseCase<bool, void> {
  SendEmailVerificationUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<bool> buildUseCase(_) {
    return authRepo.sendEmailVerification();
  }
}
