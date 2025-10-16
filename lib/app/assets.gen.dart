/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsCallkeepGen {
  const $AssetsCallkeepGen();

  /// File path: assets/callkeep/ios_icon_template_image.png
  AssetGenImage get iosIconTemplateImage =>
      const AssetGenImage('assets/callkeep/ios_icon_template_image.png');

  /// List of all assets
  List<AssetGenImage> get values => [iosIconTemplateImage];
}

class $AssetsCertificatesGen {
  const $AssetsCertificatesGen();

  /// File path: assets/certificates/credentials.json
  String get credentials => 'assets/certificates/credentials.json';

  /// List of all assets
  List<String> get values => [credentials];
}

class $AssetsLoginGen {
  const $AssetsLoginGen();

  /// File path: assets/login/onboarding-1.svg
  SvgGenImage get onboarding1 =>
      const SvgGenImage('assets/login/onboarding-1.svg');

  /// List of all assets
  List<SvgGenImage> get values => [onboarding1];
}

class $AssetsRingtonesGen {
  const $AssetsRingtonesGen();

  /// File path: assets/ringtones/incoming-call-1.mp3
  String get incomingCall1 => 'assets/ringtones/incoming-call-1.mp3';

  /// File path: assets/ringtones/outgoing-call-1.mp3
  String get outgoingCall1 => 'assets/ringtones/outgoing-call-1.mp3';

  /// List of all assets
  List<String> get values => [incomingCall1, outgoingCall1];
}

class $AssetsThemesGen {
  const $AssetsThemesGen();

  /// File path: assets/themes/app.config.json
  String get appConfig => 'assets/themes/app.config.json';

  /// File path: assets/themes/custom_signup.html
  String get customSignup => 'assets/themes/custom_signup.html';

  /// File path: assets/themes/original.color_scheme.dark.config.json
  String get originalColorSchemeDarkConfig =>
      'assets/themes/original.color_scheme.dark.config.json';

  /// File path: assets/themes/original.color_scheme.light.config.json
  String get originalColorSchemeLightConfig =>
      'assets/themes/original.color_scheme.light.config.json';

  /// File path: assets/themes/original.page.dark.config.json
  String get originalPageDarkConfig =>
      'assets/themes/original.page.dark.config.json';

  /// File path: assets/themes/original.page.light.config.json
  String get originalPageLightConfig =>
      'assets/themes/original.page.light.config.json';

  /// File path: assets/themes/original.widget.dark.config.json
  String get originalWidgetDarkConfig =>
      'assets/themes/original.widget.dark.config.json';

  /// File path: assets/themes/original.widget.light.config.json
  String get originalWidgetLightConfig =>
      'assets/themes/original.widget.light.config.json';

  /// List of all assets
  List<String> get values => [
    appConfig,
    customSignup,
    originalColorSchemeDarkConfig,
    originalColorSchemeLightConfig,
    originalPageDarkConfig,
    originalPageLightConfig,
    originalWidgetDarkConfig,
    originalWidgetLightConfig,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsCallkeepGen callkeep = $AssetsCallkeepGen();
  static const $AssetsCertificatesGen certificates = $AssetsCertificatesGen();
  static const $AssetsLoginGen login = $AssetsLoginGen();
  static const SvgGenImage primaryOnboardinLogo = SvgGenImage(
    'assets/primary_onboardin_logo.svg',
  );
  static const $AssetsRingtonesGen ringtones = $AssetsRingtonesGen();
  static const SvgGenImage secondaryOnboardinLogo = SvgGenImage(
    'assets/secondary_onboardin_logo.svg',
  );
  static const $AssetsThemesGen themes = $AssetsThemesGen();
  static const String pubspec = 'pubspec.yaml';

  /// List of all assets
  static List<dynamic> get values => [
    primaryOnboardinLogo,
    secondaryOnboardinLogo,
    pubspec,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
