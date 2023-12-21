import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/models.dart';

part 'password_request_state.dart';

part 'password_request_cubit.freezed.dart';

class PasswordRequestCubit extends Cubit<PasswordRequestState> {
  PasswordRequestCubit(this.authCubit, {@visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient})
      : super(PasswordRequestState(
          coreUrl: authCubit.state.url!,
          tenantId: EnvironmentConfig.DEFAULT_PASSWORD_TYPE_LOGIN_TENANT,
        ));

  final WebtritApiClientFactory createWebtritApiClient;
  final AuthCubit authCubit;

  void loginCredentialRequestLoginInputChanged(String value) {
    emit(state.copyWith(
      loginInput: LoginInput.dirty(value),
    ));
  }

  void loginCredentialRequestPasswordInputChanged(String value) {
    emit(state.copyWith(
      passwordInput: PasswordInput.dirty(value),
    ));
  }

  void loginPasswordRequestSubmitted() async {
    emit(state.copyWith(
      status: PasswordRequestStatus.processing,
    ));

    try {
      var sessionToken = await createWebtritApiClient(
        state.coreUrl,
        state.tenantId,
      ).createSession(
        SessionLoginCredential(
          bundleId: PackageInfo().packageName,
          type: PlatformInfo().appType,
          identifier: AppInfo().identifier,
          login: state.loginInput.value,
          password: state.passwordInput.value,
        ),
      );

      emit(state.copyWith(
        token: sessionToken.token,
        status: PasswordRequestStatus.ok,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PasswordRequestStatus.error,
        error: e,
      ));
    }

    emit(state.copyWith(status: null, error: null));
  }
}
