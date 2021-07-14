import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';

class L {
  static final LogService _logService = Get.find();

  static void v(dynamic message) {
    _logService.logger.v(message);
  }

  static void d(dynamic message) {
    _logService.logger.d(message);
  }

  static void i(dynamic message) {
    _logService.logger.i(message);
  }

  static void w(dynamic message) {
    _logService.logger.w(message);
  }

  static void e(dynamic message) {
    _logService.logger.e(message);
  }

  static void wtf(dynamic message) {
    _logService.logger.wtf(message);
  }
}

class LogService extends GetxService {
  final logger = Logger(
    printer: MyPrinter(),
  );
}

class MyPrinter extends LogPrinter {
  static final levelEmojis = {
    Level.verbose: '🙂',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warning: '❓',
    Level.error: '⛔',
    Level.wtf: '🖕',
  };

  @override
  List<String> log(LogEvent event) {
    final icon = levelEmojis[event.level]!;
    final msg = event.message;
    final time = Jiffy(DateTime.now()).format('h:mm:ss a');
    return ['[$time] $icon $msg'];
  }
}
