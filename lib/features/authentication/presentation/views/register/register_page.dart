import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/register/register_controller.dart';

class RegisterPage extends BaseGetView<RegisterController> {
  @override
  Widget myBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: S.current.register,
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
                          onTap: () {
                            controller.hideErrorMessage();
                          },
                          onChanged: (_) {
                            controller.updateRegisterButtonState();
                          },
                        ),
                        Obx(
                          () => CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller: controller.passwordTextEditingController,
                            obscureText: controller.isHidePassword.value,
                            suffixIcon: Icon(
                              controller.isHidePassword.value ? Icons.visibility_off : Icons.visibility,
                              color: context.theme.colorScheme.onPrimaryContainer,
                            ),
                            onPressedSuffixIcon: controller.onTapHidePassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
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
                    text: S.current.register,
                    onPressed: controller.onTapRegister,
                    pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                    isDisable: controller.isDisableButton.value,
                    state: controller.registerState,
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
