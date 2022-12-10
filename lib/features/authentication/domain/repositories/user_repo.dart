import '../entities/user.dart';

export '../entities/user.dart';

abstract class UserRepo {
  Future<User> getUserData();

  Future<void> deleteAccount();

  Future<void> registerFcmToken(String token);
}
