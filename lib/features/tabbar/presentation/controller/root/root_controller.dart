import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jbbase_app/base/presentation/base_controller.dart';
import 'package:jbbase_app/features/example/presentation/presentation.dart';
import 'package:jbbase_app/utils/service/auth_service.dart';
import 'package:jbbase_app/utils/service/connectivity_service.dart';

class RootController extends BaseController {
  final AuthService _authService;
  final ConnectivityService _connectivityService;

  RootController(
    this._authService,
    this._connectivityService,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      _connectivityService.listenConnectivity();
      AppException.initServerError();

      // TODO: remove
      await Future.delayed(const Duration(seconds: 1));

      // Handle transition
      if (await _authService.isAuthenticated()) {
        _handleAuthenticated();
      } else {
        _handleUnauthenticated();
      }
    } catch (e) {
      L.error(e);
      _handleUnauthenticated();
    }
  }

  void _handleAuthenticated() {
    N.toHome(input: ExampleHomeInput('u', 'p'));
    Future.delayed(const Duration(milliseconds: 100), FlutterNativeSplash.remove);

    /*
    _getMasterDataUseCase.execute(
      observer: Observer(
        onSuccess: (_) async {
          N.toHome(input: ExampleHomeInput('u', 'p'));
          Future.delayed(const Duration(milliseconds: 100), FlutterNativeSplash.remove);
        },
        onError: (AppException e) {
          _handleUnauthenticated();
        },
      ),
    );
    */
  }

  void _handleUnauthenticated() {
    _authService.logout().then((_) {
      Future.delayed(const Duration(milliseconds: 100), FlutterNativeSplash.remove);
    });
  }
}
