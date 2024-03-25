import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

final _logger = Logger('SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.notificationsBloc,
    required this.appBloc,
    required this.userRepository,
    required this.appPreferences,
  }) : super(const SettingsState()) {
    on<SettingsRefreshed>(_onRefreshed, transformer: restartable());
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsAccountDeleted>(_onAccountDeleted, transformer: droppable());
  }

  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final UserRepository userRepository;
  final AppPreferences appPreferences;

  FutureOr<void> _onRefreshed(SettingsRefreshed event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      final info = await userRepository.getInfo();
      ;

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        info: info,
      ));
    } catch (e, stackTrace) {
      _logger.warning('_onRefreshed', e, stackTrace);

      notificationsBloc.add(NotificationsIssued(DefaultErrorNotification(e)));
      appBloc.maybeHandleError(e);

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
        info: null,
      ));
    }
  }

  FutureOr<void> _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.logout();

      appBloc.add(const AppLogouted());

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } catch (e, stackTrace) {
      _logger.warning('_onLogouted', e, stackTrace);

      if (event.force) {
        appBloc.add(const AppLogouted());
      } else {
        notificationsBloc.add(NotificationsIssued(DefaultErrorNotification(e)));
        appBloc.maybeHandleError(e);
      }

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
  }

  FutureOr<void> _onAccountDeleted(SettingsAccountDeleted event, Emitter<SettingsState> emit) async {
    // TODO: implement actual account deletion API call when it is introduced
    await _onLogouted(const SettingsLogouted(), emit);
  }
}
