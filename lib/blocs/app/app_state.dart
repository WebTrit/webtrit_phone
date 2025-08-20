part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(Session()) Session session,
    required ThemeSettings themeSettings,
    required ThemeMode themeMode,
    required Locale locale,
    required AgreementStatus userAgreementStatus,
    required AgreementStatus contactsAgreementStatus,
  }) = _AppState;

  bool get isThemeModeSupported => themeSettings.lightColorSchemeConfig != themeSettings.darkColorSchemeConfig;

  ThemeMode get effectiveThemeMode => isThemeModeSupported ? themeMode : ThemeMode.light;

  Locale? get effectiveLocale => locale == LocaleExtension.defaultNull ? null : locale;
}
