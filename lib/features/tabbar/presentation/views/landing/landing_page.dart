import 'package:flutter/cupertino.dart';
import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controller/landing/landing_controller.dart';

class LandingPage extends BaseGetView<LandingController> {
  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Assets.images.splashIcon.image().image,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                CupertinoButton(
                  onPressed: controller.toTermsOfService,
                  child: Text(
                    S.current.terms,
                  ),
                ),
                CupertinoButton(
                  onPressed: controller.toPrivacyPolicy,
                  child: Text(
                    S.current.policy,
                  ),
                ),
                const SizedBox(
                  height: 53,
                ),
                CommonButton(
                  onPressed: controller.toRegister,
                  fillColor: context.theme.primaryColor,
                  borderColor: context.theme.primaryColor,
                  child: Text(
                    S.current.register,
                    style: TextStyle(color: context.theme.colorScheme.onPrimary),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CommonButton(
                  onPressed: controller.toLogin,
                  fillColor: Colors.transparent,
                  borderColor: context.theme.primaryColor,
                  child: Text(
                    S.current.login,
                    style: TextStyle(color: context.theme.colorScheme.primary),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  controller.appVersion,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
