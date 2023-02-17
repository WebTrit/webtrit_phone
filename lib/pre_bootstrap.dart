// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/environment_config.dart';

void preBootstrap() {
  if (kIsWeb && kDebugMode) {
    document.title = EnvironmentConfig.APP_NAME;
    document.head
        ?.querySelector('meta[name="description"]')
        ?.setAttribute('content', EnvironmentConfig.APP_DESCRIPTION);
  }
}
