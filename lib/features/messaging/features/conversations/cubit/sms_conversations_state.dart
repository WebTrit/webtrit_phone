part of 'sms_conversations_cubit.dart';

class SmsConversationsState with EquatableMixin {
  final List<(SmsConversation, SmsMessage?)> conversations;
  final bool initialising;

  SmsConversationsState(this.conversations, this.initialising);

  factory SmsConversationsState.initial() => SmsConversationsState([], true);

  @override
  List<Object> get props => [conversations, initialising];

  SmsConversationsState copyWith({List<(SmsConversation, SmsMessage?)>? conversations, bool? initialising}) {
    return SmsConversationsState(conversations ?? this.conversations, initialising ?? this.initialising);
  }
}
