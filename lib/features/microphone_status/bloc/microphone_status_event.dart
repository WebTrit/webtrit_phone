part of 'microphone_status_bloc.dart';

sealed class MicrophoneStatusEvent extends Equatable {
  const MicrophoneStatusEvent();

  @override
  List<Object?> get props => [];
}

class MicrophoneStatusStarted extends MicrophoneStatusEvent {
  const MicrophoneStatusStarted();
}
