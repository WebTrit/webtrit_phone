import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

typedef WebtritApiClientFactory = WebtritApiClient Function(String coreUrl, String tenantId);

WebtritApiClient defaultCreateWebtritApiClient(String coreUrl, String tenantId) {
  return WebtritApiClient(Uri.parse(coreUrl), tenantId, connectionTimeout: kApiClientConnectionTimeout);
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(const LoginState());

  final WebtritApiClientFactory createWebtritApiClient;

  String? get coreUrlFromEnvironment => EnvironmentConfig.CORE_URL;

  String? get demoCoreUrlFromEnvironment => EnvironmentConfig.DEMO_CORE_URL;

  String get defaultTenantId => '';

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

  void dismissError() {
    emit(state.copyWith(
      error: null,
    ));
  }

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // LoginModeSelectTab

  void loginModeSelectSubmitter(bool demo) async {
    emit(state.copyWith(
      demo: demo,
    ));

    final coreUrl = demo ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment;
    final tenantId = defaultTenantId;

    if (coreUrl != null) {
      emit(state.copyWith(
        processing: true,
      ));
      try {
        final client = createWebtritApiClient(coreUrl, tenantId);
        await _verifyCoreVersion(client);
        emit(state.copyWith(
          processing: false,
          coreUrl: coreUrl,
          tenantId: tenantId,
        ));
      } catch (e) {
        emit(state.copyWith(
          processing: false,
          error: e,
        ));
      }
    }
  }

  // LoginCoreUrlAssignTab

  void loginCoreUrlAssignCoreUrlInputChanged(String value) {
    emit(state.copyWith(
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    if (state.processing || !state.coreUrlInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    var coreUrlInputValue = state.coreUrlInput.value;
    if (!coreUrlInputValue.startsWith(RegExp(r'(https|http)://'))) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }
    final tenantId = defaultTenantId;
    try {
      final client = createWebtritApiClient(coreUrlInputValue, tenantId);
      await _verifyCoreVersion(client);
      emit(state.copyWith(
        processing: false,
        coreUrl: coreUrlInputValue,
        tenantId: tenantId,
      ));
    } catch (e) {
      emit(state.copyWith(
        processing: false,
        error: e,
      ));
    }
  }

  void loginCoreUrlAssignBack() async {
    emit(state.copyWith(
      demo: null,
      coreUrlInput: const UrlInput.pure(),
    ));
  }

  // LoginOtpRequestTab

  void loginOptRequestEmailInputChanged(String value) {
    emit(state.copyWith(
      emailInput: EmailInput.dirty(value),
    ));
  }

  void loginOptRequestPhoneInputChanged(String value) {
    emit(state.copyWith(
      phoneInput: PhoneInput.dirty(value),
    ));
  }

  void loginOptRequestSubmitted() async {
    if (state.processing || !(state.demo! ? state.emailInput.isValid : state.phoneInput.isValid)) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));
    try {
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      if (state.demo!) {
        result = await _createUserRequest(client, state.emailInput.value);
      } else {
        result = await _sessionOtpRequest(client, state.phoneInput.value);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          processing: false,
          sessionOtpProvisional: result,
        ));
      } else if (result is SessionToken) {
        // TODO: Add logic for navigate authorized user
        throw UnimplementedError();
      } else {
        // TODO: Add logic for navigate to undefine page
        throw UnimplementedError();
      }
    } catch (e) {
      emit(state.copyWith(
        processing: false,
        error: e,
      ));
    }
  }

  void loginOptRequestBack() async {
    emit(state.copyWith(
      coreUrl: null,
      tenantId: null,
      emailInput: const EmailInput.pure(),
      phoneInput: const PhoneInput.pure(),
    ));
  }

  // LoginOtpVerifyTab

  void loginOptVerifyCodeInputChanged(String value) {
    emit(state.copyWith(
      codeInput: CodeInput.dirty(value),
    ));
  }

  void loginOptVerifySubmitted() async {
    if (state.processing || !state.codeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));
    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionToken = await _sessionOtpVerify(client, state.sessionOtpProvisional!, state.codeInput.value);

      // does not set processing to false to hold processing widgets state during navigation
      emit(state.copyWith(
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
      ));
    } catch (e) {
      emit(state.copyWith(
        processing: false,
        error: e,
      ));
    }
  }

  void loginOptVerifyBack() async {
    emit(state.copyWith(
      sessionOtpProvisional: null,
      codeInput: const CodeInput.pure(),
    ));
  }

  void loginOptVerifyRepeat() async {
    if (state.processing) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    // TODO: Part of duplicate code with method loginOptRequestSubmitted
    try {
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      if (state.demo!) {
        result = await _createUserRequest(client, state.emailInput.value);
      } else {
        result = await _sessionOtpRequest(client, state.phoneInput.value);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          processing: false,
          sessionOtpProvisional: result,
        ));
      } else if (result is SessionToken) {
        // TODO: Add logic for navigate authorized user
        throw UnimplementedError();
      } else {
        // TODO: Add logic for navigate to undefine page
        throw UnimplementedError();
      }
    } catch (e) {
      emit(state.copyWith(
        processing: false,
        error: e,
      ));
    }
  }
}

Future<void> _verifyCoreVersion(
  WebtritApiClient webtritApiClient,
) async {
  final actualCoreVersion = (await webtritApiClient.getSystemInfo()).core.version;
  CoreVersion.supported().verify(actualCoreVersion);
}

Future<SessionResult> _createUserRequest(
  WebtritApiClient webtritApiClient,
  String email,
) async {
  return await webtritApiClient.createUser(SessionUserCredential(
    bundleId: PackageInfo().packageName,
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    email: email,
  ));
}

Future<SessionOtpProvisional> _sessionOtpRequest(
  WebtritApiClient webtritApiClient,
  String phone,
) async {
  return await webtritApiClient.createSessionOtp(SessionOtpCredential(
    bundleId: PackageInfo().packageName,
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    userRef: phone,
  ));
}

Future<SessionToken> _sessionOtpVerify(
  WebtritApiClient webtritApiClient,
  SessionOtpProvisional sessionOtpProvisional,
  String code,
) async {
  return await webtritApiClient.verifySessionOtp(sessionOtpProvisional, code);
}
