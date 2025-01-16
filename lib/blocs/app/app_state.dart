part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    String? coreUrl,
    String? tenantId,
    String? token,
    String? userId,
    AccountErrorCode? accountErrorCode,
    required ThemeSettings themeSettings,
    required ThemeMode themeMode,
    required Locale locale,
    required bool userAgreementAccepted,
    required bool contactsAgreementUnaccepted,
  }) = _AppState;

  bool get isThemeModeSupported => themeSettings.darkColorSchemeOverride != null;

  ThemeMode get effectiveThemeMode => isThemeModeSupported ? themeMode : ThemeMode.light;

  Locale? get effectiveLocale => locale == LocaleExtension.defaultNull ? null : locale;
}
