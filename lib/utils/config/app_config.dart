import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Enviroment { dev, prod }

class AppConfig {
  static Enviroment env = Enviroment.dev;

  static Future<void> checkEnv() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    env = packageName.endsWith('.dev') ? Enviroment.dev : Enviroment.prod;
  }

  static Future<void> loadEnv() async {
    await checkEnv();
    debugPrint('$env');

    var fileName = '';
    switch (env) {
      case Enviroment.dev:
        fileName = 'assets/env/.env_dev';
        break;
      case Enviroment.prod:
        fileName = 'assets/env/.env_production';
        break;
      default:
    }
    await dotenv.load(fileName: fileName);
    debugPrint(dotenv.env['SOMETHING_KEY_XXX']);
    debugPrint(dotenv.env['SOMETHING_KEY']);
  }
}
