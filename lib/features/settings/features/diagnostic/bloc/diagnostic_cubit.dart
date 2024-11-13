import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

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
    fetchPermissionsStatus();
    _onPushTokensChanged(pushTokensBloc.state);

    _pushTokensSubscription = pushTokensBloc.stream.listen(_onPushTokensChanged);
  }

  final AppPermissions _appPermissions;

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;

  void _onPushTokensChanged(PushTokensState pushTokens) {
    final pushToken = pushTokens.pushToken;
    final pushError = pushTokens.errorMessage;

    final pushTokenStatusType = pushToken != null
        ? PushTokenStatusType.success
        : pushError != null
            ? PushTokenStatusType.error
            : PushTokenStatusType.progress;

    emit(state.copyWith(
      pushTokenStatus: PushTokenStatus(
        token: pushToken,
        error: pushError,
        type: pushTokenStatusType,
      ),
    ));
  }

  Future<void> fetchPermissionsStatus() async {
    try {
      final permissions = await _fetchPermissionsStatus();
      emit(state.copyWith(permissions: permissions));
    } catch (e) {
      _logger.warning('fetchPermissionsStatus', e);
    }
  }

  Future<List<PermissionWithStatus>> _fetchPermissionsStatus() async {
    return await Future.wait<PermissionWithStatus>(
      _appPermissions.permissions.map<Future<PermissionWithStatus>>((Permission permission) async {
        final status = await permission.status;
        return PermissionWithStatus(permission, status);
      }),
    );
  }

  Future<void> handleRequestPermission(PermissionWithStatus permission) async {
    if (permission.status == PermissionStatus.denied) {
      await _requestAndUpdatePermission(permission);
    } else {
      await _openAppSettings();
    }
  }

  Future<void> _requestAndUpdatePermission(PermissionWithStatus permission) async {
    await permission.permission.request();
    fetchPermissionsStatus();
  }

  Future<void> _openAppSettings() async {
    await _appPermissions.toAppSettings();
  }

  @override
  Future<void> close() async {
    super.close();
    _pushTokensSubscription.cancel();
  }
}
