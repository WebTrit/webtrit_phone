import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ChatFlavorOverlay extends StatefulWidget {
  const ChatFlavorOverlay({required this.child, super.key});

  final Widget child;
  @override
  State<ChatFlavorOverlay> createState() => _ChatFlavorOverlayState();
}

class _ChatFlavorOverlayState extends State<ChatFlavorOverlay> {
  late final chatsRepository = context.read<ChatsRepository>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        final userId = state.userId;
        if (userId != null) {
          return StreamBuilder<int>(
            stream: chatsRepository.chatsWithUnreadedMessagesCount(userId),
            builder: (context, snapshot) => overlay(context, snapshot.data ?? 0),
          );
        } else {
          return overlay(context, 0);
        }
      },
    );
  }

  Widget overlay(BuildContext context, int count) {
    return Stack(
      children: [
        widget.child,
        if (count > 0)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, shape: BoxShape.circle),
              child: FittedBox(
                child: Text(count.toString(), style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}
