import 'package:webtrit_phone/data/app_preferences.dart';

/// Builds WebRTC initialization options.
abstract class WebrtcOptionsBuilder {
  Map<String, dynamic> build();
}

/// A builder class that constructs WebRTC options using application settings.
///
/// This class implements the [WebrtcOptionsBuilder] interface and provides
/// methods to build WebRTC options based on the application's settings.
class WebrtcOptionsWithAppSettingsBuilder implements WebrtcOptionsBuilder {
  WebrtcOptionsWithAppSettingsBuilder(this._prefs);

  final AppPreferences _prefs;

  @override
  Map<String, dynamic> build() {
    final settings = _prefs.getAudioProcessingSettings();
    final bypassVoiceProcessing = settings.bypassVoiceProcessing;

    return {if (bypassVoiceProcessing != null) 'bypassVoiceProcessing': bypassVoiceProcessing};
  }
}
