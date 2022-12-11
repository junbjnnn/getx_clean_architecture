import 'package:jbbase_app/base/domain/base_usecase.dart';
import 'package:jbbase_app/features/authentication/authentication.dart';

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
