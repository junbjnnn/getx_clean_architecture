import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:int_quest/base/domain/base_observer.dart';
import 'package:int_quest/base/domain/base_state.dart';
import 'package:int_quest/base/presentation/base_controller.dart';
import 'package:int_quest/data/repositories_impl/auth_repo_impl.dart';
import 'package:int_quest/domain/usecases/auth/login_uc.dart';
import 'package:int_quest/utils/config/app_route.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginByGoogleUseCase(Get.find<AuthRepoImpl>()));
    Get.lazyPut(() => LoginByEmailUseCase(Get.find<AuthRepoImpl>()));
    Get.lazyPut(
      () => LoginController(Get.find(), Get.find()),
    );
  }
}

class LoginController extends BaseController {
  LoginController(
    this._loginGoogleUseCase,
    this._loginEmailUseCase,
  );

  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final LoginByGoogleUseCase _loginGoogleUseCase;
  final LoginByEmailUseCase _loginEmailUseCase;
  final loginState = BaseState();

  void onErrorTest() {
    _loginEmailUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          loginState.onLoading();
        },
        onSuccess: (_) {
          loginState.onSuccess();
          Get.offAllNamed(AppRoute.routeHomeScreen);
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

  void onSuccessTest() {
    _loginGoogleUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          loginState.onLoading();
        },
        onSuccess: (_) {
          loginState.onSuccess(data: "login success data");
          // Get.offAllNamed(AppRoute.routeHomeScreen());
        },
        onError: (dynamic e) {
          loginState.onError(e.toString());
        },
      ),
    );
  }

  @override
  void dispose() {
    usernameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
