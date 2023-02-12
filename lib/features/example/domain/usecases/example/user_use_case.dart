import 'package:get/get.dart';
import 'package:jbbase_app/base/domain/base_usecase.dart';
import 'package:jbbase_app/features/authentication/domain/repositories/user_repo.dart';

// Sample version
// class UserDeleteUseCase extends DeleteUseCase<User, UserRepo> {}

// Override version
class UserDeleteUseCase extends DeleteUseCase<User, UserRepo> {
  UserDeleteUseCase(UserRepo repo) : super(repo);

  @override
  Future<void> build(User h) {
    final builds = [super.build(h)];

    // Override something
    // if (xxx) {
    //   builds.add(super.build(x));
    // }
    // if (yyy) {
    //   builds.add(otherUseCase.build(y));
    // }
    return Future.wait(builds);
  }
}

class UserUseCase extends BaseHiveUseCase<User, UserRepo> {
  @override
  UserDeleteUseCase get deleteUseCase => Get.put(
        UserDeleteUseCase(Get.find()),
      );

  GetUsersDataUseCase get getUsersDataUseCase => Get.put(
        GetUsersDataUseCase(),
      );
}

class GetUsersDataUseCase extends UseCaseIO<int, List<User>> {
  @override
  Future<List<User>> build(int startIndex) async {
    await Future.delayed(const Duration(seconds: 3));
    final users = <User>[];
    for (int i = startIndex; i < startIndex + 11; i++) {
      users.add(
        User()
          ..name = 'Test $i'
          ..email = 'TestEmail $i',
      );
    }
    return users;
  }
}
