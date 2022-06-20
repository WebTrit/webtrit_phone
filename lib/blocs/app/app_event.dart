part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

@Freezed(copyWith: false)
class AppLogined with _$AppLogined implements AppEvent {
  const factory AppLogined({
    required String coreUrl,
    required String token,
  }) = _AppLogined;
}

@Freezed(copyWith: false)
class AppLogouted with _$AppLogouted implements AppEvent {
  const factory AppLogouted() = _AppLogouted;
}
