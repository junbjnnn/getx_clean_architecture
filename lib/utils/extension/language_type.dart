enum LanguageType { en, vi }

extension LanguageTypeExtension on LanguageType {
  String get code {
    switch (this) {
      case LanguageType.en:
        return 'en';
      case LanguageType.vi:
        return 'vi';
      default:
        return 'en';
    }
  }
}
