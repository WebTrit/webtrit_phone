import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';

import '../models/models.dart';

part 'autoprovision_state.dart';

final _logger = Logger('AutoprovisionCubit');

class AutoprovisionCubit extends Cubit<AutoprovisionState> {
  AutoprovisionCubit(this.config) : super(AutoprovisionState.initial());

  final AutoprovisionConfig config;

  final _identifier = AppInfo().identifier;
  final _bundleId = PackageInfo().packageName;
  final _appType = PlatformInfo().appType;

  WebtritApiClient _apiClient(String coreUrl, String tenantId) {
    return WebtritApiClient(
      Uri.parse(coreUrl),
      tenantId,
      connectionTimeout: kApiClientConnectionTimeout,
    );
  }

  Future<void> _processToken() async {
    _logger.info('processToken: starts');
    emit(AutoprovisionState.processing());

    final coreUrl = config.coreUrl ?? config.defaultCoreUrl;
    final oldCoreUrl = config.oldCoreUrl ?? config.defaultCoreUrl;

    final credentials = SessionAutoProvisionCredential(
      bundleId: _bundleId,
      type: _appType,
      identifier: _identifier,
      configToken: config.configToken,
    );

    try {
      final result = await _apiClient(coreUrl, config.tenantId).createSessionAutoProvision(credentials);
      final token = result.token;
      final userId = result.userId;
      final tenantId = result.tenantId ?? config.tenantId;

      if (config.oldToken != null) {
        await _apiClient(oldCoreUrl, config.oldTenantId).deleteSession(config.oldToken!).catchError((e) {
          _logger.warning('deleteSession error: $e');
        });
      }

      _logger.info('processToken success: $token, $tenantId');
      emit(AutoprovisionState.sessionCreated(token, userId, coreUrl, tenantId));
    } catch (e) {
      _logger.warning('processToken error: $e');
      emit(AutoprovisionState.error(e));
    }
  }

  confirmReplaceSession() {
    _logger.info('confirmReplaceSession');
    return _processToken();
  }

  init() {
    _logger.info('init: $config');

    // Ask for confirmation if the user is logged-in without config_token exchange
    // to avoid closing the current session from signaling server without user consent.
    if (config.oldToken != null) {
      emit(AutoprovisionState.replaceConfirmationNeeded());
    } else {
      _processToken();
    }
  }
}
