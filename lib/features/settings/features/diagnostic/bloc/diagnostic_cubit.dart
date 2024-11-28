import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/app_permissions.dart';
import 'package:webtrit_phone/features/features.dart';

import '../models/models.dart';

part 'diagnostic_state.dart';

part 'diagnostic_cubit.freezed.dart';

final _logger = Logger('DiagnosticCubit');

class DiagnosticCubit extends Cubit<DiagnosticState> {
  DiagnosticCubit({
    required PushTokensBloc pushTokensBloc,
    required AppPermissions appPermissions,
  })  : _appPermissions = appPermissions,
        super(const DiagnosticState()) {
    fetchStatuses();
    _onPushTokensChanged(pushTokensBloc.state);

    _pushTokensSubscription = pushTokensBloc.stream.listen(_onPushTokensChanged);
  }

  final AppPermissions _appPermissions;

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;

  void _onPushTokensChanged(PushTokensState pushTokens) {
    final pushToken = pushTokens.pushToken;
    final pushError = pushTokens.errorMessage;

    emit(state.copyWith(
      pushTokenStatus: PushTokenStatus(
        token: pushToken,
        error: pushError,
        type: pushToken != null
            ? PushTokenStatusType.success
            : pushError != null
                ? PushTokenStatusType.error
                : PushTokenStatusType.progress,
      ),
    ));
  }

  Future<void> fetchStatuses() async {
    await _fetchPermissionsStatus();
    await _fetchBatteryModeStatus();
  }

  Future<void> _fetchPermissionsStatus() async {
    try {
      final permissions = await Future.wait<PermissionWithStatus>(
        _appPermissions.permissions.map<Future<PermissionWithStatus>>((Permission permission) async {
          final status = await permission.status;
          return PermissionWithStatus(permission, status);
        }),
      );
      emit(state.copyWith(permissions: permissions));
    } catch (e) {
      _logger.warning('fetchPermissionsStatus', e);
    }
  }

  Future<void> _fetchBatteryModeStatus() async {
    try {
      final status = await WebtritCallkeepPermissions().getBatteryMode();
      emit(state.copyWith(batteryMode: status));
    } catch (e) {
      _logger.warning('fetchPermissionsStatus', e);
    }
  }

  Future<void> handleRequestPermission(PermissionWithStatus permission) async {
    if (permission.status == PermissionStatus.denied) {
      await _requestAndUpdatePermission(permission);
    } else {
      await openAppSettings();
    }
  }

  Future<void> _requestAndUpdatePermission(PermissionWithStatus permission) async {
    await permission.permission.request();
    _fetchPermissionsStatus();
  }

  Future<void> openAppSettings() async {
    await _appPermissions.toAppSettings();
  }

  @override
  Future<void> close() async {
    super.close();
    _pushTokensSubscription.cancel();
  }
}
