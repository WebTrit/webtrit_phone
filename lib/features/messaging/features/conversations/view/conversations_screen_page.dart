import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ConversationsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationsScreenPage();

  @override
  Widget build(BuildContext context) {
    final messagingFeature = context.read<FeatureAccess>().messagingFeature;
    final chatsEnabled = messagingFeature.chatsPresent;
    final smsEnabled = messagingFeature.smsPresent;

    final widget = MultiBlocProvider(
      providers: [
        Provider(create: (context) => ('stub', 123)),
        if (chatsEnabled)
          BlocProvider(
            key: const Key('chat_conversations_cubit'),
            create: (context) => ChatConversationsCubit(
              context.read<MessagingBloc>().state.client,
              context.read<ChatsRepository>(),
              context.read<ContactsRepository>(),
            ),
          ),
        if (smsEnabled)
          BlocProvider(
            key: const Key('sms_conversations_cubit'),
            create: (context) =>
                SmsConversationsCubit(context.read<MessagingBloc>().state.client, context.read<SmsRepository>()),
          ),
      ],
      child: const ConversationsScreen(title: Text(EnvironmentConfig.APP_NAME)),
    );

    return widget;
  }
}
