import 'package:flutter/material.dart';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:app_links/app_links.dart';

class AppDeepLinks with ChangeNotifier {
  static late AppDeepLinks _instance;

  static Future<void> init() async {
    final appLinks = AppLinks();
    final referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
    final initialLink = await appLinks.getLatestAppLink();
    _instance = AppDeepLinks._(initialLink, appLinks, referrerDetails);
  }

  factory AppDeepLinks() {
    return _instance;
  }

  AppDeepLinks._(Uri? initialUrl, AppLinks appLinks, ReferrerDetails referrerDetails) {
    final referrerQuery = _parseQueryString(referrerDetails.installReferrer ?? '');
    final referrerPath = Uri.parse(referrerQuery.remove('path') ?? '').replace(queryParameters: referrerQuery);

    _initialUrl = initialUrl ?? referrerPath;

    appLinks.uriLinkStream.listen((uri) {
      _initialUrl = uri;
      notifyListeners();
    });
  }

  Uri? _initialUrl;

  Uri? get initialUrl => _initialUrl;

  Map<String, String> _parseQueryString(String queryString) {
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
