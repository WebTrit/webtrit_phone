import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/fade_id.dart';
import 'package:webtrit_phone/widgets/no_data_placeholder.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final messagingBloc = context.read<MessagingBloc>();
  late final conversationCubit = context.read<ConversationCubit>();
  late final contactsRepo = context.read<ContactsRepository>();

  onMenuTap() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider.value(
        value: conversationCubit,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: ConversationInfo(userId: messagingBloc.state.userId!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatTypingCubit(messagingBloc.state.client, contactsRepo),
      child: BlocConsumer<ConversationCubit, ConversationState>(
        listener: (context, state) {
          if (state is CVSReady && state.chat != null) {
            context.read<ChatTypingCubit>().init(state.chat!.id);
          }
          if (state is CVSLeft) {
            context.router.navigate(const MainScreenPageRoute(children: [MessagingRouterPageRoute()]));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: ContactInfoBuilder(
                    sourceType: ContactSourceType.external,
                    sourceId: conversationCubit.state.participantId,
                    builder: (context, contact, {required bool loading}) {
                      if (loading) return const SizedBox();
                      if (contact != null) {
                        final online = contact.registered == true;

                        return FadeIn(
                          child: Column(
                            children: [
                              Text(
                                contact.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20),
                              ),
                              if (online)
                                const Text(
                                  'online',
                                  style: TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                        );
                      } else {
                        return FadeIn(
                          child: Text(
                            '${context.l10n.messaging_ConversationScreen_titlePrefix} ${conversationCubit.state.participantId}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }
                    },
                  ),
                  actions: [
                    IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu)),
                  ],
                ),
                body: Builder(
                  builder: (context) {
                    if (state is CVSReady) {
                      return ChatMessageListView(
                        userId: messagingBloc.state.userId!,
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
              ),
              if (state is CVSReady && state.busy)
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
