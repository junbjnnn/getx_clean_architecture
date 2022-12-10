import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/example_list/example_home_list_controller.dart';

class ExampleHomeListPage extends BaseGetView<ExampleHomeListController> {
  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Home list page example',
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: controller.printUser,
              child: const Text('print user box'),
            ),
          ],
        ),
      ),
    );
  }
}
