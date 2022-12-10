import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/login/login_controller.dart';

class LoginPage extends BaseGetView<LoginController> {
  @override
  Widget myBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: S.current.login,
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                  child: FormBuilder(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CommonTextField(
                          formKey: controller.formKey,
                          type: FormFieldType.email,
                          controller: controller.emailTextEditingController,
                          onTap: controller.hideErrorMessage,
                          onChanged: (_) {
                            controller.updateLoginButtonState();
                          },
                        ),
                        CommonTextField(
                          formKey: controller.formKey,
                          type: FormFieldType.password,
                          controller: controller.passwordTextEditingController,
                          textInputAction: TextInputAction.done,
                          obscureText: controller.isHidePassword.value,
                          suffixIcon: Text(
                            S.current.forgot_password,
                            style: context.textTheme.labelMedium?.copyWith(color: context.theme.primaryColor),
                          ),
                          onPressedSuffixIcon: controller.onTapResetPassword,
                          onTap: controller.hideErrorMessage,
                          onChanged: (_) {
                            controller.updateLoginButtonState();
                          },
                          onSubmitted: (_) {
                            controller.onTapLogin();
                          },
                        ),
                        const SizedBox(height: 10),
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
                    text: S.current.login,
                    onPressed: controller.onTapLogin,
                    pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                    isDisable: controller.isDisableButton.value,
                    state: controller.loginState,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
