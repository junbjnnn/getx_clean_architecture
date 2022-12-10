import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../../domain/domain.dart';
import '../login/login_controller.dart';

class ForgotPasswordController extends BaseController {
  TextEditingController emailController = TextEditingController();

  final resetState = BaseState();
  final formKey = GlobalKey<FormBuilderState>();

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;

  final ResetPasswordUseCase _resetPasswordUseCase;

  String get _email => emailController.text;

  ForgotPasswordController(this._resetPasswordUseCase);

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateResetButtonState() {
    isDisableButton.value = _email.isEmpty;
  }

  void onTapSendResetPassword() {
    try {
      final fbs = formKey.formBuilderState!;
      final emailField = FormFieldType.email.field(fbs);
      [emailField].validateFormFields();

      if (resetState.isLoading) return;

      _resetPasswordUseCase.execute(
        observer: Observer(
          onSubscribe: () {
            resetState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (_) {
            resetState.onSuccess();
            showOkDialog(
              title: S.current.email_sent,
              message: S.current.email_sent_desc,
            ).then(
              (_) {
                final loginController = Get.find<LoginController>();
                loginController.resetDataTextField();
                back();
              },
            );
          },
          onError: (AppException e) {
            final fieldErrors = e.errorResponse?.errors;

            // Handle toast message
            if (fieldErrors == null || fieldErrors.isEmpty) {
              return _showToastMessage(e.message);
            }

            // Handle field message
            for (final fieldError in fieldErrors) {
              final fieldName = fieldError.field;
              if (fieldName == null) {
                return _showToastMessage(e.message);
              }

              final formFieldType = FormFieldType.values.byName(fieldName);
              switch (formFieldType) {
                case FormFieldType.email:
                  emailField.invalidate(fieldError.message ?? S.current.that_email_address_is_invalid);
                  break;
                default:
              }

              return _showToastMessage('');
            }
          },
        ),
        input: _email.trim(),
      );
    } on AppException catch (e) {
      isDisableButton.value = true;
      L.error(e);

      return;
    }
  }

  void _showToastMessage(String message) {
    resetState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }
}
