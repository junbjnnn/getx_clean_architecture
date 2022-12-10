class Observer<T> {
  Function? _onSubscribe;
  Function? _onSuccess;
  Function? _onError;
  Function? _onCompleted;

  Observer({
    Function? onSubscribe,
    Function(T)? onSuccess,
    Function? onError,
    Function? onCompleted,
  }) {
    _onSubscribe = onSubscribe;
    _onSuccess = onSuccess;
    _onError = onError;
    _onCompleted = onCompleted;
  }

  onSubscribe() => _onSubscribe?.call();

  onSuccess(T) => _onSuccess?.call(T);

  onError(dynamic e) => _onError?.call(e);

  onCompleted() => _onCompleted?.call();
}
