part of 'microphone_status_bloc.dart';

@freezed
class MicrophoneStatusState with _$MicrophoneStatusState {
  const MicrophoneStatusState({
    this.microphonePermissionGranted,
  });

  @override
  final bool? microphonePermissionGranted;
}
