import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_svg/svg.dart';

abstract class ThemeAsset {}

abstract class ThemeSvgAsset extends ThemeAsset {
  ThemeSvgAsset();

  Widget svg({
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
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
  });

  factory ThemeSvgAsset.fromJson(String value) {
    if (value.startsWith(ThemeAssetSvgAsset.prefix)) {
      return ThemeAssetSvgAsset.fromJson(value);
    } else if (value.startsWith(ThemeMemorySvgAsset.prefix)) {
      return ThemeMemorySvgAsset.fromJson(value);
    } else {
      return ThemeNetworkSvgAsset.fromJson(value);
    }
  }

  String toJson();
}

class ThemeNetworkSvgAsset extends ThemeSvgAsset {
  ThemeNetworkSvgAsset(this._url);

  final String _url;

  @override
  Widget svg({
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
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.network(
      _url,
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
      theme: theme,
      colorFilter: colorFilter,
      clipBehavior: clipBehavior,
    );
  }

  factory ThemeNetworkSvgAsset.fromJson(String value) => ThemeNetworkSvgAsset(value);

  @override
  String toJson() => _url;
}

class ThemeAssetSvgAsset extends ThemeSvgAsset {
  static const prefix = 'asset://';

  ThemeAssetSvgAsset(this._assetName);

  final String _assetName;

  @override
  Widget svg({
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
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      clipBehavior: clipBehavior,
    );
  }

  factory ThemeAssetSvgAsset.fromJson(String value) => ThemeAssetSvgAsset(value.substring(prefix.length));

  @override
  String toJson() => 'asset://$_assetName';
}

class ThemeMemorySvgAsset extends ThemeSvgAsset {
  static const prefix = 'memory://';

  ThemeMemorySvgAsset(this._bytes);

  final Uint8List _bytes;

  @override
  Widget svg({
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
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.memory(
      _bytes,
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
      theme: theme,
      colorFilter: colorFilter,
      clipBehavior: clipBehavior,
    );
  }

  factory ThemeMemorySvgAsset.fromJson(String value) =>
      ThemeMemorySvgAsset(base64Decode(value.substring(prefix.length)));

  @override
  String toJson() => 'memory://${base64Encode(_bytes)}';
}
