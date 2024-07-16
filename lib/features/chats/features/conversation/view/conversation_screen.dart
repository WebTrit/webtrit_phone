import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/chats/widgets/widgets.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    final chatsBloc = context.read<ChatsBloc>();
    final conversationCubit = context.read<ConversationCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dialog: ${conversationCubit.state.participantId}',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: BlocProvider(
        create: (context) => ChatTypingCubit(chatsBloc.state.client),
        child: BlocConsumer<ConversationCubit, ConversationState>(
          listener: (context, state) {
            if (state is CVSReady && state.chat != null) {
              context.read<ChatTypingCubit>().init(state.chat!.id);
            }
          },
          builder: (context, state) {
            if (state is CVSReady) {
              return MessageListView(
                userId: chatsBloc.state.userId ?? 'unknown',
                messages: state.messages,
                outboxMessages: state.outboxMessages,
                outboxMessageEdits: state.outboxMessageEdits,
                outboxMessageDeletes: state.outboxMessageDeletes,
                fetchingHistory: state.fetchingHistory,
                historyEndReached: state.historyEndReached,
                onSendMessage: (content) => conversationCubit.sendMessage(content),
                onSendReply: (content, refMessage) => conversationCubit.sendReply(content, refMessage),
                onSendForward: (content, refMessage) => conversationCubit.sendForward(refMessage),
                onSendEdit: (content, refMessage) => conversationCubit.sendEdit(content, refMessage),
                onDelete: (refMessage) => conversationCubit.deleteMessage(refMessage),
                onFetchHistory: conversationCubit.fetchHistory,
              );
            }

            if (state is CVSError) {
              return NoDataPlaceholder(
                content: Text(context.l10n.chats_Conversation_failure),
                actions: [
                  TextButton(onPressed: conversationCubit.restart, child: Text(context.l10n.chats_ActionBtn_retry))
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
