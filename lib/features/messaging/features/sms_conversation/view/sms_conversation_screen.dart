import 'dart:ui';

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
  late final userId = context.read<AppBloc>().state.userId!;
  late final conversationCubit = context.read<SmsConversationCubit>();
  late final contactsRepo = context.read<ContactsRepository>();

  onDeleteDialog() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_ConversationInfo_deleteAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    final result = await conversationCubit.deleteConversation();

    if (!mounted) return;
    if (result != true) return;
    context.router.navigate(const MainScreenPageRoute(children: [MessagingRouterPageRoute()]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsConversationCubit, SmsConversationState>(
      listener: (context, state) {
        if (state is CVSLeft) {
          context.router.navigate(const MainScreenPageRoute(children: [MessagingRouterPageRoute()]));
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

          return Stack(
            children: [
              Scaffold(
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
                              title: Text(context.l10n.messaging_ConversationInfo_deleteBtn),
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
              ),
              if (state is SCSReady && state.busy)
                Container(
                  color: Colors.black.withOpacity(0.1),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
