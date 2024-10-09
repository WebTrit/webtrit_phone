import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late final userId = context.read<AppBloc>().state.userId!;
  late final messagingBloc = context.read<MessagingBloc>();
  late final groupCubit = context.read<GroupCubit>();

  onMenuTap() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider.value(
        value: groupCubit,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: GroupInfo(userId: userId),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatTypingCubit(messagingBloc.state.client),
      child: BlocConsumer<GroupCubit, GroupState>(
        listener: (context, state) {
          if (state is GroupStateReady) {
            context.read<ChatTypingCubit>().init(state.chat.id);
          }
          if (state is GroupStateLeft) {
            context.router.navigate(const MainScreenPageRoute(children: [MessagingRouterPageRoute()]));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Builder(builder: (context) {
                    if (state is GroupStateReady && (state.chat.name?.isNotEmpty ?? false)) {
                      return FadeIn(
                        child: Text(
                          state.chat.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    } else {
                      return FadeIn(
                        child: Text(
                          '${context.l10n.messaging_GroupScreen_titlePrefix} ${groupCubit.state.chatId}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  }),
                  actions: [
                    IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu)),
                  ],
                ),
                body: Builder(
                  builder: (context) {
                    if (state is GroupStateReady) {
                      return ChatMessageListView(
                        userId: userId,
                        messages: state.messages,
                        outboxMessages: state.outboxMessages,
                        outboxMessageEdits: state.outboxMessageEdits,
                        outboxMessageDeletes: state.outboxMessageDeletes,
                        readCursors: state.readCursors,
                        fetchingHistory: state.fetchingHistory,
                        historyEndReached: state.historyEndReached,
                        onSendMessage: (content) => groupCubit.sendMessage(content),
                        onSendReply: (content, refMessage) => groupCubit.sendReply(content, refMessage),
                        onSendForward: (content, refMessage) => groupCubit.sendForward(refMessage),
                        onSendEdit: (content, refMessage) => groupCubit.sendEdit(content, refMessage),
                        onDelete: (refMessage) => groupCubit.deleteMessage(refMessage),
                        userReadedUntilUpdate: (until) => groupCubit.userReadedUntilUpdate(until),
                        onFetchHistory: groupCubit.fetchHistory,
                      );
                    }

                    if (state is GroupStateError) {
                      return NoDataPlaceholder(
                        content: Text(context.l10n.messaging_Conversation_failure),
                        actions: [
                          TextButton(onPressed: groupCubit.restart, child: Text(context.l10n.messaging_ActionBtn_retry))
                        ],
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              if (state is GroupStateReady && state.busy)
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
