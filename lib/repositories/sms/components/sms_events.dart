import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/models.dart';

sealed class SmsEvent {
  const SmsEvent();
}

class SmsConversationUpdate extends SmsEvent with EquatableMixin {
  const SmsConversationUpdate(this.chat);
  final SmsConversation chat;

  @override
  List<Object> get props => [chat];

  @override
  bool get stringify => true;
}

class SmsConversationRemove extends SmsEvent with EquatableMixin {
  const SmsConversationRemove(this.chatId);
  final int chatId;

  @override
  List<Object> get props => [chatId];

  @override
  bool get stringify => true;
}

class SmsMessageUpdate extends SmsEvent with EquatableMixin {
  const SmsMessageUpdate(this.message);
  final SmsMessage message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}
