import 'package:flutter/services.dart' as services;

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/common/common.dart';

final Logger _logger = Logger('AppInfo');

class AppInfo {
  static Future<AppInfo> init(AppIdProvider appIdProvider) async {
    final id = await appIdProvider.getId();

    String? appVersion = await getAppVersion();
    String callkeepVersion = await getCallkeepVersion();

    return AppInfo._(appIdProvider, id, appVersion, callkeepVersion);
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

  /// Reads the webtrit_callkeep version from the bundled pubspec.yaml.
  ///
  /// On release branches the dependency is pinned to a git ref (the published
  /// callkeep tag), which is returned as-is. On develop it is a local path
  /// dependency with no ref, so [_localCallkeepVersion] is returned.
  static Future<String> getCallkeepVersion() async {
    try {
      final pubspecString = await services.rootBundle.loadString(Assets.pubspec);
      // Capture only the webtrit_callkeep block: its sub-lines are indented deeper
      // than the 2-space dependency key, so a sibling git ref (e.g. flutter_webrtc)
      // is not matched.
      final block = RegExp(
        r'^  webtrit_callkeep:\n((?:    .*\n?)*)',
        multiLine: true,
      ).firstMatch(pubspecString)?.group(1);
      if (block == null) return _localCallkeepVersion;
      return RegExp(r'ref:\s*(\S+)').firstMatch(block)?.group(1) ?? _localCallkeepVersion;
    } catch (e) {
      _logger.warning(e);
      return _localCallkeepVersion;
    }
  }

  static const String _localCallkeepVersion = 'local';

  AppInfo._(this.appInfo, this._identifier, this._appVersion, this._callkeepVersion) {
    appInfo.onIdChange.listen((String id) {
      _identifier = id;
    });
  }

  AppIdProvider appInfo;

  String _identifier;

  final String? _appVersion;

  final String _callkeepVersion;

  String get identifier => _identifier;

  String get version => _appVersion ?? '';

  String get callkeepVersion => _callkeepVersion;
}
