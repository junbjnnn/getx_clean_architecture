import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:jbbase_app/features/authentication/data/providers/local/user_storage_ex.dart';
import 'package:jbbase_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:jbbase_app/utils/service/auth_service.dart';
import 'package:jbbase_app/utils/service/log_service.dart';
import 'package:jiffy/jiffy.dart';

import '../../local/local_storage.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final _authHeaderKey = 'Authorization';
  final _bearer = 'Bearer';

  final _localStorage = Get.find<LocalStorage>();

  TokenInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    L.info('onRequest TokenInterceptor ${options.uri}');

    try {
      var localToken = await _localStorage.userToken;
      final expiredTime = await _localStorage.userTokenExpiredTime;
      final isExpired = expiredTime != null && Jiffy(expiredTime).diff(Jiffy()) < 0;
      if (isExpired) {
        localToken = await _refreshToken();
      }
      options.headers[_authHeaderKey] = '$_bearer $localToken';
      handler.next(options);
    } on DioError catch (e) {
      handler.reject(e);
      _logoutIfNeeded(e);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    L.error('onError TokenInterceptor ${err.requestOptions.uri}');
    if (err.response?.statusCode == HttpStatus.unauthorized || err.response?.statusCode == HttpStatus.forbidden) {
      try {
        // Check latest token
        final request = err.requestOptions;
        final requestToken = request.headers[_authHeaderKey] ?? '';
        final localToken = await _localStorage.userToken ?? '';
        var latestToken = '$_bearer $localToken';
        if ((requestToken == latestToken) || (requestToken.isEmpty && localToken.isEmpty)) {
          latestToken = '$_bearer ${await _refreshToken()}';
        }

        // Update header
        request.headers.update(_authHeaderKey, (_) => latestToken, ifAbsent: () => latestToken);

        // Re-call request
        L.info('re-call request ${request.uri}');
        final response = await _dio.request(
          request.path,
          data: request.data,
          queryParameters: request.queryParameters,
          cancelToken: request.cancelToken,
          options: Options(
            method: request.method,
            sendTimeout: request.sendTimeout,
            extra: request.extra,
            headers: request.headers,
            responseType: request.responseType,
            contentType: request.contentType,
            receiveDataWhenStatusError: request.receiveDataWhenStatusError,
            followRedirects: request.followRedirects,
            maxRedirects: request.maxRedirects,
            requestEncoder: request.requestEncoder,
            responseDecoder: request.responseDecoder,
            listFormat: request.listFormat,
          ),
          onReceiveProgress: request.onReceiveProgress,
        );

        return handler.resolve(response);
      } on DioError catch (e) {
        handler.reject(e);

        return _logoutIfNeeded(e);
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken() async {
    L.info('refresh token start');
    await Get.find<AuthRepo>().refreshToken();
    L.info('refresh token done');

    return await _localStorage.userToken ?? '';
  }

  void _logoutIfNeeded(DioError e) {
    if (e.response?.statusCode == HttpStatus.unauthorized || e.response?.statusCode == HttpStatus.forbidden) {
      Get.find<AuthService>().logout();
    }
  }
}
