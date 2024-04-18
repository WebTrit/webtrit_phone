import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

part 'autoprovision_state.dart';

class AutoprovisionCubit extends Cubit<AutoprovisionState> {
  AutoprovisionCubit(this._configToken, this._tenantId, this._loggedIn) : super(AutoprovisionState.initial());

  final String _configToken;
  final String _tenantId;
  final bool _loggedIn;

  final _coreUrl = EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL;
  final _identifier = AppInfo().identifier;
  final _bundleId = PackageInfo().packageName;
  final _appType = PlatformInfo().appType;

  late final _apiClient = WebtritApiClient(
    Uri.parse(_coreUrl),
    _tenantId,
    connectionTimeout: kApiClientConnectionTimeout,
  );

  Future<void> _processToken() async {
    emit(AutoprovisionState.processing());

    final credentials = SessionAutoProvisionCredential(
      bundleId: _bundleId,
      type: _appType,
      identifier: _identifier,
      configToken: _configToken,
    );

    try {
      final apiClient = _apiClient;
      final result = await apiClient.createSessionAutoProvision(credentials);
      final token = result.token;
      final tenantId = result.tenantId ?? _tenantId;

      emit(AutoprovisionState.sessionCreated(token, _coreUrl, tenantId));
    } catch (e) {
      emit(AutoprovisionState.error(e));
    }
  }

  confirmReplaceSession() => _processToken();

  init() {
    // Ask for confirmation if the user is logged-in without config_token exchange
    // to avoid closing the current session from signaling server without user consent.
    if (_loggedIn) {
      emit(AutoprovisionState.replaceConfirmationNeeded());
    } else {
      _processToken();
    }
  }
}
