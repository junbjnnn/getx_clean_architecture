import 'package:jbbase_app/base/domain/base_repo.dart';

import '../../domain/repositories/user_repo.dart';
import '../providers/remote/api/user_api.dart';
import 'mapper/user_mapper.dart';

class UserRepoImpl extends BaseRepo implements UserRepo {
  final UserAPI _userAPI = Get.find();

  @override
  Future<User> getUserData() async {
    final model = await _userAPI.getUserData();

    return mappingEntity<User, UserModel>(model);
  }

  @override
  Future<void> deleteAccount() {
    return _userAPI.deleteAccount();
  }

  @override
  Future<void> registerFcmToken(String token) {
    return _userAPI.registerFcmToken(token);
  }
}
