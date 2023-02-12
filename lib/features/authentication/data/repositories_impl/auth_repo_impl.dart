import 'package:jbbase_app/base/data/app_error.dart';
import 'package:jbbase_app/base/domain/base_repo.dart';
import 'package:jbbase_app/features/authentication/data/providers/local/user_storage_ex.dart';
import 'package:jbbase_app/utils/service/log_service.dart';

import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final LocalStorage _localStorage = Get.find();
  final AuthAPI _authAPI = Get.find();
  final UserAPI _userAPI = Get.find();
  final RefreshTokenAPI _refreshTokenAPI = Get.find();

  @override
  Future<void> registerWithEmail(EmailPasswordRequest request) {
    return _authAPI.registerWithEmail(request);
  }

  @override
  Future<void> loginWithEmail(EmailPasswordRequest request) async {
    // final tokenModel = await _authAPI.loginWithEmail(request);
    await Future.delayed(const Duration(seconds: 1));
    final tokenModel = TokenModel()..accessToken = 'xxx';
    if (tokenModel.accessToken == null) {
      throw AppException(AppExceptionType.unauthorized, 'Invalid access token!');
    }
    _localStorage.saveUserTokenData(tokenModel);
  }

  @override
  Future<void> resetPassword(String email) {
    return _authAPI.resetPassword(email);
  }

  @override
  Future<void> refreshToken() async {
    final userRefreshToken = await _localStorage.userRefreshToken;
    if (userRefreshToken != null) {
      final data = await _refreshTokenAPI.refreshToken(userRefreshToken);
      _localStorage.saveUserTokenData(data);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _userAPI.logout();

      return;
    } catch (e) {
      L.info(e);
    }
  }

  @override
  Future<bool> isAuthenticated() {
    throw UnimplementedError();
  }

  @override
  Future<User> loginWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail() {
    throw UnimplementedError();
  }
}
