part of 'session_status_cubit.dart';

@freezed
class SessionStatusState with _$SessionStatusState {
  const SessionStatusState({this.status = const SessionStatus(signalingStatus: CallStatus.inProgress)});

  @override
  final SessionStatus status;
}
