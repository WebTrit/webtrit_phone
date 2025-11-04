part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const AppState({
    this.session = const Session(),
    required this.themeSettings,
    required this.themeMode,
    required this.locale,
    required this.userAgreementStatus,
    required this.contactsAgreementStatus,
  });

  @override
  final Session session;

  @override
  final ThemeSettings themeSettings;

  @override
  final ThemeMode themeMode;

  @override
  final Locale locale;

  @override
  final AgreementStatus userAgreementStatus;

  @override
  final AgreementStatus contactsAgreementStatus;

  bool get isThemeModeSupported => themeSettings.lightColorSchemeConfig != themeSettings.darkColorSchemeConfig;

  ThemeMode get effectiveThemeMode => isThemeModeSupported ? themeMode : ThemeMode.light;

  Locale? get effectiveLocale => locale == LocaleExtension.defaultNull ? null : locale;
}
