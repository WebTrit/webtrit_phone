import 'package:webtrit_phone/data/app_preferences.dart';

/// Stores the user's on-device transcription model choice;
/// null means the app-config default tier is in effect.
abstract interface class TranscriptionModelRepository {
  String? getTranscriptionModel();

  Future<void> setTranscriptionModel(String? value);

  Future<void> clear();
}

class TranscriptionModelRepositoryPrefsImpl implements TranscriptionModelRepository {
  TranscriptionModelRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'transcription-model';

  @override
  String? getTranscriptionModel() => _appPreferences.getString(_prefsKey);

  @override
  Future<void> setTranscriptionModel(String? value) {
    if (value != null) {
      return _appPreferences.setString(_prefsKey, value);
    } else {
      return clear();
    }
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
