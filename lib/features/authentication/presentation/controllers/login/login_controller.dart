import 'package:jbbase_app/base/presentation/presentation.dart';
import 'package:jbbase_app/features/example/presentation/presentation.dart';

import '../../../domain/domain.dart';

class LoginController extends BaseController {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  final isHidePassword = true.obs;
  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;

  final LoginWithEmailUseCase _loginWithEmailUseCase;

  String get _email => emailTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  LoginController(this._loginWithEmailUseCase);

  @override
  void onInit() {
    super.onInit();
    emailTextEditingController.text = 'test@gmail.com';
    passwordTextEditingController.text = '12345678';
    emailTextEditingController.disposeBy(disposeBag);
    passwordTextEditingController.disposeBy(disposeBag);
  }

  void onTapResetPassword() {
    N.toForgotPassword();
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _email.isEmpty || _password.isEmpty;
  }

  void onTapLogin() {
    try {
      final fbs = formKey.formBuilderState!;
      final emailField = FormFieldType.email.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      [
        emailField,
        passwordField,
      ].validateFormFields();

      if (loginState.isLoading) return;

      _loginWithEmailUseCase.execute(
        observer: Observer(
          onSubscribe: () {
            loginState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (_) {
            loginState.onSuccess();
            N.toHome(
              input: ExampleHomeInput(_email.trim(), _password.trim()),
            );
          },
          onError: (AppException e) {
            loginState.onError(e.message);
            _showToastMessage(e.message);
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

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }

  void _showToastMessage(String message) {
    loginState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }
}
