import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'sessions_state.dart';

final _logger = Logger('SessionsCubit');

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit(this._sessionsRepository) : super(SessionsState());

  final SessionsRepository _sessionsRepository;

  Future<void> fetch() async {
    emit(state.copyWith(loading: true, failed: false));
    try {
      final sessions = await _sessionsRepository.getSessions();
      emit(state.copyWith(sessions: sessions, loading: false));
    } catch (e, stackTrace) {
      _logger.warning('fetch', e, stackTrace);
      emit(state.copyWith(loading: false, failed: true));
    }
  }

  /// Revokes [sessionId] and drops it from the list; returns whether it worked.
  Future<bool> revoke(String sessionId) async {
    emit(state.copyWith(revoking: {...state.revoking, sessionId}));
    final succeeded = await _revoke(sessionId);
    emit(state.copyWith(revoking: state.revoking.where((id) => id != sessionId).toSet()));
    return succeeded;
  }

  /// Revokes every session but the current one; returns false if any of them failed.
  ///
  /// The core has no bulk endpoint, so the sessions are revoked one by one and
  /// each successful one leaves the list on its own - a partial failure still
  /// shows what was actually revoked.
  Future<bool> revokeAllOthers() async {
    final targets = state.sessions.where((session) => !session.current).map((session) => session.id).toList();
    emit(state.copyWith(revoking: {...state.revoking, ...targets}));

    var allSucceeded = true;
    for (final sessionId in targets) {
      allSucceeded &= await _revoke(sessionId);
    }

    emit(state.copyWith(revoking: state.revoking.where((id) => !targets.contains(id)).toSet()));
    return allSucceeded;
  }

  Future<bool> _revoke(String sessionId) async {
    try {
      await _sessionsRepository.revokeSession(sessionId);
      emit(state.copyWith(sessions: state.sessions.where((session) => session.id != sessionId).toList()));
      return true;
    } catch (e, stackTrace) {
      _logger.warning('revoke $sessionId', e, stackTrace);
      return false;
    }
  }
}
