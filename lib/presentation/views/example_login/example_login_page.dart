import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/example_login/example_login_controller.dart';

class ExampleLoginPage extends GetView<ExampleLoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'username',
                ),
                controller: controller.usernameTextEditingController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.passwordTextEditingController,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(
                height: 55,
              ),
              ElevatedButton(
                onPressed: () => controller.onPushToHome(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: const Center(
                    child: Text('Push home test'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => controller.onSuccessTest(),
                child: const Text('Login success test'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => controller.onErrorTest(),
                child: const Text('Login error test'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => controller.onCrashTest(),
                child: const Text('Crash test'),
              ),
            ],
          ),
          // Shouldn't
          controller.loginState.widget(
            onLoading: const Center(
              child: CupertinoActivityIndicator(),
            ),
            onSuccess: (value) => Container(
              color: Colors.green,
              height: 100,
              width: Get.width,
              child: Center(child: Text('$value')),
            ),
            onError: (errorMessage) {
              return Container(
                color: Colors.red,
                height: 100,
                width: Get.width,
                child: Center(child: Text('A error occurred: $errorMessage')),
              );
            },
          ),
          // Should
          controller.loginState.widget(
            onLoading: loadingWidget(),
            onSuccess: (_) => successWidget(value: _),
            onError: (_) => errorWidget(msg: _),
          ),
        ],
      ),
    );
  }

  @swidget
  AppBar appBarWidget() {
    return AppBar(
      title: const Text("Example page"),
    );
  }
}

extension LoginPageStateWidget on ExampleLoginPage {
  @swidget
  Widget loadingWidget() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  @swidget
  Widget successWidget({String? value, double height = 30}) {
    return Container(
      color: Colors.white54,
      height: height,
      width: Get.width,
      child: Center(child: Text('successWidget: $value')),
    );
  }

  @swidget
  Widget errorWidget({String? msg, double height = 30}) {
    return Container(
      color: Colors.black54,
      height: height,
      width: Get.width,
      child: Center(child: Text('errorWidget: $msg')),
    );
  }
}
