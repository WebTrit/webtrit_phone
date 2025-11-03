part of 'push_tokens_bloc.dart';

@freezed
class PushTokensState with _$PushTokensState {
  const PushTokensState({
    this.pushToken,
    this.errorMessage,
  });

  @override
  final String? errorMessage;

  @override
  final String? pushToken;

  factory PushTokensState.initial() => const PushTokensState();

  factory PushTokensState.uploadFailure(String? errorMessage) => PushTokensState(errorMessage: errorMessage);
}
