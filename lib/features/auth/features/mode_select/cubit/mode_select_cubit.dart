import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/auth/auth.dart';

part 'mode_select_state.dart';

part 'mode_select_cubit.freezed.dart';

class ModeSelectCubit extends Cubit<ModeSelectState> with SystemInfoMixin {
  ModeSelectCubit({
    @visibleForTesting WebtritApiClientFactory createWebtritApiClient = defaultCreateWebtritApiClient,
  })  : _createWebtritApiClient = createWebtritApiClient,
        super(ModeSelectState(
          url: EnvironmentConfig.CORE_URL == null ? EnvironmentConfig.DEMO_CORE_URL : EnvironmentConfig.CORE_URL!,
          demo: EnvironmentConfig.CORE_URL == null,
          defaultTenantId: EnvironmentConfig.DEFAULT_TENANT_ID,
        ));

  final WebtritApiClientFactory _createWebtritApiClient;

  void signUp() async {
    emit(state.copyWith(status: ModeSelectStatus.processing));
    try {
      await checkSystemInfo();
      emit(state.copyWith(status: ModeSelectStatus.ok));
      emit(state.copyWith(status: null));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: ModeSelectStatus.error,
        error: e,
      ));
    }
  }

  Future<void> checkSystemInfo() async {
    final client = _createWebtritApiClient(state.url, state.defaultTenantId);

    final systemInfo = await client.getSystemInfo();
    final supportedLogins = systemInfo.adapter?.commonSupported;

    emit(state.copyWith(
      supportedLogin: supportedLogins ?? [],
    ));

    verifyCoreVersion(systemInfo);
  }
}
