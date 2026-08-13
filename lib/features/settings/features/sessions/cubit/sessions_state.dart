part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  SessionsState({this.sessions = const [], this.loading = false, this.revoking = const {}, this.failed = false});

  final List<ActiveSession> sessions;

  late final ActiveSession currentSession = sessions.firstWhere((session) => session.current);

  late final List<ActiveSession> otherSessions = sessions.where((session) => !session.current).toList();

  late final List<ActiveSession> sessionsStartedFromCurrent = [currentSession, ...otherSessions];

  /// True while the list is being fetched.
  final bool loading;

  /// Identifiers of the sessions whose revoke request is in flight.
  final Set<String> revoking;

  /// True when the last fetch failed; the sessions already loaded are kept.
  final bool failed;

  bool get hasOtherSessions => sessions.any((session) => !session.current);

  bool isRevoking(String sessionId) => revoking.contains(sessionId);

  @override
  List<Object?> get props => [sessions, loading, revoking, failed];

  @override
  bool get stringify => true;

  SessionsState copyWith({List<ActiveSession>? sessions, bool? loading, Set<String>? revoking, bool? failed}) {
    return SessionsState(
      sessions: sessions ?? this.sessions,
      loading: loading ?? this.loading,
      revoking: revoking ?? this.revoking,
      failed: failed ?? this.failed,
    );
  }
}
