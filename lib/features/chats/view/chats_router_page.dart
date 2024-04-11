import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/chats/bloc/chats_bloc.dart';

@RoutePage()
class ChatsRouterPage extends StatelessWidget {
  const ChatsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state.status == ChatsStatus.connected) {
          return const AutoRouter();
        }
        // TODO: handle error

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
