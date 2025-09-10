import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({super.key});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  late final userId = context.read<AppBloc>().state.session.userId;
  late final messagingBloc = context.read<MessagingBloc>();
  late final conversationCubit = context.read<ConversationCubit>();

  onMenuTap() {
    final state = conversationCubit.state;
    final isDialog = state.credentials.participantId != null;
    final isGroup = state is CVSReady && state.chat?.type == ChatType.group;

    if (isDialog) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: conversationCubit,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: DialogInfo(userId, state.credentials.participantId!),
          ),
        ),
      );
    }

    if (isGroup) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => BlocProvider.value(
          value: conversationCubit,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: GroupInfo(userId),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatTypingCubit(messagingBloc.state.client),
      child: BlocConsumer<ConversationCubit, ConversationState>(
        listener: (context, state) {
          if (state is CVSReady && state.chat != null) {
            context.read<ChatTypingCubit>().init(state.chat!.id);
          }
          if (state is CVSLeft) {
            context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: FadeIn(
                child: Builder(
                  builder: (context) {
                    if (state is CVSReady) {
                      final chatName = state.chat?.name;
                      if (chatName != null) return nameTitle(chatName);

                      final (:chatId, :participantId) = state.credentials;
                      if (participantId != null) return dialogTitle(participantId);

                      return unknownTitle(chatId.toString());
                    }

                    return const SizedBox();
                  },
                ),
              ),
              actions: [
                IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu)),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state is CVSReady) {
                  return ChatMessageListView(
                    userId: userId,
                    messages: state.messages,
                    outboxMessages: state.outboxMessages,
                    outboxMessageEdits: state.outboxMessageEdits,
                    outboxMessageDeletes: state.outboxMessageDeletes,
                    readCursors: state.readCursors,
                    fetchingHistory: state.fetchingHistory,
                    historyEndReached: state.historyEndReached,
                    onSendMessage: (content) => conversationCubit.sendMessage(content),
                    onSendReply: (content, refMessage) => conversationCubit.sendReply(content, refMessage),
                    onSendForward: (content, refMessage) => conversationCubit.sendForward(refMessage),
                    onSendEdit: (content, refMessage) => conversationCubit.sendEdit(content, refMessage),
                    onDelete: (refMessage) => conversationCubit.deleteMessage(refMessage),
                    userReadedUntilUpdate: (until) => conversationCubit.userReadedUntilUpdate(until),
                    onFetchHistory: conversationCubit.fetchHistory,
                  );
                }

                if (state is CVSError) {
                  return NoDataPlaceholder(
                    content: Text(context.l10n.messaging_Conversation_failure),
                    actions: [
                      TextButton(
                        onPressed: conversationCubit.restart,
                        child: Text(context.l10n.messaging_ActionBtn_retry),
                      )
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }

  Widget dialogTitle(String participant) {
    return ContactInfoBuilder(
      sourceType: ContactSourceType.external,
      sourceId: participant,
      builder: (context, contact, {required bool loading}) {
        if (loading) return const SizedBox();

        return PresenceInfoBuilder(
            contact: contact,
            builder: (context, presenceInfo) {
              final text = switch (contact) {
                null => context.l10n.messaging_ParticipantName_unknown,
                _ => '${contact.displayTitle} ${presenceInfo?.primaryStatusIcon ?? ''}',
              };
              return Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              );
            });
      },
    );
  }

  Widget nameTitle(String name) {
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget unknownTitle(String chatId) {
    return Text(
      chatId,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 20),
    );
  }
}
