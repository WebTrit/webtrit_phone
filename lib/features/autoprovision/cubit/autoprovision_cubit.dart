import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../models/models.dart';

part 'autoprovision_state.dart';

// TODO(Serdun + Vlad): Move exception text to localization resources for better maintainability.

final _logger = Logger('AutoprovisionCubit');

class AutoprovisionCubit extends Cubit<AutoprovisionState> with SystemInfoApiMapper {
  AutoprovisionCubit({required this.appInfo, required this.packageInfo, required this.config})
    : super(AutoprovisionState.initial());

  final AutoprovisionConfig config;
  final AppInfo appInfo;
  final PackageInfo packageInfo;

  String get _identifier => appInfo.identifier;

  String get _bundleId => packageInfo.packageName;

  WebtritApiClient _apiClient(String coreUrl, String tenantId) {
    return WebtritApiClient(Uri.parse(coreUrl), tenantId, connectionTimeout: kApiClientConnectionTimeout);
  }

  Future<WebtritSystemInfo> _retrieveSystemInfo(WebtritApiClient webtritApiClient) async {
    final apiSystemInfo = await webtritApiClient.getSystemInfo();
    final systemInfo = systemInfoFromApi(apiSystemInfo);
    return systemInfo;
  }

  Future<void> _processToken() async {
    _logger.info('processToken: starts');
    emit(AutoprovisionState.processing());

    final coreUrl = config.coreUrl ?? config.defaultCoreUrl;
    final oldCoreUrl = config.oldCoreUrl ?? config.defaultCoreUrl;

    final credentials = SessionAutoProvisionCredential(
      bundleId: _bundleId,
      type: PlatformInfo.appType,
      identifier: _identifier,
      configToken: config.configToken,
    );

    try {
      final apiClient = _apiClient(coreUrl, config.tenantId);

      final systemInfo = await _retrieveSystemInfo(apiClient);
      final coreInfo = systemInfo.core;
      final isCoreSupported = coreInfo.verifyVersionStr(config.coreVersionConstraint);

      if (isCoreSupported == false) {
        final notSupportedCoreException = Exception('Core version is not supported. Please update the core.');
        emit(AutoprovisionState.error(notSupportedCoreException));
        return;
      }

      final session = await apiClient.createSessionAutoProvision(credentials);
      final token = session.token;
      final userId = session.userId;
      final tenantId = session.tenantId ?? config.tenantId;

      if (userId == null) {
        final notSupportedCoreException = Exception(
          'User ID is required for proper auto provisioning. Please verify the core version.',
        );
        emit(AutoprovisionState.error(notSupportedCoreException));
        return;
      }

      if (config.oldToken != null) {
        await _apiClient(oldCoreUrl, config.oldTenantId).deleteSession(config.oldToken!).catchError((e) {
          _logger.warning('deleteSession error: $e');
        });
      }

      _logger.info('processToken success: $systemInfo, $session');
      emit(AutoprovisionState.sessionCreated(systemInfo, token, userId, coreUrl, tenantId));
    } catch (e) {
      _logger.warning('processToken error: $e');
      emit(AutoprovisionState.error(e));
    }
  }

  Future<void> confirmReplaceSession() {
    _logger.info('confirmReplaceSession');
    return _processToken();
  }

  void init() {
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
