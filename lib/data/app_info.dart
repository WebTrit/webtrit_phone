import 'package:flutter/services.dart' as services;

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/common/common.dart';

final Logger _logger = Logger('AppInfo');

class AppInfo {
  static Future<AppInfo> init(AppIdProvider appIdProvider) async {
    final id = await appIdProvider.getId();

    String? appVersion = await getAppVersion();

    return AppInfo._(appIdProvider, id, appVersion);
  }

  static Future<String?> getAppVersion() async {
    try {
      final pubspecString = await services.rootBundle.loadString(Assets.pubspec);
      final regExp = RegExp(r'app_version:\s*(\d+\.\d+\.\d+(\+\d+)?)');
      return regExp.firstMatch(pubspecString)?.group(1);
    } catch (e) {
      _logger.warning(e);
      return null;
    }
  }

  AppInfo._(this.appInfo, this._identifier, this._appVersion) {
    appInfo.onIdChange.listen((String id) {
      _identifier = id;
    });
  }

  AppIdProvider appInfo;

  String _identifier;

  final String? _appVersion;

  String get identifier => _identifier;

  String get version => _appVersion ?? '';
}
