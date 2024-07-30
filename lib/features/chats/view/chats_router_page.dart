import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class ChatsRouterPage extends StatefulWidget {
  const ChatsRouterPage({super.key});

  @override
  State<ChatsRouterPage> createState() => _ChatsRouterPageState();
}

class _ChatsRouterPageState extends State<ChatsRouterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageForwardCubit(),
      child: Column(
        children: [
          const Expanded(child: AutoRouter()),
          BlocBuilder<ChatsBloc, ChatsState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return Column(
                children: [
                  if (state.status != ChatsStatus.connected) ...[
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

  final ChatsState state;

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (state.status == ChatsStatus.initial) text = 'INITIALIZING';
    if (state.status == ChatsStatus.connecting) text = 'CONNECTING';
    if (state.status == ChatsStatus.error) text = 'DISCONNECTED';

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
