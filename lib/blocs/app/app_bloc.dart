import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/theme.dart';

part 'app_bloc.freezed.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.appPreferences,
    required this.secureStorage,
    required this.appDatabase,
    required AppThemes appThemes,
  }) : super(AppState(
          coreUrl: secureStorage.readCoreUrl(),
          tenantId: secureStorage.readTenantId(),
          token: secureStorage.readToken(),
          themeSettings: appThemes.values.first.settings,
          themeMode: appPreferences.getThemeMode(),
          locale: appPreferences.getLocale(),
        )) {
    on<AppLogined>(_onLogined, transformer: sequential());
    on<AppLogouted>(_onLogouted, transformer: sequential());
    on<AppThemeSettingsChanged>(_onThemeSettingsChanged, transformer: droppable());
    on<AppThemeModeChanged>(_onThemeModeChanged, transformer: droppable());
    on<AppLocaleChanged>(_onLocaleChanged, transformer: droppable());
  }

  final AppPreferences appPreferences;
  final SecureStorage secureStorage;
  final AppDatabase appDatabase;

  void _onLogined(AppLogined event, Emitter<AppState> emit) async {
    await secureStorage.writeCoreUrl(event.coreUrl);
    await secureStorage.writeTenantId(event.tenantId);
    await secureStorage.writeToken(event.token);

    emit(state.copyWith(
      coreUrl: event.coreUrl,
      tenantId: event.tenantId,
      token: event.token,
    ));
  }

  void _onLogouted(AppLogouted event, Emitter<AppState> emit) async {
    await appPreferences.clear();

    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();

    await appDatabase.deleteEverything();

    emit(state.copyWith(
      coreUrl: null,
      tenantId: null,
      token: null,
    ));
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
        add(const AppLogouted());
      }
    }
  }
}
