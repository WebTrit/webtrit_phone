part of 'session_status_cubit.dart';

@freezed
class SessionStatusState with _$SessionStatusState {
  const SessionStatusState({
    this.status = SessionStatus.inProgress,
  });

  @override
  final SessionStatus status;
}
