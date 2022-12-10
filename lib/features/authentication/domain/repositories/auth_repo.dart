import '../../data/data.dart';

export '../../data/data.dart';

abstract class AuthRepo {
  Future<void> registerWithEmail(EmailPasswordRequest request);

  Future<void> loginWithEmail(EmailPasswordRequest request);

  Future<void> resetPassword(String email);

  Future<User> loginWithGoogle();

  Future<void> logout();

  Future<void> refreshToken();

  Future<void> verifyEmail();

  Future<bool> isAuthenticated();
}
