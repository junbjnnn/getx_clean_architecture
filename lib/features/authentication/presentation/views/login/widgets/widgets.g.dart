// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => loadingWidget();
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({Key? key, this.value, this.height = 100})
      : super(key: key);

  final String? value;

  final double height;

  @override
  Widget build(BuildContext _context) =>
      successWidget(value: value, height: height);
}

class LoginErrorWidget extends StatelessWidget {
  const LoginErrorWidget({Key? key, this.msg, this.height = 100})
      : super(key: key);

  final String? msg;

  final double height;

  @override
  Widget build(BuildContext _context) =>
      loginErrorWidget(msg: msg, height: height);
}
