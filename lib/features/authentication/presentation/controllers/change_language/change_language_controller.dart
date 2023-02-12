import 'package:jbbase_app/base/base.dart';
import 'package:jbbase_app/features/authentication/data/providers/local/user_storage_ex.dart';
import 'package:jbbase_app/utils/extension/language_type.dart';

class ChangeLanguageController extends BaseController {
  final List<Language> languages = [
    Language(S.current.vietnamese, true.obs, Locale(LanguageType.vi.code)),
    Language(S.current.english, false.obs, Locale(LanguageType.en.code)),
  ];
  final _localStorage = Get.find<LocalStorage>();

  @override
  void onInit() {
    super.onInit();
    _getLanguage();
  }

  void onSelectLanguage(int index) async {
    for (final i in languages) {
      i.isSelected.value = i.locale.languageCode == languages[index].locale.languageCode;
    }
    await S.load(languages[index].locale);
    await Get.updateLocale(languages[index].locale);
    _localStorage.saveLocale(languages[index].locale.languageCode);
    AppException.initServerError();
  }

  void _getLanguage() {
    var locale = Get.locale;
    if (locale != null) {
      locale = Locale(locale.languageCode);
      if (S.delegate.supportedLocales.contains(locale)) {
        for (final i in languages) {
          i.isSelected.value = i.locale.languageCode == locale.languageCode;
        }
      }
    }
  }
}

class Language {
  final String language;
  final RxBool isSelected;
  final Locale locale;

  Language(this.language, this.isSelected, this.locale);
}
