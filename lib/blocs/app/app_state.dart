part of 'app_bloc.dart';

enum AppLifecycleStatus { unauthenticated, authenticated, teardown }

@freezed
sealed class AppState with _$AppState {
  const factory AppState({
    @Default(AppLifecycleStatus.unauthenticated) AppLifecycleStatus status,
    @Default(null) AppLogoutReason? logoutReason,
    @Default(Session()) Session session,
    required ThemeSettings themeSettings,
    required ThemeMode themeMode,
    required Locale locale,
    required AgreementStatus userAgreementStatus,
    required AgreementStatus contactsAgreementStatus,
  }) = _AppState;

  const AppState._();

  bool get isThemeModeSupported => themeSettings.lightColorSchemeConfig != themeSettings.darkColorSchemeConfig;

  ThemeMode get effectiveThemeMode => isThemeModeSupported ? themeMode : ThemeMode.light;

  Locale? get effectiveLocale => locale == LocaleExtension.defaultNull ? null : locale;
}
