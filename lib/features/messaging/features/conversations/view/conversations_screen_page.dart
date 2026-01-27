import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ConversationsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationsScreenPage();

  @override
  Widget build(BuildContext context) {
    final messagingFeature = context.read<MessagingBloc>().state.messagingConfig;
    final chatsEnabled = messagingFeature.chatsPresent;
    final smsEnabled = messagingFeature.smsPresent;
    final groupChatsEnabled = messagingFeature.groupChatSupport;
    final screenTitle = Text(EnvironmentConfig.APP_NAME);

    // Guard for cases where neither chats nor SMS features are available in core
    // but app configured to show messaging tab.
    if (!chatsEnabled && !smsEnabled) return ConversationsScreenUnsupported(title: screenTitle);
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
            )..init(),
          ),
        if (smsEnabled)
          BlocProvider(
            key: const Key('sms_conversations_cubit'),
            create: (context) =>
                SmsConversationsCubit(context.read<MessagingBloc>().state.client, context.read<SmsRepository>())
                  ..init(),
          ),
      ],
      child: ConversationsScreen(
        title: screenTitle,
        initialTabsState: switch ((chatsEnabled, smsEnabled)) {
          (true, true) => DualTabState(TabType.chat, groupChatsEnabled),
          (true, false) => SingleTabState(TabType.chat, groupChatsEnabled),
          (false, true) => SingleTabState(TabType.sms, false),
          (false, false) => throw Exception('At least one tab must be enabled, check screen page logic above'),
        },
      ),
    );

    return widget;
  }
}
