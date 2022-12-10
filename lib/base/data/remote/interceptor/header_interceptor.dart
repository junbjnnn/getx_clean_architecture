import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:jbbase_app/utils/service/log_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    L.info('onRequest HeaderInterceptor ${options.uri}');
    final userAgentValue = await userAgentClientHintsHeader();
    options.headers['User-Agent'] = userAgentValue;
    options.headers['Content-Type'] = 'application/json';
    options.headers['X-Device-Id'] = await deviceId();
    options.headers['X-Device-Platform'] = deviceType();
    options.headers['Accept-Language'] = Intl.getCurrentLocale();

    handler.next(options);
  }

  Future<String> userAgentClientHintsHeader() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final appName = packageInfo.appName;
      final appVersion = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;

      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = (await deviceInfoPlugin.deviceInfo).toMap();
      final deviceName = deviceInfo['model'];
      final deviceVersion = '${deviceInfo["systemName"]} ${deviceInfo["systemVersion"]}';

      return '$appName/$appVersion+$buildNumber ($deviceName / $deviceVersion)';
    } on Exception catch (_) {
      return 'The Platform not support get info';
    }
  }

  Future<String?> deviceId() async {
    String? deviceId;
    if (Platform.isIOS) {
      deviceId = (await DeviceInfoPlugin().iosInfo).identifierForVendor;
    } else if (Platform.isAndroid) {
      deviceId = await const AndroidId().getId();
    }

    return deviceId;
  }

  String deviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    }

    return 'unknown';
  }
}
