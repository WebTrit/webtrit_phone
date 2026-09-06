import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// The mailbox with nothing in it.
class EmptyMailboxView extends StatelessWidget {
  const EmptyMailboxView({super.key});

  @override
  Widget build(BuildContext context) {
    // A scrollable, so the pull to refresh keeps working while the list is
    // empty - and one that accepts a drag it has no room to scroll, or the
    // gesture never reaches the indicator above it.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: Text(context.l10n.voicemail_Label_empty)),
        ),
      ],
    );
  }
}
