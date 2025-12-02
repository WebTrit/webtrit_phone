part of 'session_status_cubit.dart';

@freezed
class SessionStatusState with _$SessionStatusState {
  const SessionStatusState({this.status = SessionStatus.inProgress, this.hasMicrophonePermission = false});

  @override
  final SessionStatus status;

  @override
  final bool hasMicrophonePermission;
}
