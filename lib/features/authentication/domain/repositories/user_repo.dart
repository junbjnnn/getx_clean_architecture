import 'package:jbbase_app/base/domain/base_repo.dart';

import '../../data/models/user_model.dart';
import '../../data/providers/local/user_storage.dart';
import '../entities/user.dart';

export '../../data/models/user_model.dart';
export '../entities/user.dart';

abstract class UserRepo extends BaseHiveRepo<User, UserModel, UserStorage> {
  Future<User> getUserData();

  Future<void> deleteAccount();

  Future<void> registerFcmToken(String token);
}
