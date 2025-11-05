import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_event.dart';

part 'settings_state.dart';

part 'settings_bloc.freezed.dart';

final _logger = Logger('SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.notificationsBloc,
    required this.appBloc,
    required this.userRepository,
    required this.voicemailRepository,
    required this.sessionRepository,
  }) : super(const SettingsState(progress: false)) {
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsAccountDeleted>(_onAccountDeleted, transformer: droppable());
    on<SettingsUnreadVoicemailCountChanged>(_onVoicemailCountChanged);

    _initializeVoicemailCountBadge();
  }

  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final UserRepository userRepository;
  final VoicemailRepository voicemailRepository;
  final SessionRepository sessionRepository;

  late final StreamSubscription<int> _unreadVoicemailsSub;

  void _initializeVoicemailCountBadge() {
    voicemailRepository.fetchVoicemails();
    _unreadVoicemailsSub = voicemailRepository.watchUnreadVoicemailsCount().listen((count) {
      add(SettingsUnreadVoicemailCountChanged(count));
    });
  }

  FutureOr<void> _onVoicemailCountChanged(
    SettingsUnreadVoicemailCountChanged event,
    Emitter<SettingsState> emit,
  ) {
    _logger.fine('Voicemail count changed: ${event.count}');
    if (state.unreadVoicemailCount != event.count) emit(state.copyWith(unreadVoicemailCount: event.count));
  }

  FutureOr<void> _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    await sessionRepository.logout();
  }

  FutureOr<void> _onAccountDeleted(SettingsAccountDeleted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.delete();

      await sessionRepository.logout();

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } catch (e, stackTrace) {
      _logger.warning('_onAccountDeleted', e, stackTrace);

      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
  }

  @override
  Future<void> close() {
    _unreadVoicemailsSub.cancel();
    return super.close();
  }
}
