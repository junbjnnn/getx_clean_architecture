import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jbbase_app/base/data/local/local_storage.dart';

import 'app.dart';
import 'features/authentication/data/data.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;
import 'utils/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeJsonMapper();

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await Firebase.initializeApp();
  await GetStorage.init();
  await initHive();
  await AppConfig.loadEnv();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Get.put(LocalStorage(), permanent: true);

  final CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(),
  ]);
  final CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), []);

  Catcher(
    runAppFunction: () {
      // Pass all uncaught errors from the framework to Crashlytics.
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      // SystemChrome.setSystemUIOverlayStyle(
      //   const SystemUiOverlayStyle(
      //     statusBarColor: Colors.black,
      //     statusBarIconBrightness: Brightness.dark,
      //     systemNavigationBarColor: Colors.black,
      //     statusBarBrightness: Brightness.dark,
      //     systemNavigationBarIconBrightness: Brightness.dark,
      //   ),
      // );
      runApp(MyApp(Get.find()));
    },
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
}
