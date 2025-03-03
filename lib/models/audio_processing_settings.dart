import 'package:equatable/equatable.dart';

class AudioProcessingSettings extends Equatable {
  const AudioProcessingSettings({
    this.bypassVoiceProcessing,
    this.echoCancellation,
    this.autoGainControl,
    this.noiseSuppression,
    this.highpassFilter,
    this.audioMirroring,
  });

  final bool? bypassVoiceProcessing;
  final bool? echoCancellation;
  final bool? autoGainControl;
  final bool? noiseSuppression;
  final bool? highpassFilter;
  final bool? audioMirroring;

  @override
  List<Object?> get props =>
      [bypassVoiceProcessing, echoCancellation, autoGainControl, noiseSuppression, highpassFilter, audioMirroring];

  @override
  String toString() {
    return 'AudioProcessingSettings{bypassVoiceProcessing: $bypassVoiceProcessing, echoCancellation: $echoCancellation, autoGainControl: $autoGainControl, noiseSuppression: $noiseSuppression, highpassFilter: $highpassFilter, audioMirroring: $audioMirroring}';
  }

  factory AudioProcessingSettings.blank() => const AudioProcessingSettings();

  AudioProcessingSettings copyWithBypassVoiceProcessing(bool? bypassVoiceProcessing) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }

  AudioProcessingSettings copyWithEchoCancellation(bool? echoCancellation) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }

  AudioProcessingSettings copyWithAutoGainControl(bool? autoGainControl) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }

  AudioProcessingSettings copyWithNoiseSuppression(bool? noiseSuppression) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }

  AudioProcessingSettings copyWithHighpassFilter(bool? highpassFilter) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }

  AudioProcessingSettings copyWithAudioMirroring(bool? audioMirroring) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: bypassVoiceProcessing,
      echoCancellation: echoCancellation,
      autoGainControl: autoGainControl,
      noiseSuppression: noiseSuppression,
      highpassFilter: highpassFilter,
      audioMirroring: audioMirroring,
    );
  }
}
