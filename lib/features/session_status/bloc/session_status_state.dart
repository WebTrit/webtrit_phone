part of 'session_status_cubit.dart';

@freezed
class SessionStatusState with _$SessionStatusState {
  const factory SessionStatusState.initial({
    @Default(SessionStatus.inProgress) SessionStatus status,
  }) = _Initial;
}
