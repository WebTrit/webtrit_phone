part of 'main_bloc.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    Object? error,
    Uri? updateStoreViewUrl,
  }) = _MainState;
}
