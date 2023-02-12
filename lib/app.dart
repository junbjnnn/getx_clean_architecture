import 'package:catcher/catcher.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:jbbase_app/features/authentication/data/providers/local/user_storage_ex.dart';

import 'base/data/local/local_storage.dart';
import 'l10n/generated/l10n.dart';
import 'utils/config/app_binding.dart';
import 'utils/config/app_navigator_observer.dart';
import 'utils/config/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._localStorage, {Key? key}) : super(key: key);
  final LocalStorage _localStorage;

  Locale _setLocale() {
    final locale = _localStorage.locale;

    return locale != null ? Locale(locale) : Get.deviceLocale!;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Catcher.navigatorKey,
      title: 'GetX Clean Architecture',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: AppRoute.root,
      initialBinding: AppBinding(),
      getPages: AppRoute.generateGetPages,
      navigatorObservers: [AppNavigatorObserver()],
      locale: _setLocale(),
      fallbackLocale: const Locale('en', 'US'),
      // This theme was made for FlexColorScheme version 6.1.1. Make sure
      // you use same or higher version, but still same major version. If
      // you use a lower version, some properties may not be supported. In
      // that case you can also remove them after copying the theme to your app.
      theme: FlexThemeData.light(
        scheme: FlexScheme.flutterDash,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.flutterDash,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      // If you do not have a themeMode switch, uncomment this line
      // to let the device system mode control the theme mode:
      themeMode: _localStorage.themeMode,
    );
  }
}
