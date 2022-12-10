import 'package:jbbase_app/base/domain/base_usecase.dart';
import 'package:jbbase_app/utils/service/auth_service.dart';

import '../user/get_user_data_uc.dart';

class GetMasterDataUseCase extends UseCase<void> {
  final GetUserDataUseCase _getUserDataUseCase;

  final AuthService _authService;

  GetMasterDataUseCase(
    this._getUserDataUseCase,
    this._authService,
  );

  @override
  Future<void> build() async {
    await Future.wait([
      _getUserDataUseCase.build(),
    ]);
  }
}
