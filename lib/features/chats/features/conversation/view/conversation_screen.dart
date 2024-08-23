import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
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
    final contactsRepo = context.read<ContactsRepository>();

    return Scaffold(
      appBar: AppBar(
        title: ContactInfoBuilder(
            sourceType: ContactSourceType.external,
            sourceId: conversationCubit.state.participantId,
            builder: (context, contact, {required bool loading}) {
              if (loading) return const SizedBox();
              if (contact != null) {
                return FadeIn(
                  child: Text(
                    contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return FadeIn(
                  child: Text(
                    '${context.l10n.chats_ConversationScreen_titlePrefix} ${conversationCubit.state.participantId}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }
            }),
      ),
      body: BlocProvider(
        create: (context) => ChatTypingCubit(chatsBloc.state.client, contactsRepo),
        child: BlocConsumer<ConversationCubit, ConversationState>(
          listener: (context, state) {
            if (state is CVSReady && state.chat != null) {
              context.read<ChatTypingCubit>().init(state.chat!.id);
            }
          },
          builder: (context, state) {
            if (state is CVSReady) {
              return MessageListView(
                userId: chatsBloc.state.userId!,
                messages: state.messages,
                outboxMessages: state.outboxMessages,
                outboxMessageEdits: state.outboxMessageEdits,
                outboxMessageDeletes: state.outboxMessageDeletes,
                fetchingHistory: state.fetchingHistory,
                historyEndReached: state.historyEndReached,
                onSendMessage: (content, useSms) => conversationCubit.sendMessage(content, useSms),
                onSendReply: (content, refMessage) => conversationCubit.sendReply(content, refMessage),
                onSendForward: (content, refMessage) => conversationCubit.sendForward(refMessage),
                onSendEdit: (content, refMessage) => conversationCubit.sendEdit(content, refMessage),
                onDelete: (refMessage) => conversationCubit.deleteMessage(refMessage),
                onViewed: (refMessage) => conversationCubit.markAsViewed(refMessage),
                onFetchHistory: conversationCubit.fetchHistory,
                hasSmsFeature: true,
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
