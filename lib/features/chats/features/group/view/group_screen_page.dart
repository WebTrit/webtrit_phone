import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class GroupScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GroupScreenPage({required this.chatId});

  final int chatId;

  @override
  Widget build(BuildContext context) {
    final chatsBloc = context.read<ChatsBloc>();
    final localChatRepository = context.read<LocalChatRepository>();

    final widget = BlocProvider(
      key: ValueKey(chatId),
      create: (context) => GroupCubit(
        chatId,
        chatsBloc.state.client,
        localChatRepository,
      ),
      child: const GroupScreen(),
    );

    return widget;
  }
}
