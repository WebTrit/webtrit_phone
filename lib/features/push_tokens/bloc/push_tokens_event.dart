part of 'push_tokens_bloc.dart';

@freezed
class PushTokensEvent with _$PushTokensEvent {
  const factory PushTokensEvent.started() = PushTokensStarted;

  const factory PushTokensEvent.insertedOrUpdated(AppPushTokenType type, String value) = PushTokensInsertedOrUpdated;

  const factory PushTokensEvent.error(String errorMessage) = _PushTokensError;

  const factory PushTokensEvent.fcmTokenDeletionRequested() = PushTokensFcmTokenDeletionRequested;
}
