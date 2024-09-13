import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/models.dart';

sealed class SmsEvent {
  const SmsEvent();
}

class SmsConversationUpdate extends SmsEvent with EquatableMixin {
  const SmsConversationUpdate(this.conversation);
  final SmsConversation conversation;

  @override
  List<Object> get props => [conversation];

  @override
  bool get stringify => true;
}

class SmsConversationRemove extends SmsEvent with EquatableMixin {
  const SmsConversationRemove(this.conversationId);
  final int conversationId;

  @override
  List<Object> get props => [conversationId];

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
