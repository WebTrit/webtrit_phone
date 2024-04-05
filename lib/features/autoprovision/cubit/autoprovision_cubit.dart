import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

part 'autoprovision_state.dart';

class AutoprovisionCubit extends Cubit<AutoprovisionState> {
  AutoprovisionCubit() : super(AutoprovisionState.initial());

  final _coreUrl = EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL;
  final _identifier = AppInfo().identifier;
  final _bundleId = PackageInfo().packageName;
  final _appType = PlatformInfo().appType;

  late final _apiClient = WebtritApiClient(Uri.parse(_coreUrl), '', connectionTimeout: kApiClientConnectionTimeout);

  Future<void> processToken(String configToken, bool loggedIn) async {
    emit(AutoprovisionState.processing(configToken));

    final credentials = SessionAutoProvisionCredential(
      bundleId: _bundleId,
      type: _appType,
      identifier: _identifier,
      configToken: configToken,
    );

    try {
      final result = await _apiClient.createSessionAutoProvision(credentials);
      final token = result.token;
      final tenantId = result.tenantId;

      if (loggedIn) {
        emit(AutoprovisionState.replaceConfirmationNeeded(token, _coreUrl, tenantId));
      } else {
        emit(AutoprovisionState.sessionCreated(token, _coreUrl, tenantId));
      }
    } catch (e) {
      emit(AutoprovisionState.error(e));
    }
  }

  Future<void> confirmReplaceSession() async {
    final state = this.state;
    if (state is! ReplaceConfirmationNeeded) return;

    final token = state.token;
    final coreUrl = state.coreUrl;
    final tenantId = state.tenantId;

    emit(AutoprovisionState.sessionCreated(token, coreUrl, tenantId));
  }
}
