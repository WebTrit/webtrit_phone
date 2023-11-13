import 'package:flutter/material.dart';

import 'package:app_links/app_links.dart';

class AppDeepLinks with ChangeNotifier {
  static late AppDeepLinks _instance;

  static Future<void> init() async {
    final appLinks = AppLinks();
    final initialLink = await appLinks.getLatestAppLink();
    _instance = AppDeepLinks._(initialLink, appLinks);
  }

  factory AppDeepLinks() {
    return _instance;
  }

  AppDeepLinks._(this._initialUrl, AppLinks appLinks) {
    appLinks.uriLinkStream.listen((uri) {
      _initialUrl = uri;
      notifyListeners();
    });
  }

  Uri? _initialUrl;

  Uri? get initialUrl => _initialUrl;
}
