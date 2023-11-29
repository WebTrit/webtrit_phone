import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';

class AppDeferredDeepLinks {
  static late AppDeferredDeepLinks _instance;

  static Future<void> init() async {
    String? installReferrer;

    if (Platform.isAndroid) {
      final playInstallReferrer = await AndroidPlayInstallReferrer.installReferrer;
      installReferrer = playInstallReferrer.installReferrer;
      _instance = AppDeferredDeepLinks._appAndroidReferrerDeepLinks(installReferrer);
    } else if (Platform.isIOS) {
      _instance = AppDeferredDeepLinks._appIOSReferrerDeepLinks(installReferrer);
    } else {
      _instance = AppDeferredDeepLinks._();
    }
  }

  factory AppDeferredDeepLinks() {
    return _instance;
  }

  AppDeferredDeepLinks._();

  AppDeferredDeepLinks._appAndroidReferrerDeepLinks(String? installReferrer) {
    if (installReferrer != null) {
      final referrerQuery = _parseAndroidRefererQueryString(installReferrer);
      final referrerPath = Uri.parse(referrerQuery.remove('path') ?? '').replace(queryParameters: referrerQuery);
      _initialUrl = referrerPath;
    }
  }

  AppDeferredDeepLinks._appIOSReferrerDeepLinks(String? installReferrer) {
    // Constructor for handling iOS-specific deferred deep links.
  }

  Uri? _initialUrl;

  Uri? get initialUrl => _initialUrl;

  Map<String, String> _parseAndroidRefererQueryString(String queryString) {
    List<String> pairs = queryString.split('&');
    Map<String, String> resultMap = {};
    for (String pair in pairs) {
      List<String> keyValue = pair.split('=');
      if (keyValue.length == 2) {
        String key = Uri.decodeComponent(keyValue[0]);
        String value = Uri.decodeComponent(keyValue[1]);
        resultMap[key] = value;
      }
    }
    return resultMap;
  }
}
