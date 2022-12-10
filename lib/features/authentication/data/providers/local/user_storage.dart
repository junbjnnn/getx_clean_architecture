import 'package:flutter/material.dart';
import 'package:jbbase_app/base/data/local/local_storage.dart';
import 'package:jbbase_app/features/authentication/data/models/token_model.dart';
import 'package:jiffy/jiffy.dart';

extension UserStorage on LocalStorage {
  static const String _kUserToken = 'user_token';

  static const String _kUserRefreshToken = 'user_refresh_token';

  static const String _kUserTokenExpiredTime = 'user_token_expired_time';

  static const String _isAskedCameraPermission = 'is_asked_camera_permission';

  static const String _kLocale = 'locale';

  static const String _kThemeMode = 'theme_mode';

  // User token
  Future<String?> get userToken {
    return secureStorage.read(key: _kUserToken);
  }

  Future<void> saveUserToken(String? userToken) {
    return secureStorage.write(key: _kUserToken, value: userToken);
  }

  Future<void> removeUserToken() {
    return secureStorage.delete(key: _kUserToken);
  }

  // User refresh token
  Future<String?> get userRefreshToken {
    return secureStorage.read(key: _kUserRefreshToken);
  }

  Future<void> saveUserRefreshToken(String? userRefreshToken) async {
    if (userRefreshToken == null) return;

    return secureStorage.write(key: _kUserRefreshToken, value: userRefreshToken);
  }

  Future<void> removeUserRefreshToken() {
    return secureStorage.delete(key: _kUserRefreshToken);
  }

  // User token expired time
  Future<DateTime?> get userTokenExpiredTime async {
    final time = await secureStorage.read(key: _kUserTokenExpiredTime);

    return time != null ? Jiffy(time).dateTime : null;
  }

  Future<void> saveUserTokenExpiredTime(int? userTokenExpiredTime) async {
    if (userTokenExpiredTime == null) return;

    final time = Jiffy().add(seconds: userTokenExpiredTime - 10).dateTime.toIso8601String();

    return secureStorage.write(key: _kUserTokenExpiredTime, value: time);
  }

  Future<void> removeUserTokenExpiredTime() {
    return secureStorage.delete(key: _kUserTokenExpiredTime);
  }

  // User token data
  Future<void> saveUserTokenData(TokenModel? tokenModel) {
    return Future.wait([
      saveUserToken(tokenModel?.accessToken),
      saveUserRefreshToken(tokenModel?.refreshToken),
      saveUserTokenExpiredTime(tokenModel?.expireIn),
    ]);
  }

  Future<void> removeUserTokenData() {
    return Future.wait([
      removeUserToken(),
      removeUserRefreshToken(),
      removeUserTokenExpiredTime(),
    ]);
  }

  // Camera permission
  bool? get askedCameraPermission {
    return getStorage.read(_isAskedCameraPermission);
  }

  Future<void> saveIsAskedCameraPermission(bool isAskedCameraPermission) {
    return getStorage.write(_isAskedCameraPermission, isAskedCameraPermission);
  }

  Future<void> removeIsAskedCameraPermission() {
    return getStorage.remove(_isAskedCameraPermission);
  }

  // Locale
  String? get locale {
    return getStorage.read(_kLocale);
  }

  Future<void> saveLocale(String currentLocale) {
    return getStorage.write(_kLocale, currentLocale);
  }

  Future<void> removeLocale() {
    return getStorage.remove(_kLocale);
  }

  // Dark mode
  ThemeMode get themeMode {
    final String themeMode = getStorage.read(_kThemeMode) ?? 'system';

    return ThemeMode.values.byName(themeMode);
  }

  Future<void> saveThemeMode(ThemeMode themeMode) {
    return getStorage.write(_kThemeMode, themeMode.name);
  }

  Future<void> removeThemeMode() {
    return getStorage.remove(_kThemeMode);
  }
}
