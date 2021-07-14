import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:int_quest/base/domain/base_observer.dart';
import 'package:int_quest/base/domain/base_state.dart';
import 'package:int_quest/base/presentation/base_controller.dart';
import 'package:int_quest/domain/usecases/auth/login_uc.dart';
import 'package:int_quest/utils/config/app_route.dart';

class ExampleLoginController extends BaseController {
  final LoginByGoogleUseCase _loginGoogleUseCase = Get.find();
  final LoginByEmailUseCase _loginEmailUseCase = Get.find();

  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final loginState = BaseState();

  void onPushToHome() {
    Get.offAllNamed(AppRoute.routeExampleHomeScreen);
  }

  void onSuccessTest() {
    _loginGoogleUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          loginState.onLoading();
        },
        onSuccess: (_) {
          loginState.onSuccess(data: "login success data");
        },
        onError: (dynamic e) {
          loginState.onError(e.toString());
        },
      ),
    );
  }

  void onErrorTest() {
    _loginEmailUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          loginState.onLoading();
        },
        onSuccess: (_) {
          loginState.onSuccess();
        },
        onError: (dynamic e) {
          loginState.onError(e.toString());
        },
      ),
      input: LoginEmailInput(
        "usernameTextEditingController.text",
        "passwordTextEditingController.text",
      ),
    );
  }

  void onCrashTest() {
    print([][1]);
  }

  @override
  void dispose() {
    usernameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
