import 'package:jbbase_app/base/domain/base_usecase.dart';
import 'package:jbbase_app/utils/service/auth_service.dart';

import '../../repositories/user_repo.dart';

class GetUserDataUseCase extends UseCase<User> {
  final UserRepo _userRepo;

  final AuthService _authService;

  GetUserDataUseCase(this._userRepo, this._authService);

  @override
  Future<User> build() {
    return _userRepo.getUserData();
  }
}
