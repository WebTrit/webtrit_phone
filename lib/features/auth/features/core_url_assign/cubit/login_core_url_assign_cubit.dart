import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/models.dart';

part 'login_core_url_assign_state.dart';

part 'login_core_url_assign_cubit.freezed.dart';

class LoginCoreUrlAssignCubit extends Cubit<LoginCoreUrlAssignState> with SystemInfoMixin {
  // Do not take the tenant ID from the environment as in this case the tenant ID might be provided from the input field.
  LoginCoreUrlAssignCubit({
    @visibleForTesting WebtritApiClientFactory createWebtritApiClient = defaultCreateWebtritApiClient,
  })  : _createWebtritApiClient = createWebtritApiClient,
        super(const LoginCoreUrlAssignState(defaultTenantId: ''));

  final WebtritApiClientFactory _createWebtritApiClient;

  void loginCoreUrlAssignCoreUrlInputChanged(String value) {
    emit(state.copyWith(
      status: null,
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    if (!state.coreUrlInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: LoginCoreStatus.processing,
    ));

    try {
      await checkSystemInfo();
      emit(state.copyWith(status: LoginCoreStatus.ok));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: LoginCoreStatus.error,
        error: e,
      ));
      emit(state.copyWith(status: null, error: null));
    }
  }

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> checkSystemInfo() async {
    final client = _createWebtritApiClient(state.normalizeUrl, state.defaultTenantId);

    final systemInfo = await client.getSystemInfo();
    final supportedLogins = systemInfo.adapter?.commonSupported;

    emit(state.copyWith(
      supportedLogin: supportedLogins ?? [],
    ));

    verifyCoreVersion(systemInfo);
  }
}
