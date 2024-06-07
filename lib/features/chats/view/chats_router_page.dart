import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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
          return const AutoRouter();
        }

        if (state.status == ChatsStatus.error) {
          return NoDataPlaceholder(
            content: Text(context.l10n.chats_RouterPage_failure),
            actions: [TextButton(onPressed: refreshChatsConnection, child: Text(context.l10n.chats_ActionBtn_retry))],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
