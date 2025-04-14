import 'dart:ui';

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
  late final userId = context.read<AppBloc>().state.userId!;
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
    final theme = Theme.of(context);

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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: theme.canvasColor.withAlpha(150),
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(color: theme.canvasColor.withAlpha(150)),
                ),
              ),
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
                    onSendMessage: conversationCubit.sendMessage,
                    onSendReply: conversationCubit.sendReply,
                    onSendForward: conversationCubit.sendForward,
                    onSendEdit: conversationCubit.sendEdit,
                    onDelete: conversationCubit.deleteMessage,
                    onResend: conversationCubit.resendOutboxMessage,
                    onDeleteOutboxMessage: conversationCubit.deleteOutboxMessage,
                    userReadedUntilUpdate: conversationCubit.userReadedUntilUpdate,
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
        if (contact != null) {
          final online = contact.registered == true;

          return Column(
            children: [
              Text(
                contact.displayTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
              if (online) const Text('online', style: TextStyle(fontSize: 12)),
            ],
          );
        } else {
          return Text(
            '${context.l10n.messaging_ConversationScreen_titlePrefix} $participant',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          );
        }
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
