import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jbbase_app/base/data/app_error.dart';
import 'package:jbbase_app/l10n/generated/l10n.dart';

export 'package:get/get_rx/get_rx.dart';
export 'package:get/instance_manager.dart';

export '../../utils/config/app_navigation.dart';
export '../../utils/service/log_service.dart';
export '../data/app_error.dart';
export '../domain/base_observer.dart';
export '../domain/base_state.dart';

class BaseController<T> extends SuperController {
  late Future<OkCancelResult> Function(AppException e) showRetryError;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
    String? okText,
  }) showOkDialog;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
    String? okText,
    String? cancelText,
  }) showOkCancelDialog;

  T get input => Get.arguments;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void back() {
    Get.back();
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void initDialog(BuildContext context) {
    showRetryError = (e) {
      if (e.type == AppExceptionType.network) {
        return showOkAlertDialog(
          context: context,
          title: S.current.error,
          message: S.current.network_error,
          okLabel: S.current.try_again,
        );
      }

      return showOkAlertDialog(
        context: context,
        title: S.current.error,
        message: S.current.common_error_message,
        okLabel: S.current.try_again,
      );
    };

    showOkCancelDialog = ({
      String? title,
      String? message,
      String? okText,
      String? cancelText,
    }) {
      return showOkCancelAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okText ?? S.current.yes,
        cancelLabel: cancelText ?? S.current.no,
      );
    };
    showOkDialog = ({String? title, String? message, String? okText}) {
      return showOkAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okText ?? 'OK',
      );
    };
  }
}
