import 'package:flutter/services.dart';

/// All supported device orientations.
const _allOrientations = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
];

/// Portrait-only orientations.
const _portraitOrientations = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];

Future<void> setPortraitPreferredOrientations() {
  return SystemChrome.setPreferredOrientations(_portraitOrientations);
}

Future<void> setAllPreferredOrientations() {
  return SystemChrome.setPreferredOrientations(_allOrientations);
}
