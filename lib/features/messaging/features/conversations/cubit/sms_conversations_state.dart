part of 'sms_conversations_cubit.dart';

class SmsConversationsState with EquatableMixin {
  final List<(SmsConversation, SmsMessage?)> conversations;
  final List<(SmsConversation, SmsMessage?)> conversationsToShow;
  final bool initialising;

  SmsConversationsState(this.conversations, this.conversationsToShow, this.initialising);

  factory SmsConversationsState.initial() => SmsConversationsState([], [], true);

  @override
  List<Object?> get props => [conversations, conversationsToShow, initialising];

  SmsConversationsState copyWith({
    List<(SmsConversation, SmsMessage?)>? conversations,
    List<(SmsConversation, SmsMessage?)>? conversationsToShow,
    bool? initialising,
  }) {
    return SmsConversationsState(
      conversations ?? this.conversations,
      conversationsToShow ?? this.conversationsToShow,
      initialising ?? this.initialising,
    );
  }
}
