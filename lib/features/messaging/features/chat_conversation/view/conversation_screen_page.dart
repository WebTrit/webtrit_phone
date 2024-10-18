import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ChatConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatConversationScreenPage({this.participantId, this.chatId});

  final String? participantId;
  final int? chatId;

  @override
  Widget build(BuildContext context) {
    final creds = (chatId: chatId, participantId: participantId);

    final screen = BlocProvider(
      key: ValueKey(creds),
      create: (context) => ConversationCubit(
        creds,
        context.read<MessagingBloc>().state.client,
        context.read<ChatsRepository>(),
        context.read<ChatsOutboxRepository>(),
        (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
      )..init(),
      child: const ChatConversationScreen(),
    );

    return screen;
  }
}
