import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final messagingBloc = context.read<MessagingBloc>();
    final smsRepository = context.read<SmsRepository>();
    final smsOutboxRepository = context.read<SmsOutboxRepository>();

    final widget = BlocProvider(
      key: ValueKey(firstNumber + secondNumber),
      create: (context) => SmsConversationCubit(
        (firstNumber: firstNumber, secondNumber: secondNumber, recipientId: recipientId),
        messagingBloc.state.client,
        smsRepository,
        smsOutboxRepository,
      ),
      child: const SmsConversationScreen(),
    );

    return widget;
  }
}
