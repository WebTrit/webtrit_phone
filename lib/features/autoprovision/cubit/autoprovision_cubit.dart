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

      if (_oldToken != null) {
        await _apiClient(_oldTenantId).deleteSession(_oldToken).catchError((e) {
          _logger.warning('deleteSession error: $e');
        });
      }

      _logger.info('processToken success: $token, $tenantId');
      emit(AutoprovisionState.sessionCreated(token, _coreUrl, tenantId));
    } on Exception catch (e) {
      _logger.warning('processToken error: $e');
      emit(AutoprovisionState.error(e));
    }
  }

  confirmReplaceSession() {
    _logger.info('confirmReplaceSession');
    return _processToken();
  }

  init() {
    _logger.info('init: $_configToken, $_tenantId, $_oldToken, $_oldTenantId');

    // Ask for confirmation if the user is logged-in without config_token exchange
    // to avoid closing the current session from signaling server without user consent.
    if (_oldToken != null) {
      emit(AutoprovisionState.replaceConfirmationNeeded());
    } else {
      _processToken();
    }
  }
}
