import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    print("build LoginPage");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "title()",
        ),
      ),
      body: Stack(
        children: [
          controller.loginState.widget(),
          controller.loginState.widget(
            onSuccess: (value) => Container(
              color: Colors.green,
              height: 100,
              width: Get.width,
              child: Center(child: Text('$value')),
            ),
            onLoading: const Center(
              child: CupertinoActivityIndicator(),
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
          controller.loginState.widget(
            onSuccess: (value) => Container(
              color: Colors.white54,
              height: 30,
              width: Get.width,
              child: Center(child: Text('$value')),
            ),
            onLoading: const Center(
              child: CupertinoActivityIndicator(),
            ),
            onError: (errorMessage) {
              return Container(
                color: Colors.black54,
                height: 30,
                width: Get.width,
                child: Center(child: Text('A error occurred: $errorMessage')),
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'username',
                ),
                controller: controller.usernameTextEditingController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.passwordTextEditingController,
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(
                height: 55,
              ),
              ElevatedButton(
                onPressed: () => controller.onSuccessTest(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: Center(
                    child: Text('Login success test'),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => controller.onErrorTest(),
                child: Text('Login error test'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
