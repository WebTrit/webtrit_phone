import 'dart:async';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class PresenceInfoRepository {
  /// The current device presence settings.
  PresenceSettings get presenceSettings;

  /// Updates the current device presence settings.
  void updatePresenceSettings(PresenceSettings settings);

  /// Sets the presence information for a specific number.
  void setNumberPresence(String number, List<PresenceInfo> presenceInfo);

  /// The last time the presence settings were synchronized.
  /// Can be null if never synchronized.
  DateTime? get lastSettingsSync;

  /// Updates the last time the presence settings were synchronized.
  /// Typically set after a successful sync operation.
  void updateLastSettingsSync(DateTime time);

  /// Resets the last settings sync time to null.
  void resetLastSettingsSync();

  /// Gets the presence information for a specific number.
  List<PresenceInfo>? getNumberPresence(String number);

  /// Watches the presence information for a specific number.
  Stream<List<PresenceInfo>> watchNumberPresence(String number);
}

class PresenceInfoRepositoryDefaultImpl with PresenceSettingJsonMapperMixin implements PresenceInfoRepository {
  PresenceInfoRepositoryDefaultImpl(this.appPreferences);
  AppPreferences appPreferences;

  static const kPresenceSettingsKey = 'presence_settings1';
  final Map<String, List<PresenceInfo>> _numbersPresence = {};
  final _controller = StreamController<(String, List<PresenceInfo>)>.broadcast();
  DateTime? _lastSettingsSync;

  @override
  PresenceSettings get presenceSettings {
    final prefsResult = appPreferences.getString(kPresenceSettingsKey);
    if (prefsResult != null) {
      return presenceSettingsFromJson(prefsResult);
    } else {
      return PresenceSettings.blank();
    }
  }

  @override
  void updatePresenceSettings(PresenceSettings settings) {
    appPreferences.setString(kPresenceSettingsKey, presenceSettingsToJson(settings));
  }

  @override
  DateTime? get lastSettingsSync => _lastSettingsSync;

  @override
  void updateLastSettingsSync(DateTime time) => _lastSettingsSync = time;

  @override
  void resetLastSettingsSync() => _lastSettingsSync = null;

  @override
  void setNumberPresence(String number, List<PresenceInfo> presence) {
    _numbersPresence[number] = presence;
    _controller.add((number, presence));
  }

  @override
  List<PresenceInfo>? getNumberPresence(String number) => _numbersPresence[number];

  @override
  Stream<List<PresenceInfo>> watchNumberPresence(String number) async* {
    yield getNumberPresence(number) ?? [];
    yield* _controller.stream.where((e) => e.$1 == number).map((e) => e.$2);
  }
}
