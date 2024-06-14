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
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        return Column(
          children: [
            const Expanded(child: AutoRouter()),
            if (state.status == ChatsStatus.connecting || state.status == ChatsStatus.initial) progressBar(),
            if (state.status == ChatsStatus.error) disconectBar(context),
          ],
        );
      },
    );
  }

  void refreshChatsConnection(BuildContext context) {
    context.read<ChatsBloc>().add(const Refresh());
  }

  Widget disconectBar(BuildContext context) {
    return NoDataPlaceholder(
      content: Text(context.l10n.chats_RouterPage_failure),
      contentPadding: const EdgeInsets.all(4),
      actionsPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          onPressed: () => refreshChatsConnection(context),
          child: Text(context.l10n.chats_ActionBtn_retry),
        ),
      ],
    );
  }

  Widget progressBar() {
    return const SizedBox(
      height: 64,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
