part of 'push_tokens_bloc.dart';

abstract class PushTokensEvent extends Equatable {
  const PushTokensEvent();
}

class PushTokensStarted extends PushTokensEvent {
  const PushTokensStarted();

  @override
  List<Object> get props => [];
}

class PushTokensInsertedOrUpdated extends PushTokensEvent {
  const PushTokensInsertedOrUpdated(this.type, this.value);

  final AppPushTokenType type;
  final String value;

  @override
  List<Object> get props => [
        type,
        value,
      ];
}
