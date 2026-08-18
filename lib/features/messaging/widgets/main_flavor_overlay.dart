import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MessagingFlavorOverlay extends StatefulWidget {
  const MessagingFlavorOverlay({required this.child, super.key});

  final Widget child;

  /// Bottom-bar icon decoration: overlays the unread counter on the
  /// messaging tab and leaves every other tab untouched. Hand it to the bar
  /// from a host that provides an [UnreadCountCubit] - the bar itself does
  /// not require one.
  static Widget forTab(BottomMenuTab tab, Widget icon) {
    return tab.flavor == MainFlavor.messaging ? MessagingFlavorOverlay(child: icon) : icon;
  }

  @override
  State<MessagingFlavorOverlay> createState() => _MessagingFlavorOverlayState();
}

class _MessagingFlavorOverlayState extends State<MessagingFlavorOverlay> {
  @override
  Widget build(BuildContext context) {
    // A host that hands [forTab] to the bar without providing the unread
    // state gets a bare icon, not a screen-wide provider error: the badge is
    // an ornament and must not be able to take the navigation down.
    final unreadCounts = context.watch<UnreadCountCubit?>();
    if (unreadCounts == null) return widget.child;

    return Stack(
      children: [
        widget.child,
        BlocBuilder<UnreadCountCubit, UnreadCountState>(
          bloc: unreadCounts,
          builder: (context, state) {
            final count = state.chatsWithUnreadCount + state.smsConversationsWithUnreadCount;
            // Skip rendering if there are no unread messages
            if (count == 0) return const SizedBox();

            var overlay = Container(
              width: 14,
              height: 14,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, shape: BoxShape.circle),
              child: FittedBox(
                child: Text(count.toString(), style: const TextStyle(color: Colors.white)),
              ),
            );

            return Positioned(right: 0, bottom: 0, child: overlay);
          },
        ),
      ],
    );
  }
}
