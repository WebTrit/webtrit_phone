import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/main/extensions/extensions.dart';
import 'package:webtrit_phone/features/main/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.tabs,
    required this.currentIndex,
    this.onTabSelected,
    this.decorateTabIcon,
    this.transferInProgress = false,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;

  /// The screen owns its navigation bar: hosts hand over the configured tabs
  /// and the selection instead of a bar-shaped widget, so every host - the
  /// app and the previews - shows the real control.
  final List<BottomMenuTab> tabs;

  /// Position of the open tab in [tabs].
  final int currentIndex;

  /// Null renders the bar inert - a static preview shows it without wiring.
  final ValueChanged<int>? onTabSelected;

  /// Null draws icons bare; see [TabIconDecorator].
  final TabIconDecorator? decorateTabIcon;

  /// Whether a call is waiting for somewhere to be transferred to.
  ///
  /// Said here rather than by each section, because the bottom of the screen
  /// belongs to this screen: a section drawing its own banner draws it beneath
  /// the bar this one floats over, where nobody sees it.
  final bool transferInProgress;

  @override
  Widget build(BuildContext context) {
    // Only where the open section has a destination to offer. Told on a page
    // of conversations, the banner would announce a choice that cannot be made
    // there. Looked up softly for the same one-frame window the host clamps
    // for: a configuration reload can shrink the tab set while the index still
    // points past it.
    final announcesTransfer =
        transferInProgress && (tabs.elementAtOrNull(currentIndex)?.flavor.offersTransferDestination ?? false);

    final transferBanner = announcesTransfer
        ? TransferBottomNavigationBar(context.l10n.main_Text_blindTransferInitiated)
        : null;

    // The screen is the one home of the bar-visibility rule for every host,
    // the previews included: a menu of one section shows no bar - there is
    // nothing to switch to - and the section's own scaffolding fills the
    // screen. The banner still has to be said, and with no bar of ours to
    // float over it there is nothing to keep it clear of.
    if (tabs.length < 2) {
      if (transferBanner == null) return body;
      return Scaffold(
        body: body,
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), child: transferBanner),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      body: body,
      // Above the bar, not behind it. Both belong to this screen, so they are
      // one bottom-of-the-screen widget and the body is inset by their total.
      // One pane of glass over both. Blurring them separately would show the
      // seam - two filters sampling different backdrops - and the banner is
      // the same kind of surface as the bar, not something floating over it.
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Both are bars across the screen. Left to itself a Column hands
            // each child only the width it asks for, and the banner - a box
            // around a line of text - would sit centred and half as wide as
            // the bar under it, reading as a label rather than as the state of
            // the screen.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ?transferBanner,
              MainBottomNavigationBar(
                tabs: tabs,
                currentIndex: currentIndex,
                onTap: onTabSelected,
                decorateIcon: decorateTabIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
