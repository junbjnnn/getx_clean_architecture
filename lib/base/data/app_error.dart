import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:jbbase_app/l10n/generated/l10n.dart';

import 'model/common/error_response.dart';

enum AppExceptionType {
  network,
  mapping,
  unauthorized,
  cancel,
  timeout,
  server,
  serverRetry,
  serverValidate,
  invalidInput,
  purchaseCancel,
  purchaseError,
  paymentRequired,
  unknown,
}

class AppException {
  final AppExceptionType type;

  final String message;

  final dynamic error;

  final String? title;

  final ErrorResponse? errorResponse;

  final int? headerCode;

  final StackTrace? stackTrace;

  static Map<String, String> serverErrors = {};

  AppException(
    this.type,
    this.message, {
    this.error,
    this.title,
    this.errorResponse,
    this.headerCode,
    this.stackTrace,
  });

  factory AppException.invalidInput(String message) {
    return AppException(AppExceptionType.invalidInput, message);
  }

  factory AppException.fromException(Exception exception) {
    var type = AppExceptionType.unknown;
    var message = '';
    String? title;
    ErrorResponse? errorResponse;
    int? headerCode;
    StackTrace? stackTrace;

    if (exception is DioError) {
      message = exception.response?.statusMessage ?? exception.message;
      headerCode = exception.response?.statusCode ?? -1;

      switch (exception.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          type = AppExceptionType.timeout;
          message = S.current.common_error_message;
          break;
        case DioErrorType.sendTimeout:
          type = AppExceptionType.network;
          message = S.current.network_error;
          break;
        case DioErrorType.response:
          switch (headerCode) {
            case HttpStatus.badRequest: // 400
              type = AppExceptionType.serverValidate;
              break;
            case HttpStatus.unauthorized: // 401
            case HttpStatus.forbidden: // 403
              type = AppExceptionType.unauthorized;
              break;
            case HttpStatus.paymentRequired: // 402
              type = AppExceptionType.paymentRequired;
              break;
            default:
              type = AppExceptionType.server;
              break;
          }
          // Custom each project
          final response = exception.response;
          if (response != null) {
            try {
              errorResponse = JsonMapper.fromMap<ErrorResponse>(response.data);
              title = errorResponse?.title;
              title = title?.isNotEmpty == true ? title : null;
              final errorMessage = errorResponse?.message ?? S.current.server_error_message;
              message = errorMessage.isEmpty ? S.current.server_error_message : errorMessage;
              if (headerCode >= 500 && headerCode < 600 && errorResponse?.code == null) {
                message = S.current.common_error_message;
              }
              if (errorResponse?.code != null) {
                message = serverErrors[errorResponse!.code] != null ? serverErrors[errorResponse.code]! : message;
                message = '$message(${errorResponse.code})';
              }
            } catch (e) {
              return AppException(
                AppExceptionType.serverRetry,
                S.current.server_error_message,
                title: title,
                error: e,
                headerCode: headerCode,
                stackTrace: stackTrace,
              );
            }
          }
          break;
        case DioErrorType.cancel:
          type = AppExceptionType.cancel;
          break;
        case DioErrorType.other:
        default:
          if (exception.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = AppExceptionType.network;
            message = S.current.network_error;
          } else {
            type = AppExceptionType.unknown;
          }
          break;
      }
    } else {
      type = AppExceptionType.unknown;
      message = 'AppException: $exception';
    }

    return AppException(
      type,
      message,
      title: title,
      error: exception,
      errorResponse: errorResponse,
      headerCode: headerCode,
      stackTrace: stackTrace,
    );
  }

  factory AppException.fromError(Error error) {
    return AppException(
      AppExceptionType.unknown,
      S.current.common_error_message,
      error: error,
      errorResponse: null,
      headerCode: null,
      stackTrace: error.stackTrace,
    );
  }

  static void initServerError() {
    serverErrors = {
      'S-0001': S.current.s_0001,
    };
  }

  @override
  String toString() {
    return '${type.name}: $message';
  }
}
