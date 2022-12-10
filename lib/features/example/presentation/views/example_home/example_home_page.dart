import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/example_home/example_home_controller.dart';

class ExampleHomePage extends BaseGetView<ExampleHomeController> {
  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Home page example',
        leading: null,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.username.value,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(controller.password.value),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.addX,
              child: const Text('add X'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.removeX,
              child: const Text('remove X'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.backToLogin,
              child: const Text('back to landing'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.pushToSetting,
              child: const Text('push to setting'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.switchTheme,
              child: const Text('switch theme'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.printUser,
              child: const Text('print user box'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.addUser,
              child: const Text('add user'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.removeUser,
              child: const Text('remove user'),
            ),
          ],
        ),
      ),
    );
  }
}
