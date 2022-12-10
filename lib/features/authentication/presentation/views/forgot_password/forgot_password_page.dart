import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/forgot_password/forgot_password_controller.dart';

class ForgotPasswordPage extends BaseGetView<ForgotPasswordController> {
  @override
  Widget myBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: S.current.reset_password,
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            S.current.we_will_send_you_an_email_with_a_link_to_change_your_password,
                          ),
                          const SizedBox(height: 20),
                          CommonTextField(
                            formKey: controller.formKey,
                            controller: controller.emailController,
                            type: FormFieldType.email,
                            textInputAction: TextInputAction.done,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateResetButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapSendResetPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: S.current.send_email,
                      onPressed: controller.onTapSendResetPassword,
                      pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                      isDisable: controller.isDisableButton.value,
                      state: controller.resetState,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
