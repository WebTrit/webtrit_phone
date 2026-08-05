import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_phone/data/app_preferences.dart';

/// Stores the user's on-device transcription model choice;
/// null means the app-config default is in effect.
abstract interface class TranscriptionModelRepository {
  LocalTranscriptionModel? getTranscriptionModel();

  Future<void> setTranscriptionModel(LocalTranscriptionModel? value);

  Future<void> clear();
}

class TranscriptionModelRepositoryPrefsImpl implements TranscriptionModelRepository {
  TranscriptionModelRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'transcription-model';

  @override
  LocalTranscriptionModel? getTranscriptionModel() {
    final raw = _appPreferences.getString(_prefsKey);
    return raw != null ? LocalTranscriptionModel.parse(raw) : null;
  }

  @override
  Future<void> setTranscriptionModel(LocalTranscriptionModel? value) {
    if (value != null) {
      return _appPreferences.setString(_prefsKey, value.toRawValue());
    } else {
      return clear();
    }
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
