import 'package:jbbase_app/base/domain/base_usecase.dart';

import '../../repositories/auth_repo.dart';

class RegisterWithEmailUseCase extends UseCaseIO<EmailPasswordRequest, void> {
  final AuthRepo _authRepo;

  RegisterWithEmailUseCase(this._authRepo);

  @override
  Future<void> build(EmailPasswordRequest input) {
    return _authRepo.registerWithEmail(input);
  }
}
