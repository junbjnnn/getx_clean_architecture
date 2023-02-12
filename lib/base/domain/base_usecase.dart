import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../utils/service/log_service.dart';
import '../data/app_error.dart';
import 'base_observer.dart';
import 'base_repo.dart';

abstract class BaseHiveUseCase<E, Repo extends BaseHiveCRUDRepo<E>> extends GetxService {
  AddUseCase<E, Repo> get addUseCase => Get.find();
  AddAllUseCase<E, Repo> get addAllUseCase => Get.find();
  GetByIdUseCase<E, Repo> get getByIdUseCase => Get.find();
  GetAllUseCase<E, Repo> get getAllUseCase => Get.find();
  UpdateUseCase<E, Repo> get updateUseCase => Get.find();
  UpdateAllUseCase<E, Repo> get updateAllUseCase => Get.find();
  DeleteUseCase<E, Repo> get deleteUseCase => Get.find();
  DeleteAllUseCase<E, Repo> get deleteAllUseCase => Get.find();
  ClearUseCase<Repo> get clearUseCase => Get.find();
  WatchUseCase<Repo> get watchUseCase => Get.find();

  @override
  void onInit() {
    super.onInit();

    Get.lazyPut(() => AddUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => AddAllUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => GetByIdUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => GetAllUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => UpdateUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => UpdateAllUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => DeleteUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => DeleteAllUseCase<E, Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => ClearUseCase<Repo>(Get.find<Repo>()), fenix: true);
    Get.lazyPut(() => WatchUseCase<Repo>(Get.find<Repo>()), fenix: true);
  }
}

class AddUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, int> {
  final Repo repo;

  AddUseCase(this.repo);

  @override
  Future<int> build(I i) {
    return repo.add(i);
  }
}

class AddAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, List<int>> {
  final Repo repo;

  AddAllUseCase(this.repo);

  @override
  Future<List<int>> build(List<I> i) {
    return repo.addAll(i);
  }
}

class GetByIdUseCase<O, Repo extends BaseCRUDRepo<O>> extends UseCaseIO<int, O?> {
  final Repo repo;

  GetByIdUseCase(this.repo);

  @override
  Future<O?> build(int i) {
    return repo.getById(i);
  }
}

class GetAllUseCase<O, Repo extends BaseCRUDRepo<O>> extends UseCase<List<O>> {
  final Repo repo;

  GetAllUseCase(this.repo);

  @override
  Future<List<O>> build() {
    return repo.getAll();
  }
}

class UpdateUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, void> {
  final Repo repo;

  UpdateUseCase(this.repo);

  @override
  Future<void> build(I i) {
    return repo.update(i);
  }
}

class UpdateAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, void> {
  final Repo repo;

  UpdateAllUseCase(this.repo);

  @override
  Future<void> build(List<I> i) {
    return repo.updateAll(i);
  }
}

class DeleteUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, void> {
  final Repo repo;

  DeleteUseCase(this.repo);

  @override
  Future<void> build(I i) {
    return repo.delete(i);
  }
}

class DeleteAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, void> {
  final Repo repo;

  DeleteAllUseCase(this.repo);

  @override
  Future<void> build(List<I> i) {
    return repo.deleteAll(i);
  }
}

class ClearUseCase<Repo extends BaseCRUDRepo> extends UseCase<void> {
  final Repo repo;

  ClearUseCase(this.repo);

  @override
  Future<void> build() {
    return repo.clear();
  }
}

class WatchUseCase<Repo extends BaseHiveCRUDRepo> extends UseCaseIO<dynamic, Stream<BoxEvent>> {
  final Repo repo;

  WatchUseCase(this.repo);

  @override
  Future<Stream<BoxEvent>> build(dynamic key) {
    return Future.value(repo.watch(key: key));
  }
}

abstract class UseCase<T> extends _UseCase<void, T> {
  Future<void> execute({Observer<T>? observer}) async {
    return _execute(observer: observer);
  }

  Future<T> build();

  @override
  Future<Stream<T>> _buildUseCaseStream(void _) async {
    final controller = StreamController<T>();
    try {
      final value = await build();
      controller.add(value);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

abstract class UseCaseIO<Input, T> extends _UseCase<Input, T> {
  Future<T> build(Input input);

  Future<void> execute({Observer<T>? observer, required Input input}) async {
    return _execute(observer: observer, input: input);
  }

  @override
  Future<Stream<T>> _buildUseCaseStream(Input? input) async {
    final controller = StreamController<T>();
    try {
      final value = await build(input as Input);
      controller.add(value);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

abstract class _UseCase<Input, T> {
  late CompositeSubscription _disposables;

  _UseCase() {
    _disposables = CompositeSubscription();
  }

  void dispose() {
    if (!_disposables.isDisposed) {
      _disposables.dispose();
    }
  }

  Future<Stream<T>> _buildUseCaseStream(Input? input);

  Future<void> _execute({Observer<T>? observer, Input? input}) async {
    observer?.onSubscribe();
    final StreamSubscription subscription = (await _buildUseCaseStream(input)).listen(
      (data) {
        observer?.onSuccess(data);
      },
      onDone: observer?.onCompleted(),
      onError: (e) {
        if (e is AppException) {
          observer?.onError(e);
          L.error(e);
        } else if (e is DioError) {
          final appException = AppException.fromException(e);
          observer?.onError(appException);
          L.error(e.message);
        } else if (e is Error) {
          observer?.onError(AppException.fromError(e));
          L.error(e);
        } else if (e is Exception) {
          observer?.onError(AppException.fromException(e));
          L.error(e);
        } else {
          observer?.onError(AppException(AppExceptionType.unknown, e, error: e));
          L.error(e);
        }
      },
    );
    _addSubscription(subscription);
  }

  void _addSubscription(StreamSubscription subscription) {
    if (_disposables.isDisposed) {
      _disposables = CompositeSubscription();
    }
    _disposables.add(subscription);
  }
}

class CompositeSubscription {
  bool _isDisposed = false;

  final List<StreamSubscription<dynamic>> _subscriptionsList = [];

  /// Checks if this composite is disposed. If it is, the composite can't be used again
  /// and will throw an error if you try to add more subscriptions to it.
  bool get isDisposed => _isDisposed;

  /// Returns the total amount of currently added [StreamSubscription]s
  int get length => _subscriptionsList.length;

  /// Checks if there currently are no [StreamSubscription]s added
  bool get isEmpty => _subscriptionsList.isEmpty;

  /// Checks if there currently are [StreamSubscription]s added
  bool get isNotEmpty => _subscriptionsList.isNotEmpty;

  /// Whether all managed [StreamSubscription]s are currently paused.
  bool get allPaused => _subscriptionsList.isNotEmpty ? _subscriptionsList.every((it) => it.isPaused) : false;

  /// Adds new subscription to this composite.
  ///
  /// Throws an exception if this composite was disposed
  StreamSubscription<T> add<T>(StreamSubscription<T> subscription) {
    if (isDisposed) {
      throw ('This composite was disposed, try to use new instance instead');
    }
    if (_subscriptionsList.isNotEmpty) {
      remove(_subscriptionsList.last);
    }
    _subscriptionsList.add(subscription);

    return subscription;
  }

  /// Cancels subscription and removes it from this composite.
  void remove(StreamSubscription<dynamic> subscription) {
    subscription.cancel();
    _subscriptionsList.remove(subscription);
  }

  /// Cancels all subscriptions added to this composite. Clears subscriptions collection.
  ///
  /// This composite can be reused after calling this method.
  void clear() {
    _subscriptionsList.forEach((it) => it.cancel());
    _subscriptionsList.clear();
  }

  /// Cancels all subscriptions added to this composite. Disposes this.
  ///
  /// This composite can't be reused after calling this method.
  void dispose() {
    clear();
    _isDisposed = true;
  }

  /// Pauses all subscriptions added to this composite.
  void pauseAll([Future? resumeSignal]) => _subscriptionsList.forEach((it) => it.pause(resumeSignal));

  /// Resumes all subscriptions added to this composite.
  void resumeAll() => _subscriptionsList.forEach((it) => it.resume());
}

/// Extends the [StreamSubscription] class with the ability to be added to [CompositeSubscription] container.
extension AddToCompositeSubscriptionExtension<T> on StreamSubscription<T> {
  /// Adds this subscription to composite container for subscriptions.
  void addTo(CompositeSubscription compositeSubscription) => compositeSubscription.add(this);
}
