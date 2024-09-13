import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

@RoutePage()
class MessagingRouterPage extends StatefulWidget {
  const MessagingRouterPage({super.key});

  @override
  State<MessagingRouterPage> createState() => _MessagingRouterPageState();
}

class _MessagingRouterPageState extends State<MessagingRouterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageForwardCubit(),
      child: Column(
        children: [
          BlocBuilder<MessagingBloc, MessagingState>(
            buildWhen: (previous, current) => previous.userId != current.userId,
            builder: (context, state) {
              if (state.userId != null) {
                return const Expanded(child: AutoRouter());
              } else {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              }
              // return Expanded(child: AutoRouter());
            },
          ),
          BlocBuilder<MessagingBloc, MessagingState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return Column(
                children: [
                  if (state.status != ConnectionStatus.connected) ...[
                    const SizedBox(height: 8),
                    StateBar(state: state),
                    const SizedBox(height: 8),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class StateBar extends StatelessWidget {
  const StateBar({required this.state, super.key});

  final MessagingState state;

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (state.status == ConnectionStatus.initial) text = context.l10n.chats_StateBar_initializing;
    if (state.status == ConnectionStatus.connecting) text = context.l10n.chats_StateBar_connecting;
    if (state.status == ConnectionStatus.error) text = context.l10n.chats_StateBar_error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
