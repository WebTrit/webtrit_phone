part of 'push_tokens_bloc.dart';

sealed class PushTokensEvent extends Equatable {
  const PushTokensEvent();

  @override
  List<Object> get props => [];
}

class PushTokensEventStarted extends PushTokensEvent {
  const PushTokensEventStarted();
}

class PushTokensEventInsertedOrUpdated extends PushTokensEvent {
  const PushTokensEventInsertedOrUpdated(this.type, this.value);

  final AppPushTokenType type;
  final String value;

  @override
  List<Object> get props => [
        EquatablePropToString([type, value], listPropToString),
      ];
}

class PushTokensEventError extends PushTokensEvent {
  const PushTokensEventError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        EquatablePropToString([errorMessage], listPropToString),
      ];
}
