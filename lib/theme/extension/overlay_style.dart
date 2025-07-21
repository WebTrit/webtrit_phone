import 'package:flutter/services.dart';
import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension OverlayStyleModelMapper on OverlayStyleModel {
  SystemUiOverlayStyle toSystemUiOverlayStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor.toColor(),
      statusBarIconBrightness: _mapBrightness(statusBarIconBrightness),
      statusBarBrightness: statusBarBrightness != null ? _mapBrightness(statusBarBrightness!) : null,
      systemNavigationBarColor: systemNavigationBarColor?.toColor(),
      systemNavigationBarIconBrightness:
          systemNavigationBarIconBrightness != null ? _mapBrightness(systemNavigationBarIconBrightness!) : null,
    );
  }

  Brightness _mapBrightness(String b) {
    return Brightness.values.firstWhere((e) => e.name == b, orElse: () => Brightness.light);
  }
}
