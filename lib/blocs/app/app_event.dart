part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

@Freezed(copyWith: false)
class AppLogined with _$AppLogined implements AppEvent {
  const factory AppLogined({
    required String coreUrl,
    required String tenantId,
    required String token,
    required String userId,
    required WebtritSystemInfo systemInfo,
  }) = _AppLogined;
}

@Freezed(copyWith: false)
class AppLogouted with _$AppLogouted implements AppEvent {
  const factory AppLogouted({
    @Default(false) bool checkTokenForError,
  }) = _AppLogouted;
}

@Freezed(copyWith: false)
class AppLogoutedTeardown with _$AppLogoutedTeardown implements AppEvent {
  const factory AppLogoutedTeardown() = _AppLogoutTeardown;
}

@Freezed(copyWith: false)
class AppThemeSettingsChanged with _$AppThemeSettingsChanged implements AppEvent {
  const factory AppThemeSettingsChanged(ThemeSettings value) = _AppThemeSettingsChanged;
}

@Freezed(copyWith: false)
class AppThemeModeChanged with _$AppThemeModeChanged implements AppEvent {
  const factory AppThemeModeChanged(ThemeMode value) = _AppThemeModeChanged;
}

@Freezed(copyWith: false)
class AppLocaleChanged with _$AppLocaleChanged implements AppEvent {
  const factory AppLocaleChanged(Locale value) = _AppLocaleChanged;
}

@Freezed(copyWith: false)
class AppAgreementAccepted with _$AppAgreementAccepted implements AppEvent {
  const factory AppAgreementAccepted.userAgreementAccepted() = _UserAppAgreementAccepted;

  const factory AppAgreementAccepted.contactsAgreementAccepted() = _ContactsAppAgreementAccepted;
}
