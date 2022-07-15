part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    String? coreUrl,
    String? token,
    String? webRegistrationInitialUrl,
    required ThemeSettings themeSettings,
  }) = _AppState;
}
