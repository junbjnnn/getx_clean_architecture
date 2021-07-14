import 'package:get/get.dart';
import 'package:int_quest/base/presentation/base_controller.dart';
import 'package:int_quest/domain/usecases/auth/logout_uc.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}

class HomeController extends BaseController {
  HomeController(this._logoutUseCase);

  final LogoutUseCase _logoutUseCase;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // _testSetCurrentScreen();
  }

  // void goToLoadMoreScreen() {
  //   Get.toNamed(AppRoute.routeLoadmoreScreen());
  // }

  // void goToRefreshTokenScreen() {
  //   Get.toNamed(AppRoute.routeRefreshTokenScreen());
  // }

  // void goToAnimationScreen() {
  //   Get.toNamed(AppRoute.routeAnimationScreen());
  // }

  void onLogout() {
    _logoutUseCase.execute();
  }

  // Future<void> _testSetCurrentScreen() async {
  //   await FirebaseAnalytics().setCurrentScreen(
  //     screenName: 'Analytics Demo',
  //     screenClassOverride: 'AnalyticsDemo',
  //   );
  //   // test carshlytics
  //   //FirebaseCrashlytics.instance.crash();
  // }
}
