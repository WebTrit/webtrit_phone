import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:screenshots/mocks/mocks.dart';

class ChatConversationScreenScreenshot extends StatefulWidget {
  const ChatConversationScreenScreenshot({super.key});

  @override
  State<ChatConversationScreenScreenshot> createState() => _ChatConversationScreenScreenshotState();
}

class _ChatConversationScreenScreenshotState extends State<ChatConversationScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiProvider(
              providers: [
                Provider<ContactsRepository>(create: (_) => MockContactsRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<MessagingBloc>(create: (_) => MockMessagingBloc.initial()),
                  BlocProvider<ConversationCubit>(create: (_) => MockConversationCubit.withMessages()),
                  BlocProvider<ChatsForwardingCubit>(create: (_) => MockChatsForwardingCubit.initial()),
                ],
                child: const ChatConversationScreen(),
              ),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
