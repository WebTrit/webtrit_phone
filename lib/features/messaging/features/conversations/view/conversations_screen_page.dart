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
    final chatsRepository = context.read<ChatsRepository>();
    final smsRepository = context.read<SmsRepository>();
    final contactsRepository = context.read<ContactsRepository>();

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatConversationsCubit(chatsRepository, contactsRepository)),
        BlocProvider(create: (context) => SmsConversationsCubit(smsRepository)),
      ],
      child: const ConversationsScreen(title: Text(EnvironmentConfig.APP_NAME)),
    );

    return widget;
  }
}
