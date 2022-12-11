import 'package:flutter/cupertino.dart';
import 'package:jbbase_app/base/presentation/presentation.dart';
import 'package:jbbase_app/features/authentication/authentication.dart';

import '../../controllers/example_list/example_home_list_controller.dart';

class ExampleHomeListPage extends BaseGetView<ExampleHomeListController> {
  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Home list page example',
        leading: null,
      ),
      body: CommonPagedListView<User>(
        pagingController: controller.pagingController,
        itemBuilder: (context, user, index) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Text(user.email),
            ),
          );
        },
      ),
    );
  }
}
