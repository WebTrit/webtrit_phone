part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class MainStarted extends MainEvent {
  const MainStarted();
}

@Freezed(copyWith: false)
class MainCompatibilityVerified with _$MainCompatibilityVerified implements MainEvent {
  const factory MainCompatibilityVerified() = _MainCompatibilityVerified;
}

@Freezed(copyWith: false)
class MainAppUpdated with _$MainAppUpdated implements MainEvent {
  const factory MainAppUpdated(Uri storeViewUrl) = _MainAppUpdated;
}
