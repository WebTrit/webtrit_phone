import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ConversationsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationsScreenPage();

  @override
  Widget build(BuildContext context) {
    const chatsEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;
    const smsEnabled = EnvironmentConfig.SMS_FEATURE_ENABLE;

    final client = context.read<MessagingBloc>().state.client;
    final chatsRepository = context.read<ChatsRepository>();
    final smsRepository = context.read<SmsRepository>();
    final contactsRepository = context.read<ContactsRepository>();

    final widget = MultiBlocProvider(
      providers: [
        if (chatsEnabled)
          BlocProvider(
            create: (context) => ChatConversationsCubit(
              client,
              chatsRepository,
              contactsRepository,
            ),
          ),
        if (smsEnabled)
          BlocProvider(
            create: (context) => SmsConversationsCubit(
              client,
              smsRepository,
            ),
          ),
      ],
      child: const ConversationsScreen(title: Text(EnvironmentConfig.APP_NAME)),
    );

    return widget;
  }
}
