import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/fade_id.dart';
import 'package:webtrit_phone/widgets/no_data_placeholder.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class SmsConversationScreen extends StatefulWidget {
  const SmsConversationScreen({super.key});

  @override
  State<SmsConversationScreen> createState() => _SmsConversationScreenState();
}

class _SmsConversationScreenState extends State<SmsConversationScreen> {
  late final userId = context.read<AppBloc>().state.session.userId;
  late final messagingBloc = context.read<MessagingBloc>();
  late final conversationCubit = context.read<SmsConversationCubit>();
  late final contactsRepo = context.read<ContactsRepository>();

  onDeleteDialog() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_DialogInfo_deleteAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    await conversationCubit.deleteConversation();
    if (!mounted) return;
    context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsTypingCubit(messagingBloc.state.client),
      child: BlocConsumer<SmsConversationCubit, SmsConversationState>(
        listener: (context, state) {
          if (state is SCSReady && state.conversation != null) {
            context.read<SmsTypingCubit>().initConversation(state.conversation!.id);
          }
          if (state is SCSLeft) {
            context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
          }
        },
        builder: (context, state) {
          return UserSmsNumbersBuilder(builder: (context, List<String> numbers, {required loading}) {
            final firstNumber = state.creds.firstNumber;
            final secondNumber = state.creds.secondNumber;
            String? userNumber;
            userNumber = numbers.firstWhereOrNull((e) => e == firstNumber || e == secondNumber);
            String? recipientNumber;
            if (userNumber != null) recipientNumber = firstNumber == userNumber ? secondNumber : firstNumber;

            if (loading) return const SizedBox();

            return Scaffold(
              appBar: AppBar(
                title: Builder(
                  builder: (context) {
                    if (recipientNumber != null) {
                      return FadeIn(
                        child: Text(
                          recipientNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    } else {
                      return FadeIn(
                        child: Column(
                          children: [
                            Text(
                              firstNumber,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              secondNumber,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: onDeleteDialog,
                          child: ListTile(
                            title: Text(context.l10n.messaging_DialogInfo_deleteBtn),
                            leading: const Icon(Icons.playlist_remove_rounded),
                            dense: true,
                          ),
                        )
                      ];
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              body: Builder(
                builder: (context) {
                  if (state is SCSReady) {
                    return SmsMessageListView(
                      userId: userId,
                      userNumber: userNumber,
                      messages: state.messages,
                      outboxMessages: state.outboxMessages,
                      outboxMessageDeletes: state.outboxMessageDeletes,
                      readCursors: state.readCursors,
                      fetchingHistory: state.fetchingHistory,
                      historyEndReached: state.historyEndReached,
                      onSendMessage: (content) => conversationCubit.sendMessage(content),
                      onDelete: (refMessage) => conversationCubit.deleteMessage(refMessage),
                      userReadedUntilUpdate: (date) => conversationCubit.userReadedUntilUpdate(date),
                      onFetchHistory: conversationCubit.fetchHistory,
                    );
                  }

                  if (state is SCSError) {
                    return NoDataPlaceholder(
                      content: Text(context.l10n.messaging_Conversation_failure),
                      actions: [
                        TextButton(
                            onPressed: conversationCubit.restart, child: Text(context.l10n.messaging_ActionBtn_retry))
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }
}
