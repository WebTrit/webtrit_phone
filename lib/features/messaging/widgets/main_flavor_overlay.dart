import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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

            // The badge draws a glyph and says nothing of its own; the count
            // travels as the entry's VALUE.
            //
            // Everywhere else in the app a count is part of the name, drawn
            // after it, because Android composes what it speaks as value, then
            // label - so a value is read out ahead of the name it belongs to.
            // Here that is not available: the caption belongs to the bar, which
            // draws it after this slot and takes it from what is displayed, so
            // there is nothing of ours drawn later to hang the phrase on and no
            // way to add to the caption without changing what is on screen. A
            // value at least says what the number means; its position is the
            // price. See docs/accessibility.md, "Counting things".
            //
            // Deliberately no `container: true`: the node must merge into the
            // entry the bar builds, the one that carries the name, the id and
            // the press.
            final spokenCount = context.parseL10n(
              'common_SemanticsValue_unreadCount',
              arguments: [count],
              // A host without the app's translations still gets a working
              // bar; the badge simply stays silent rather than red-screening
              // the navigation.
              fallback: '',
            );
            return Positioned(
              right: 0,
              bottom: 0,
              child: Semantics(
                value: spokenCount,
                child: CountBadge(count: count, size: 14),
              ),
            );
          },
        ),
      ],
    );
  }
}
