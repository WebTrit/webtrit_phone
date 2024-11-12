part of 'push_tokens_bloc.dart';

@freezed
class PushTokensState with _$PushTokensState {
  const factory PushTokensState({
    String? pushToken,
    String? errorMessage,
  }) = _PushTokensState;

  factory PushTokensState.initial() => const PushTokensState();

  factory PushTokensState.uploadFailure(String? errorMessage) => PushTokensState(errorMessage: errorMessage);
}
