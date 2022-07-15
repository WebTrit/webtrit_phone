part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    String? coreUrl,
    String? token,
    String? webRegistrationInitialUrl,
    required ThemeSettings themeSettings,
    required ThemeMode themeMode,
    required Locale locale,
  }) = _AppState;

  Locale? get effectiveLocale => locale == LocaleExtension.defaultNull ? null : locale;
}
