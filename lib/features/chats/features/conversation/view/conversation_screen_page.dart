import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class ConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationScreenPage({required this.participantId});

  final String participantId;

  @override
  Widget build(BuildContext context) {
    final chatsBloc = context.read<ChatsBloc>();

    final widget = BlocProvider(
      create: (context) => ConversationCubit(
        participantId,
        chatsBloc.state.client,
      ),
      child: const ConversationScreen(),
    );

    return widget;
  }
}
