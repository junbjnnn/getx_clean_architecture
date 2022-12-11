import 'package:jbbase_app/base/presentation/presentation.dart';
import 'package:jbbase_app/utils/config/app_config.dart';
import 'package:jbbase_app/utils/config/app_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LandingController extends BaseController {
  final appVersion = AppConfig.appVersion;

  LandingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onResumed() {
    super.onResumed();
  }

  void toTermsOfService() async {
    if (!await launchUrlString(AppLinkConstants.termsOfService)) {
      showErrorDialog();
    }
  }

  void toPrivacyPolicy() async {
    if (!await launchUrlString(AppLinkConstants.privacyPolicy)) {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showOkDialog(message: S.current.cannot_open_url);
  }

  void toLogin() {
    N.toLogin();
  }

  void toRegister() {
    N.toRegister();
  }
}
