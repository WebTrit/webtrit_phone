import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationScreenPage({required this.participantId});

  final String participantId;

  @override
  Widget build(BuildContext context) {
    final messagingBloc = context.read<MessagingBloc>();
    final chatsRepository = context.read<ChatsRepository>();
    final chatsOutboxRepository = context.read<ChatsOutboxRepository>();

    final screen = BlocProvider(
      key: ValueKey(participantId),
      create: (context) => ConversationCubit(
        participantId,
        messagingBloc.state.client,
        chatsRepository,
        chatsOutboxRepository,
      ),
      child: const ConversationScreen(),
    );

    return MessagingStateWrapper(child: screen);
  }
}
