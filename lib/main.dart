import 'package:catcher/catcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:int_quest/utils/config/app_config.dart';

import 'app.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeJsonMapper();

  await Firebase.initializeApp();
  await GetStorage.init();
  await AppConfig.loadEnv();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final CatcherOptions debugOptions = CatcherOptions(PageReportMode(), [
    ConsoleHandler(),
  ]);
  final CatcherOptions releaseOptions = CatcherOptions(PageReportMode(), []);

  Catcher(
    runAppFunction: () {
      runApp(const MyApp());
    },
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}
