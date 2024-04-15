import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

@RoutePage()
class ChatsRouterPage extends StatelessWidget {
  const ChatsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    void refreshChatsConnection() {
      context.read<ChatsBloc>().add(const Refresh());
    }

    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state.status == ChatsStatus.connected) {
          return StreamChat(
            useMaterial3: true,
            client: state.client,
            child: const AutoRouter(),
          );
        }

        if (state.status == ChatsStatus.error) {
          return NoDataPlaceholder(
            // TODO: localize
            content: const Text('Error connecting to chat service'),
            actions: [
              TextButton(
                onPressed: refreshChatsConnection,
                child: const Text('Retry'),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
