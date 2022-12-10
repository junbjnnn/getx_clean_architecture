import 'package:jbbase_app/base/domain/base_usecase.dart';

import '../../repositories/user_repo.dart';

class DeleteAccountUseCase extends UseCase<void> {
  final UserRepo _userRepo;

  DeleteAccountUseCase(this._userRepo);

  @override
  Future<void> build() {
    return _userRepo.deleteAccount();
  }
}
