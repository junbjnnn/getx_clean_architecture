import 'package:envied/envied.dart';

import 'app_env.dart';

part 'stg_env.g.dart';

@Envied(name: 'Env', path: 'assets/env/.env.stg', obfuscate: true)
class StgEnv implements AppEnv {
  @override
  @EnviedField(varName: 'BASE_URL')
  final String baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'REVENUECAT_PUBLIC_KEY_ANDROID')
  final String revenueCatPublicKeyAndroid = _Env.revenueCatPublicKeyAndroid;

  @override
  @EnviedField(varName: 'REVENUECAT_PUBLIC_KEY_IOS')
  final String revenueCatPublicKeyIos = _Env.revenueCatPublicKeyIos;

  @override
  @EnviedField(defaultValue: 0)
  final int keyInt = _Env.keyInt;

  @override
  @EnviedField(defaultValue: false)
  final bool keyBool = _Env.keyBool;
}
