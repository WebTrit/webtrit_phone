import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubits/cubits.dart';

class VoicemailFlavorOverlay extends StatelessWidget {
  const VoicemailFlavorOverlay({required this.child, super.key});

  final Widget child;

  /// Bottom-bar icon decoration: overlays the unread counter on the voicemail
  /// section and leaves every other one untouched. Hand it to the bar from a
  /// host that provides a [VoicemailUnreadCubit] - the bar itself does not
  /// require one.
  static Widget forTab(BottomMenuTab tab, Widget icon) {
    return tab.flavor == MainFlavor.voicemail ? VoicemailFlavorOverlay(child: icon) : icon;
  }

  @override
  Widget build(BuildContext context) {
    // A host that hands [forTab] to the bar without providing the count gets a
    // bare icon, not a screen-wide provider error: the badge is an ornament and
    // must not be able to take the navigation down.
    //
    // `watch` alone follows the count: BlocProvider marks its dependents on
    // every emission.
    final unreadCount = context.watch<VoicemailUnreadCubit?>()?.state ?? 0;
    if (unreadCount == 0) return child;

    // The badge draws a glyph and says nothing of its own; the count travels as
    // the entry's VALUE. The caption belongs to the bar, which draws it after
    // this slot, so there is nothing of ours drawn later to hang the phrase on.
    // See docs/accessibility.md, "Counting things", and the messaging badge
    // next to this one.
    //
    // Deliberately no `container: true`: the node must merge into the entry the
    // bar builds, the one that carries the name, the id and the press.
    final spokenCount = context.parseL10n(
      'common_SemanticsValue_unreadCount',
      arguments: [unreadCount],
      // A host without the app's translations still gets a working bar; the
      // badge simply stays silent rather than red-screening the navigation.
      fallback: '',
    );

    return Stack(
      children: [
        child,
        Positioned(
          right: 0,
          bottom: 0,
          child: Semantics(
            value: spokenCount,
            child: CountBadge(count: unreadCount, size: 14),
          ),
        ),
      ],
    );
  }
}
