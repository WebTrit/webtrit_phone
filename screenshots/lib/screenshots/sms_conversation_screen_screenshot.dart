import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:screenshots/mocks/mocks.dart';

class SmsConversationScreenScreenshot extends StatefulWidget {
  const SmsConversationScreenScreenshot({super.key});

  @override
  State<SmsConversationScreenScreenshot> createState() => _SmsConversationScreenScreenshotState();
}

class _SmsConversationScreenScreenshotState extends State<SmsConversationScreenScreenshot> {
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
                Provider<SmsRepository>(create: (_) => MockSmsRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<MessagingBloc>(create: (_) => MockMessagingBloc.initial()),
                  BlocProvider<SmsConversationCubit>(create: (_) => MockSmsConversationCubit.withMessages()),
                  BlocProvider<SmsTypingCubit>(create: (_) => MockSmsTypingCubit.idle()),
                ],
                child: const SmsConversationScreen(),
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
