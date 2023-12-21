import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import '../types/auth_client.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.appPreferences,
    @visibleForTesting WebtritApiClientFactory createWebtritApiClient = defaultCreateWebtritApiClient,
  })  : _createWebtritApiClient = createWebtritApiClient,
        super(AuthState(
          url: EnvironmentConfig.DEMO_CORE_URL.isEmpty ? EnvironmentConfig.CORE_URL : EnvironmentConfig.DEMO_CORE_URL,
          demo: EnvironmentConfig.CORE_URL.isEmpty,
        ));

  final WebtritApiClientFactory _createWebtritApiClient;
  final AppPreferences appPreferences;

  void updateAuthCoreUrl(String url) {
    emit(state.copyWith(url: url));
  }

  Future<void> checkSystemInfo() async {
    final client = _createWebtritApiClient(state.url!, '');

    final systemInfo = await client.getSystemInfo();

    _verifyCoreVersion(systemInfo);
    _verifyLoginTypes(systemInfo);

    return;
  }

  void _verifyLoginTypes(SystemInfo systemInfo) {
    appPreferences.setSupportedLoginType(systemInfo.adapter?.commonSupported ?? []);
  }

  void _verifyCoreVersion(SystemInfo systemInfo) {
    final actualCoreVersion = systemInfo.core.version;
    CoreVersion.supported().verify(actualCoreVersion);
  }
}
