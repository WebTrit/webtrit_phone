import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

part 'autoprovision_state.dart';

final _logger = Logger('AutoprovisionCubit');

class AutoprovisionCubit extends Cubit<AutoprovisionState> {
  AutoprovisionCubit(
    this._configToken,
    this._tenantId,
    this._oldToken,
    this._oldTenantId,
  ) : super(AutoprovisionState.initial());

  final String _configToken;
  final String _tenantId;
  final String? _oldToken;
  final String _oldTenantId;

  final _coreUrl = EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL;
  final _identifier = AppInfo().identifier;
  final _bundleId = PackageInfo().packageName;
  final _appType = PlatformInfo().appType;

  WebtritApiClient _apiClient(String tenantId) {
    return WebtritApiClient(
      Uri.parse(_coreUrl),
      tenantId,
      connectionTimeout: kApiClientConnectionTimeout,
    );
  }

  Future<void> _processToken() async {
    _logger.info('processToken: starts');
    emit(AutoprovisionState.processing());

    final credentials = SessionAutoProvisionCredential(
      bundleId: _bundleId,
      type: _appType,
      identifier: _identifier,
      configToken: _configToken,
    );

    try {
      final result = await _apiClient(_tenantId).createSessionAutoProvision(credentials);
      final token = result.token;
      final tenantId = result.tenantId ?? _tenantId;
      _logger.info('processToken success: $token, $tenantId');

      if (_oldToken == null) {
        emit(AutoprovisionState.sessionCreated(token, _coreUrl, tenantId));
      } else {
        emit(AutoprovisionState.replaceConfirmationNeeded(token, _coreUrl, tenantId));
      }
    } catch (e) {
      _logger.warning('processToken error: $e');
      emit(AutoprovisionState.error(e));
    }
  }

  confirmReplaceSession() async {
    _logger.info('confirmReplaceSession: starts');

    final state = this.state;
    if (state is! ReplaceConfirmationNeeded) return;
    if (_oldToken == null) return;

    try {
      await _apiClient(_oldTenantId).deleteSession(_oldToken);
      _logger.info('confirmReplaceSession: success');
      emit(AutoprovisionState.sessionCreated(state.token, state.coreUrl, state.tenantId));
    } catch (e) {
      _logger.warning('confirmReplaceSession error: $e');
      emit(AutoprovisionState.error(e));
    }
  }

  init() {
    _logger.info('init: $_configToken, $_tenantId, $_oldToken, $_oldTenantId');
    _processToken();
  }
}
