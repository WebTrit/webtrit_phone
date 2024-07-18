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

    return BlocProvider(
      create: (context) => ChatTypingCubit(chatsBloc.state.client),
      child: BlocConsumer<GroupCubit, GroupState>(
        listener: (context, state) {
          if (state is GroupStateReady) {
            context.read<ChatTypingCubit>().init(state.chat.id);
          }
        },
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
            ),
            endDrawer: GroupDrawer(userId: chatsBloc.state.userId ?? '-1'),
            body: Builder(
              builder: (context) {
                if (state is GroupStateReady) {
                  return MessageListView(
                    userId: chatsBloc.state.userId ?? '-1',
                    messages: state.messages,
                    outboxMessages: state.outboxMessages,
                    outboxMessageEdits: state.outboxMessageEdits,
                    outboxMessageDeletes: state.outboxMessageDeletes,
                    fetchingHistory: state.fetchingHistory,
                    historyEndReached: state.historyEndReached,
                    onSendMessage: (content, _) => groupCubit.sendMessage(content),
                    onSendReply: (content, refMessage) => groupCubit.sendReply(content, refMessage),
                    onSendForward: (content, refMessage) => groupCubit.sendForward(refMessage),
                    onSendEdit: (content, refMessage) => groupCubit.sendEdit(content, refMessage),
                    onDelete: (refMessage) => groupCubit.deleteMessage(refMessage),
                    onViewed: (refMessage) => groupCubit.markAsViewed(refMessage),
                    onFetchHistory: groupCubit.fetchHistory,
                    hasSmsFeature: false,
                  );
                }

                if (state is GroupStateError) {
                  return NoDataPlaceholder(
                    content: Text(context.l10n.chats_Conversation_failure),
                    actions: [
                      TextButton(onPressed: groupCubit.restart, child: Text(context.l10n.chats_ActionBtn_retry))
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
