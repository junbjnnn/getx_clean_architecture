// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:jbbase_app/utils/config/app_constants.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeExtension on DateTime {
  String get dateString {
    return Jiffy(this).format(AppConstants.dateFormat);
  }

  String get datetimeString {
    return Jiffy(this).format(AppConstants.dateTimeFormat);
  }

  DateTime get toMyLocal {
    final dateTime = DateFormat('yyyy/MM/dd HH:mm:ss').parse(datetimeString, true);

    return dateTime.toLocal();
  }
}
