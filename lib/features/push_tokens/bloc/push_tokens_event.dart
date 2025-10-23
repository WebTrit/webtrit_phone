part of 'push_tokens_bloc.dart';

sealed class PushTokensEvent {
  const PushTokensEvent();
}

class PushTokensEventStarted extends PushTokensEvent {
  const PushTokensEventStarted();
}

class PushTokensEventInsertedOrUpdated extends PushTokensEvent {
  const PushTokensEventInsertedOrUpdated(this.type, this.value);

  final AppPushTokenType type;
  final String value;
}

class PushTokensEventError extends PushTokensEvent {
  const PushTokensEventError(this.errorMessage);

  final String errorMessage;
}