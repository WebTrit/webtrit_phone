// ignore_for_file: avoid_web_libraries_in_flutter

// ignore: depend_on_referenced_packages
import 'package:web/web.dart';

import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/environment_config.dart';

void preBootstrap() {
  if (kIsWeb && kDebugMode) {
    document.title = EnvironmentConfig.APP_NAME;

    const appDescription = EnvironmentConfig.APP_DESCRIPTION;
    if (appDescription != null) {
      document.head?.querySelector('meta[name="description"]')?.setAttribute('content', appDescription);
    }
  }
}
