import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class ChatsRouterPage extends StatelessWidget {
  const ChatsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state.status == ChatsStatus.error) {
          final notificationsBloc = context.read<NotificationsBloc>();
          final exception = state.error ?? Exception('Unknown error');
          final event = NotificationsMessaged(DefaultErrorNotification(exception));
          notificationsBloc.add(event);
        }
      },
      builder: (context, state) {
        if (state.status == ChatsStatus.connected) {
          return StreamChat(client: state.client, child: const AutoRouter());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
