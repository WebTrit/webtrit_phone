import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/chats/features/chat_list/chat_list.dart';

@RoutePage()
class ChatListScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatListScreenPage();

  @override
  Widget build(BuildContext context) {
    return const ChatListScreen(
      title: Text(EnvironmentConfig.APP_NAME),
    );
  }
}
