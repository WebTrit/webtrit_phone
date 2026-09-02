import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../view/conversations_screen.dart';

/// Starts a new conversation of the kind the current tab is about.
///
/// A plus sign alone says nothing, and here it means two different things -
/// a chat or a text message - so the name follows the tab rather than the icon.
class ConversationsNewButton extends StatelessWidget {
  const ConversationsNewButton({required this.tabType, required this.onPressed, this.backgroundColor, super.key});

  final TabType tabType;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = switch (tabType) {
      TabType.chat => context.l10n.messaging_SemanticsLabel_newChat,
      TabType.sms => context.l10n.messaging_SemanticsLabel_newSms,
    };

    return SemanticAction(
      label: label,
      identifier: conversationsNewId,
      child: FloatingActionButton(
        backgroundColor: backgroundColor ?? colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: onPressed,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }
}
