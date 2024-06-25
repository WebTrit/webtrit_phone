import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/chats/widgets/widgets.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final chatsBloc = context.read<ChatsBloc>();
    final groupCubit = context.read<GroupCubit>();

    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        String titleText = 'Group: ${groupCubit.state.chatId}';
        if (state is GroupStateReady) {
          final groupName = state.chat.name;
          if (groupName != null && groupName.isNotEmpty) titleText = groupName;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              titleText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: drawer impl
                },
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state is GroupStateReady) {
                return MessageListView(
                  userId: chatsBloc.state.userId ?? 'unknown',
                  messages: state.messages,
                  outboxQueue: state.outboxQueue,
                  fetchingHistory: state.fetchingHistory,
                  historyEndReached: state.historyEndReached,
                  onSend: (content) => groupCubit.sendMessage(content),
                  onFetchHistory: groupCubit.fetchHistory,
                );
              }

              if (state is GroupStateError) {
                return NoDataPlaceholder(
                  content: Text(context.l10n.chats_Conversation_failure),
                  actions: [TextButton(onPressed: groupCubit.restart, child: Text(context.l10n.chats_ActionBtn_retry))],
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
