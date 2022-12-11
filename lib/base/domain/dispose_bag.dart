import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jbbase_app/utils/service/log_service.dart';

import 'disposable.dart';

class DisposeBag {
  final List<Object> _disposable = [];
  void addDisposable(Object disposable) {
    _disposable.add(disposable);
  }

  void dispose() {
    _disposable.forEach((disposable) {
      if (disposable is TextEditingController) {
        disposable.dispose();
        L.info('Disposed $disposable');
      } else if (disposable is StreamSubscription) {
        disposable.cancel();
        L.info('Canceled $disposable');
      } else if (disposable is StreamController) {
        disposable.close();
        L.info('Closed $disposable');
      } else if (disposable is ChangeNotifier) {
        disposable.dispose();
        L.info('Disposed $disposable');
      } else if (disposable is Disposable) {
        disposable.dispose();
      }
    });

    _disposable.clear();
  }
}

extension TextEditingControllerExtensions on TextEditingController {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension StreamSubscriptionExtensions on StreamSubscription {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension StreamControllerExtensions on StreamController {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension ChangeNotifierExtensions on ChangeNotifier {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension DisposableExtensions on Disposable {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}
