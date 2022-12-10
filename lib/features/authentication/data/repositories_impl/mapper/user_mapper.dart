import 'package:jbbase_app/base/data/base_mapper.dart';

import '../../../domain/entities/user.dart';
import '../../models/user_model.dart';

export '../../../domain/entities/user.dart';
export '../../models/user_model.dart';

// Only for example, implement when you need to custom mapper
class UserMapper extends BaseMapper<User, UserModel> {
  @override
  User buildEntityMapper(UserModel model, User entityMapped) {
    return entityMapped;
  }

  @override
  UserModel buildModelMapper(User entity, UserModel modelMapped) {
    return modelMapped;
  }
}
