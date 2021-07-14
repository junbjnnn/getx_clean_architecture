import 'package:int_quest/base/domain/base_usecase.dart';
import 'package:int_quest/domain/repositories/auth_repo.dart';

class LogoutUseCase extends UseCase<bool, void> {
  LogoutUseCase(this.authRepo);

  final AuthRepo authRepo;

  @override
  Future<bool> buildUseCase(_) {
    return authRepo.logOut();
  }
}
