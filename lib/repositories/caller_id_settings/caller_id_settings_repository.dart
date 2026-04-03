import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('CallerIdSettingsRepository');

abstract interface class CallerIdSettingsRepository {
  CallerIdSettings getCallerIdSettings();

  Future<void> setCallerIdSettings(CallerIdSettings settings);

  Future<void> clear();
}

class CallerIdSettingsRepositoryPrefsImpl with CallerIdSettingsJsonMapper implements CallerIdSettingsRepository {
  CallerIdSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'caller-id-settings';

  @override
  CallerIdSettings getCallerIdSettings() {
    final callerIdSettingsString = _appPreferences.getString(_prefsKey);
    if (callerIdSettingsString == null) return const CallerIdSettings();
    return callerIdSettingsFromJson(callerIdSettingsString);
  }

  @override
  Future<void> setCallerIdSettings(CallerIdSettings settings) {
    return _appPreferences.setString(_prefsKey, callerIdSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}

class CallerIdSettingsRepositoryRemoteImpl
    with CallerIdSettingsApiMapper
    implements CallerIdSettingsRepository, Refreshable {
  CallerIdSettingsRepositoryRemoteImpl(this._apiClient, this.token);

  final api.WebtritApiClient _apiClient;
  final String token;
  SyncableCallerIdSettings? _cachedSettings;

  @override
  CallerIdSettings getCallerIdSettings() {
    return _cachedSettings?.$1 ?? const CallerIdSettings();
  }

  @override
  Future<void> setCallerIdSettings(CallerIdSettings newSettings) async {
    final newMetadata = SettingsSyncMetadata(
      version: _cachedSettings?.$2.version ?? 0,
      modifiedAt: DateTime.now(),
      dirty: true,
    );
    _cachedSettings = (newSettings, newMetadata);
    await sync();
  }

  Future<void> sync() async {
    final SyncableCallerIdSettings? cachedSettings = _cachedSettings;

    try {
      if (cachedSettings == null || cachedSettings.$2.dirty == false) {
        final remoteSettings = await _apiClient.getCallerIdSettings(token);
        _cachedSettings = syncableCallerIdSettingsFromApi(remoteSettings);
        _logger.finer('Pulled remote, ver: ${remoteSettings.version}, from: ${remoteSettings.modifiedAt}');
      } else if (cachedSettings.$2.dirty == true) {
        final (CallerIdSettings callerIdSettings, SettingsSyncMetadata metadata) = cachedSettings;
        _logger.info('Syncin dirty settings, ver: ${metadata.version}, from: ${metadata.modifiedAt}');

        final result = await _apiClient.updateCallerIdSettings(token, syncableCallerIdSettingsToApi(cachedSettings));
        _cachedSettings = syncableCallerIdSettingsFromApi(result);
        _logger.info('Synced, new ver: ${result.version}, from: ${result.modifiedAt}');
      }
    } catch (e, s) {
      _logger.warning('Error syncing caller ID settings', e, s);
    }
  }

  @override
  @override
  bool get isActive => true;

  @override
  Future<void> refresh() => sync();

  @override
  Future<void> clear() async => _cachedSettings = null;
}
