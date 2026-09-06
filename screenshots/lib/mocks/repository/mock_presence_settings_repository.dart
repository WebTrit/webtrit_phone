import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// In-memory settings store backing the real [PresenceSettingsCubit] in the
/// interactive presence preview, so edits made by clicking actually stick.
class MockPresenceSettingsRepository implements PresenceSettingsRepository {
  PresenceSettings _settings = PresenceSettings.blank(device: 'screenshot');
  DateTime? _lastSettingsSync;

  @override
  PresenceSettings get presenceSettings => _settings;

  @override
  void updatePresenceSettings(PresenceSettings settings) => _settings = settings;

  @override
  DateTime? get lastSettingsSync => _lastSettingsSync;

  @override
  void updateLastSettingsSync(DateTime time) => _lastSettingsSync = time;

  @override
  void resetLastSettingsSync() => _lastSettingsSync = null;

  @override
  Future<void> clear() async {
    _settings = PresenceSettings.blank(device: 'screenshot');
    _lastSettingsSync = null;
  }
}
