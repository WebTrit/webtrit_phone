import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({required this.selectedTab, super.key});

  final TabType selectedTab;

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  late final userId = context.read<AppBloc>().state.session.userId;

  @override
  Widget build(BuildContext context) {
    late final chats = BlocBuilder<ChatConversationsCubit, ChatConversationsState>(
      builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());

        final conversationsToShow = state.conversationsToShow;
        if (conversationsToShow.isEmpty) return Center(child: Text(context.l10n.messaging_ConversationsScreen_empty));

        return ListView(
          children: conversationsToShow.map((e) {
            final (:chat, :message, contacts: _) = e;
            return FadeIn(
              child: ChatConversationsTile(conversation: chat, lastMessage: message, userId: userId, key: ValueKey(e)),
            );
          }).toList(),
        );
      },
    );

    late final smses = BlocBuilder<SmsConversationsCubit, SmsConversationsState>(
      builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());

        final conversationsToShow = state.conversationsToShow;
        if (conversationsToShow.isEmpty) return Center(child: Text(context.l10n.messaging_ConversationsScreen_empty));

        return ListView(
          children: conversationsToShow.map((e) {
            final conversation = e.$1;
            final lastMessage = e.$2;
            return FadeIn(
              child: SmsConversationsTile(
                conversation: conversation,
                lastMessage: lastMessage,
                userId: userId,
                key: ValueKey(e),
              ),
            );
          }).toList(),
        );
      },
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 0),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeInExpo,
      child: switch (widget.selectedTab) {
        TabType.chat => chats,
        TabType.sms => smses,
      },
      transitionBuilder: (child, animation) {
        final reverse = widget.selectedTab == TabType.sms;

        final begin = Offset(reverse ? 1.0 : -1.0, 0);
        const end = Offset(0, 0);

        return SlideTransition(
          position: animation.drive(Tween(begin: begin, end: end)),
          child: child,
        );
      },
    );
  }
}
