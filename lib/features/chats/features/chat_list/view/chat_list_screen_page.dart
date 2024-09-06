import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ChatListScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatListScreenPage();

  @override
  Widget build(BuildContext context) {
    final chatsRepository = context.read<ChatsRepository>();

    final widget = BlocProvider(
      create: (context) => ChatListCubit(chatsRepository),
      child: const ChatListScreen(title: Text(EnvironmentConfig.APP_NAME)),
    );

    return widget;
  }
}
