import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/chats/view/conversation_screen.dart';

@RoutePage()
class ConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationScreenPage({required this.participantId});

  final String participantId;

  @override
  Widget build(BuildContext context) {
    return ConversationScreen(participantId: participantId);
  }
}
