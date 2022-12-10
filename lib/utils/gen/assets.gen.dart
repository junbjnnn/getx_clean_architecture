/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/SFProDisplay-Black.ttf
  String get sFProDisplayBlack => 'assets/fonts/SFProDisplay-Black.ttf';

  /// File path: assets/fonts/SFProDisplay-Bold.ttf
  String get sFProDisplayBold => 'assets/fonts/SFProDisplay-Bold.ttf';

  /// File path: assets/fonts/SFProDisplay-Heavy.ttf
  String get sFProDisplayHeavy => 'assets/fonts/SFProDisplay-Heavy.ttf';

  /// File path: assets/fonts/SFProDisplay-Light.ttf
  String get sFProDisplayLight => 'assets/fonts/SFProDisplay-Light.ttf';

  /// File path: assets/fonts/SFProDisplay-Medium.ttf
  String get sFProDisplayMedium => 'assets/fonts/SFProDisplay-Medium.ttf';

  /// File path: assets/fonts/SFProDisplay-Regular.ttf
  String get sFProDisplayRegular => 'assets/fonts/SFProDisplay-Regular.ttf';

  /// File path: assets/fonts/SFProDisplay-Semibold.ttf
  String get sFProDisplaySemibold => 'assets/fonts/SFProDisplay-Semibold.ttf';

  /// File path: assets/fonts/SFProDisplay-Thin.ttf
  String get sFProDisplayThin => 'assets/fonts/SFProDisplay-Thin.ttf';

  /// File path: assets/fonts/SFProDisplay-Ultralight.ttf
  String get sFProDisplayUltralight =>
      'assets/fonts/SFProDisplay-Ultralight.ttf';

  /// List of all assets
  List<String> get values => [
        sFProDisplayBlack,
        sFProDisplayBold,
        sFProDisplayHeavy,
        sFProDisplayLight,
        sFProDisplayMedium,
        sFProDisplayRegular,
        sFProDisplaySemibold,
        sFProDisplayThin,
        sFProDisplayUltralight
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/splash_icon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/images/splash_icon.png');

  /// File path: assets/images/splash_icon_android_12.png
  AssetGenImage get splashIconAndroid12 =>
      const AssetGenImage('assets/images/splash_icon_android_12.png');

  /// List of all assets
  List<AssetGenImage> get values => [splashIcon, splashIconAndroid12];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
