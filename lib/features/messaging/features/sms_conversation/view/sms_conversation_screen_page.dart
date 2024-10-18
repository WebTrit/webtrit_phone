import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class SmsConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SmsConversationScreenPage({required this.firstNumber, required this.secondNumber, this.recipientId});

  final String firstNumber;
  final String secondNumber;
  final String? recipientId;

  @override
  Widget build(BuildContext context) {
    final creds = (firstNumber: firstNumber, secondNumber: secondNumber, recipientId: recipientId);

    final screen = BlocProvider(
      key: ValueKey(creds),
      create: (context) => SmsConversationCubit(
        creds,
        context.read<MessagingBloc>().state.client,
        context.read<SmsRepository>(),
        context.read<SmsOutboxRepository>(),
        (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
      ),
      child: const SmsConversationScreen(),
    );

    return screen;
  }
}
