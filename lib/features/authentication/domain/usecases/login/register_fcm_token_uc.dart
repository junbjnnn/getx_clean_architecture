import 'package:jbbase_app/base/domain/base_usecase.dart';

import '../../repositories/user_repo.dart';

class RegisterFcmTokenUseCase extends UseCaseIO<String, void> {
  final UserRepo _userRepo;

  RegisterFcmTokenUseCase(this._userRepo);

  @override
  Future<void> build(String token) {
    return _userRepo.registerFcmToken(token);
  }
}
