import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';

abstract interface class EncodingPresetRepository {
  EncodingPreset? getEncodingPreset({EncodingPreset? defaultValue});

  Future<void> setEncodingPreset(EncodingPreset? value);

  Future<void> clear();
}

class EncodingPresetRepositoryPrefsImpl implements EncodingPresetRepository {
  EncodingPresetRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'encoding-preset';

  @override
  EncodingPreset? getEncodingPreset({EncodingPreset? defaultValue}) {
    final encodingPresetString = _appPreferences.getString(_prefsKey);

    EncodingPreset? preset;
    if (encodingPresetString != null) {
      preset = EncodingPreset.values.firstWhereOrNull((preset) => preset.name == encodingPresetString);
    }
    return preset ?? defaultValue;
  }

  @override
  Future<void> setEncodingPreset(EncodingPreset? value) {
    if (value != null) {
      return _appPreferences.setString(_prefsKey, value.name);
    } else {
      return clear();
    }
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
