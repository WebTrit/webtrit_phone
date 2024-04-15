import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class ConversationScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ConversationScreenPage({required this.participantId});

  final String participantId;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final chatsBloc = context.read<ChatsBloc>();
    const getStreamServiceUrl = EnvironmentConfig.GETSTREAM_SERVICE_URL;

    final widget = BlocProvider(
      create: (context) => ConversationCubit(
        participantId,
        appBloc.state.token!,
        appBloc.state.tenantId!,
        getStreamServiceUrl,
        chatsBloc.state.client,
      ),
      child: const ConversationScreen(),
    );

    return widget;
  }
}
