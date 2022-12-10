import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jbbase_app/base/presentation/base_controller.dart';
import 'package:jbbase_app/utils/extension/form_builder.dart';

import '../../../domain/domain.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormBuilderState>();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final registerState = BaseState();
  final isHidePassword = true.obs;
  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;

  final RegisterWithEmailUseCase _registerWithEmailUseCase;

  String get _email => emailTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  RegisterController(
    this._registerWithEmailUseCase,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.onClose();
  }

  void onTapHidePassword() {
    final text = passwordTextEditingController.text;
    isHidePassword.value = !isHidePassword.value;
    passwordTextEditingController.value = passwordTextEditingController.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateRegisterButtonState() {
    isDisableButton.value = _email.isEmpty || _password.isEmpty;
  }

  void onTapRegister() {
    try {
      final fbs = formKey.formBuilderState!;
      final emailField = FormFieldType.email.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);

      [
        emailField,
        passwordField,
      ].validateFormFields();

      if (registerState.isLoading) return;

      _registerWithEmailUseCase.execute(
        observer: Observer(
          onSubscribe: () {
            registerState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (_) {
            // TODO:
          },
          onError: (e) {
            // TODO:
          },
        ),
        input: EmailPasswordRequest(
          _email.trim(),
          _password.trim(),
        ),
      );
    } on AppException catch (e) {
      isDisableButton.value = true;
      L.error(e);
    }
  }
}
