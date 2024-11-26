import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'app_bloc.freezed.dart';

part 'app_event.dart';

part 'app_state.dart';

final _logger = Logger('AppBloc');

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.appPreferences,
    required this.secureStorage,
    required this.appDatabase,
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
    required AppThemes appThemes,
  }) : super(AppState(
          coreUrl: secureStorage.readCoreUrl(),
          tenantId: secureStorage.readTenantId(),
          token: secureStorage.readToken(),
          userId: secureStorage.readUserId(),
          themeSettings: appThemes.values.first.settings,
          themeMode: appPreferences.getThemeMode(),
          locale: appPreferences.getLocale(),
          userAgreementAccepted: appPreferences.getUserAgreementAccepted(),
        )) {
    on<AppLogined>(_onLogined, transformer: sequential());
    on<AppLogouted>(_onLogouted, transformer: sequential());
    on<AppLogoutedTeardown>(_onLogoutedTeardown, transformer: sequential());
    on<AppThemeSettingsChanged>(_onThemeSettingsChanged, transformer: droppable());
    on<AppThemeModeChanged>(_onThemeModeChanged, transformer: droppable());
    on<AppLocaleChanged>(_onLocaleChanged, transformer: droppable());
    on<AppUserAgreementAccepted>(_onUserAgreementAccepted, transformer: droppable());
  }

  final AppPreferences appPreferences;
  final SecureStorage secureStorage;
  final AppDatabase appDatabase;
  final WebtritApiClientFactory createWebtritApiClient;

  Future<void> _cleanUpUserData() async {
    await appPreferences.clear();

    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
    await secureStorage.deleteUserId();

    await appDatabase.deleteEverything();
  }

  void _onLogined(AppLogined event, Emitter<AppState> emit) async {
    // Check if the user is re-logging in.
    // Example: logging in with a deeplink while already logged with another account.
    // In this case, clear the database and preferences.
    final isRelogin = state.token != null;
    if (isRelogin) await _cleanUpUserData();

    await secureStorage.writeCoreUrl(event.coreUrl);
    await secureStorage.writeTenantId(event.tenantId);
    await secureStorage.writeToken(event.token);
    await secureStorage.writeUserId(event.userId);

    emit(state.copyWith(
      coreUrl: event.coreUrl,
      tenantId: event.tenantId,
      token: event.token,
      userId: event.userId,
    ));
  }

  void _onLogouted(AppLogouted event, Emitter<AppState> emit) async {
    final token = state.token;
    final coreUrl = state.coreUrl;

    if (token != null && coreUrl != null && event.checkTokenForError) {
      try {
        final client = createWebtritApiClient(coreUrl, state.tenantId ?? '');
        await client.getUserInfo(token, options: const RequestOptions(retries: 0));
      } on RequestFailure catch (e) {
        final errorCode = AccountErrorCode.values.firstWhereOrNull((it) => it.value == e.error?.code);
        emit(state.copyWith(accountErrorCode: errorCode));
      } catch (e) {
        _logger.severe('_onLogouted', e);
      }
    }

    await _cleanUpUserData();

    emit(state.copyWith(coreUrl: null, tenantId: null, token: null, userId: null));
  }

  void _onLogoutedTeardown(AppLogoutedTeardown event, Emitter<AppState> emit) async {
    emit(state.copyWith(accountErrorCode: null));
  }

  void _onThemeSettingsChanged(AppThemeSettingsChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(themeSettings: event.value));
  }

  void _onThemeModeChanged(AppThemeModeChanged event, Emitter<AppState> emit) async {
    final themeMode = event.value;
    if (themeMode == ThemeMode.system) {
      await appPreferences.removeThemeMode();
    } else {
      await appPreferences.setThemeMode(themeMode);
    }
    emit(state.copyWith(themeMode: themeMode));
  }

  void _onLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) async {
    final locale = event.value;
    if (locale == LocaleExtension.defaultNull) {
      await appPreferences.removeLocale();
    } else {
      await appPreferences.setLocale(locale);
    }
    emit(state.copyWith(locale: locale));
  }

  void maybeHandleError(Object error) {
    if (error is RequestFailure) {
      if (error.statusCode == HttpStatus.unauthorized) {
        if (state.token != null && state.token == error.token) {
          add(const AppLogouted());
        }
      }
    }
  }

  void _onUserAgreementAccepted(AppUserAgreementAccepted event, Emitter<AppState> emit) async {
    await appPreferences.setUserAgreementAccepted(true);
    emit(state.copyWith(userAgreementAccepted: true));
  }
}
