import 'package:jbbase_app/utils/config/app_constants.dart';
import 'package:jiffy/jiffy.dart';

extension IntExtension on int {
  DateTime get dateTime => Jiffy.unixFromMillisecondsSinceEpoch(this).dateTime;

  String get dateTimeString => Jiffy.unixFromMillisecondsSinceEpoch(this).format(AppConstants.dateTimeFormat);
}
