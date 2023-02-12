import 'package:jbbase_app/base/domain/base_usecase.dart';

import '../../repositories/auth_repo.dart';
import 'register_fcm_token_uc.dart';

class LoginWithEmailUseCase extends UseCaseIO<EmailPasswordRequest, void> {
  final AuthRepo _authRepo;

  final RegisterFcmTokenUseCase _registerFcmTokenUseCase;

  LoginWithEmailUseCase(
    this._authRepo,
    this._registerFcmTokenUseCase,
  );

  @override
  Future<void> build(EmailPasswordRequest input) async {
    await _authRepo.loginWithEmail(input);
    // await _getMasterDataUseCase.build();

    // final fcmToken = await _pushNotificationService.fcmToken;
    // if (fcmToken != null) {
    //   await _registerFcmTokenUseCase.build(fcmToken);
    // }
  }
}

class LoginWithGoogleUseCase extends UseCase<User> {
  final AuthRepo _authRepo;

  LoginWithGoogleUseCase(this._authRepo);

  @override
  Future<User> build() {
    return _authRepo.loginWithGoogle();
  }
}
