import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

class MessagingFlavorOverlay extends StatefulWidget {
  const MessagingFlavorOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<MessagingFlavorOverlay> createState() => _MessagingFlavorOverlayState();
}

class _MessagingFlavorOverlayState extends State<MessagingFlavorOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        BlocBuilder<UnreadCountCubit, UnreadCountState>(
          builder: (context, state) {
            final count = state.chatsWithUnreadCount + state.smsConversationsWithUnreadCount;
            // Skip rendering if there are no unread messages
            if (count == 0) return const SizedBox();

            var overlay = Container(
              width: 14,
              height: 14,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, shape: BoxShape.circle),
              child: FittedBox(child: Text(count.toString(), style: const TextStyle(color: Colors.white))),
            );

            return Positioned(right: 0, bottom: 0, child: overlay);
          },
        ),
      ],
    );
  }
}
