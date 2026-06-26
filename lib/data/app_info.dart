import 'package:flutter/services.dart' as services;

import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/common/common.dart';

final Logger _logger = Logger('AppInfo');

class AppInfo {
  static Future<AppInfo> init(AppIdProvider appIdProvider) async {
    final id = await appIdProvider.getId();

    final appVersion = await getAppVersion();
    final callkeepVersion = await getCallkeepVersion();

    return AppInfo._(appIdProvider, id, appVersion, callkeepVersion);
  }

  /// Parses the custom `app_version` field from the bundled pubspec.yaml as a
  /// semantic [Version]. This is the version shared across the whole codebase,
  /// NOT the platform build version (`PackageInfo.version`), which is derived
  /// from the standard pubspec `version:` (pinned to `0.0.0`) and differs per
  /// client build. A missing or unparseable value yields [Version.none]
  /// (`0.0.0`).
  static Future<Version> getAppVersion() async {
    try {
      final pubspecString = await services.rootBundle.loadString(Assets.pubspec);
      final regExp = RegExp(r'app_version:\s*(\d+\.\d+\.\d+(\+\d+)?)');
      final raw = regExp.firstMatch(pubspecString)?.group(1);
      return raw == null ? Version.none : Version.parse(raw);
    } catch (e) {
      _logger.warning(e);
      return Version.none;
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

  final Version _appVersion;

  final String _callkeepVersion;

  String get identifier => _identifier;

  Version get version => _appVersion;

  String get callkeepVersion => _callkeepVersion;
}
