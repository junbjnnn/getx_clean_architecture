import 'package:jbbase_app/base/domain/base_usecase.dart';

import '../../repositories/auth_repo.dart';

class ResetPasswordUseCase extends UseCaseIO<String, void> {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  @override
  Future<void> build(String email) {
    return _authRepo.resetPassword(email);
  }
}
