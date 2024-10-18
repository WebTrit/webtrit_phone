import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/models.dart';

sealed class SmsEvent {
  int get conversationId;

  const SmsEvent();
}

class SmsConversationUpdate extends SmsEvent with EquatableMixin {
  const SmsConversationUpdate(this.conversation);
  final SmsConversation conversation;

  @override
  int get conversationId => conversation.id;

  @override
  List<Object> get props => [conversation];

  @override
  bool get stringify => true;
}

class SmsConversationRemove extends SmsEvent with EquatableMixin {
  const SmsConversationRemove(this.conversationId);

  @override
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
  int get conversationId => message.conversationId;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class SmsReadCursorUpdate extends SmsEvent with EquatableMixin {
  const SmsReadCursorUpdate(this.cursor);
  final SmsMessageReadCursor cursor;

  @override
  int get conversationId => cursor.conversationId;

  @override
  List<Object> get props => [cursor];

  @override
  bool get stringify => true;
}
