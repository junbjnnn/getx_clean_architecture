import 'package:jbbase_app/base/domain/base_repo.dart';

import '../../domain/repositories/user_repo.dart';
import '../providers/remote/api/user_api.dart';

class UserRepoImpl extends UserRepo {
  final UserAPI _userAPI = Get.find();

  @override
  Future<int> add(User h) async {
    final id = await super.add(h);

    // TODO: Override something

    return id;
  }

  @override
  Future<User> getUserData() async {
    final model = await _userAPI.getUserData();

    return mappingEntity(model);
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
