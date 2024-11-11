part of 'push_tokens_bloc.dart';

enum PushTokensStateType {
  initial,
  uploadSuccess,
  uploadFailure,
}

@freezed
class PushTokensState with _$PushTokensState {
  const factory PushTokensState({
    required PushTokensStateType type,
    String? errorMessage,
  }) = _PushTokensState;

  factory PushTokensState.initial() => const PushTokensState(type: PushTokensStateType.initial);

  factory PushTokensState.uploadSuccess() => const PushTokensState(type: PushTokensStateType.uploadSuccess);

  factory PushTokensState.uploadFailure({String? errorMessage}) =>
      PushTokensState(type: PushTokensStateType.uploadFailure, errorMessage: errorMessage);
}
