import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/app_permissions.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/crashlytics_utils.dart';

part 'settings_event.dart';

part 'settings_state.dart';

part 'settings_bloc.freezed.dart';

final _logger = Logger('SettingsBloc');

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.notificationsBloc,
    required this.appBloc,
    required this.userRepository,
    required this.sessionRepository,
    required this.appPermissions,
  }) : super(const SettingsState(progress: false)) {
    on<SettingsLogouted>(_onLogouted, transformer: droppable());
    on<SettingsAccountDeleted>(_onAccountDeleted, transformer: droppable());
  }

  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final UserRepository userRepository;
  final SessionRepository sessionRepository;
  final AppPermissions appPermissions;

  FutureOr<void> _onLogouted(SettingsLogouted event, Emitter<SettingsState> emit) async {
    appBloc.add(const AppLogoutRequested());
  }

  FutureOr<void> _onAccountDeleted(SettingsAccountDeleted event, Emitter<SettingsState> emit) async {
    if (state.progress) return;

    emit(state.copyWith(progress: true));
    try {
      await userRepository.deleteRemote();

      appBloc.add(const AppLogoutRequested());
      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    } on EndpointNotSupportedException catch (e, s) {
      _logger.warning('_onAccountDeleted: endpoint not supported', e, s);
      notificationsBloc.add(NotificationsSubmitted(const DeleteAccountNotSupportedNotification()));

      if (emit.isDone) return;
      emit(state.copyWith(progress: false));
    } catch (e, s) {
      _logger.severe('_onAccountDeleted', e, s);
      CrashlyticsUtils.recordError(e, stack: s, reason: 'SettingsBloc._onAccountDeleted');

      appBloc.maybeHandleError(e);
      if (emit.isDone) return;
      emit(state.copyWith(progress: false));
    }
  }
}
