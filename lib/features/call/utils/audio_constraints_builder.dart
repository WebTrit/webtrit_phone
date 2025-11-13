import 'package:webtrit_phone/repositories/audio_processing_settings/audio_processing_settings_repository.dart';

/// Builds WebRTC audio constraints for the call.
abstract class AudioConstraintsBuilder {
  Map<String, String> build();
}

/// A builder class that constructs audio constraints based on the application's settings.
///
/// This class implements the [AudioConstraintsBuilder] interface and provides
/// functionality to create audio constraints that are tailored to the specific
/// settings and requirements of the application.
class AudioConstraintsWithAppSettingsBuilder implements AudioConstraintsBuilder {
  AudioConstraintsWithAppSettingsBuilder(this._audioProcessingSettingsRepository);

  final AudioProcessingSettingsRepository _audioProcessingSettingsRepository;

  @override
  Map<String, String> build() {
    final settings = _audioProcessingSettingsRepository.getAudioProcessingSettings();
    final echoCancellation = settings.echoCancellation;
    final autoGainControl = settings.autoGainControl;
    final noiseSuppression = settings.noiseSuppression;
    final highpassFilter = settings.highpassFilter;
    final audioMirroring = settings.audioMirroring;

    return {
      if (echoCancellation != null) ...{
        'googEchoCancellation': echoCancellation.toString(),
        'googEchoCancellation2': echoCancellation.toString(),
        'googDAEchoCancellation': echoCancellation.toString(),
      },
      if (autoGainControl != null) 'googAutoGainControl': autoGainControl.toString(),
      if (noiseSuppression != null) 'googNoiseSuppression': noiseSuppression.toString(),
      if (highpassFilter != null) 'googHighpassFilter': highpassFilter.toString(),
      if (audioMirroring != null) 'googAudioMirroring': audioMirroring.toString(),
    };
  }
}
