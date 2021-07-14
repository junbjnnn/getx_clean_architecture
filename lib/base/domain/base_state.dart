import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

int inititalPage = 1;

class BaseState<T> extends GetxController with StateMixin<T> {
  int? nextPage = inititalPage;
  T? data;

  BaseState() {
    change(null, status: RxStatus.empty());
  }

  void onSuccess({T? data, int? nextPage}) {
    this.nextPage = nextPage ?? this.nextPage;

    if (status.isLoadingMore) {
      change(((value as List<dynamic>) + (data as List<dynamic>) as T),
          status: RxStatus.success());
    } else {
      change(data, status: RxStatus.success());
    }
  }

  void onError(String? message) {
    change(null, status: RxStatus.error(message));
  }

  void onLoading() {
    if (nextPage! > inititalPage) {
      change(value, status: RxStatus.loadingMore());
    } else {
      change(null, status: RxStatus.loading());
    }
  }

  void onRefreshing() {
    nextPage = inititalPage;
    data = null;
    change(null, status: RxStatus.empty());
  }

  Widget widget({
    Widget Function(T? value)? onSuccess,
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onLoadingMore,
    Widget? onEmpty,
  }) {
    return obx(
      (value) {
        if (status.isSuccess) {
          return onSuccess != null ? onSuccess(value) : SizedBox.shrink();
        }
        if (status.isLoadingMore) {
          return onLoadingMore != null ? onLoadingMore : SizedBox.shrink();
        }
        // other custom state
        return SizedBox.shrink();
      },
      onError: onError != null
          ? onError
          : (_) {
              return SizedBox.shrink();
            },
      onLoading: onLoading != null
          ? onLoading
          : const Center(
              child: CupertinoActivityIndicator(),
            ),
      onEmpty: onEmpty,
    );
  }
}
