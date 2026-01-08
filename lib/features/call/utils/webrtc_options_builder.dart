import 'package:webtrit_phone/repositories/audio_processing_settings/audio_processing_settings_repository.dart';

/// Builds WebRTC initialization options.
abstract class WebrtcOptionsBuilder {
  Map<String, dynamic> build();
}

/// A builder class that constructs WebRTC options using application settings.
///
/// This class implements the [WebrtcOptionsBuilder] interface and provides
/// methods to build WebRTC options based on the application's settings.
class WebrtcOptionsWithAppSettingsBuilder implements WebrtcOptionsBuilder {
  WebrtcOptionsWithAppSettingsBuilder(this._audioProcessingSettingsRepository);

  final AudioProcessingSettingsRepository _audioProcessingSettingsRepository;

  @override
  Map<String, dynamic> build() {
    final settings = _audioProcessingSettingsRepository.getAudioProcessingSettings();
    final bypassVoiceProcessing = settings.bypassVoiceProcessing;

    return {if (bypassVoiceProcessing != null) 'bypassVoiceProcessing': bypassVoiceProcessing};
  }
}
