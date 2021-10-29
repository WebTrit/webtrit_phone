part of 'push_tokens_bloc.dart';

abstract class PushTokensState extends Equatable {
  const PushTokensState();

  @override
  List<Object> get props => [];
}

class PushTokensInitial extends PushTokensState {
  const PushTokensInitial();
}

class PushTokensUploadSuccess extends PushTokensState {
  const PushTokensUploadSuccess();
}

class PushTokensUploadFailure extends PushTokensState {
  const PushTokensUploadFailure();
}
