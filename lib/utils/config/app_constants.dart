class AppConstants {
  static const dateTimeFormat = 'yyyy/MM/dd HH:mm:ss';
  static const dateFormat = 'yyyy/M/dd';
}

extension AppLinkConstants on AppConstants {
  static const termsOfService = 'https://google.com';
  static const privacyPolicy = 'https://google.com';
}

extension DurationConstants on AppConstants {
  static const defaultListGridTransitionDuration = Duration(milliseconds: 500);
  static const defaultEventTransfomDuration = Duration(milliseconds: 500);
  static const defaultGeneralDialogTransitionDuration = Duration(milliseconds: 200);
  static const defaultSnackBarDuration = Duration(seconds: 3);
  static const defaultErrorVisibleDuration = Duration(seconds: 3);
}

extension PagingConstants on AppConstants {
  static const initialPage = 1;
  static const itemsPerPage = 30;
  static const defaultInvisibleItemsThreshold = 3;
}
