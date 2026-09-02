import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// What the bar above the message field is there for.
enum ExchangeKind { reply, edit, forward }

/// The bar that sits above the message field while a message is being replied
/// to, changed or passed on.
///
/// Everything that tells the three apart - the icon, the spoken name, the id -
/// comes from [kind]: on the screen the difference is a small icon, and a
/// screen reader has nothing at all to go by otherwise.
class ExchangeBar extends StatelessWidget {
  const ExchangeBar({super.key, required this.kind, required this.text, required this.onCancel, this.onConfirm})
    : assert(
        onConfirm == null || kind == ExchangeKind.forward,
        'only a message being passed on is confirmed from the bar',
      );

  final ExchangeKind kind;
  final String text;
  final Function() onCancel;
  final Function()? onConfirm;

  IconData get _icon => switch (kind) {
    ExchangeKind.reply => Icons.reply,
    ExchangeKind.edit => Icons.edit_note,
    ExchangeKind.forward => Icons.forward,
  };

  String get _identifier => switch (kind) {
    ExchangeKind.reply => messageReplyBarId,
    ExchangeKind.edit => messageEditBarId,
    ExchangeKind.forward => messageForwardBarId,
  };

  String _label(BuildContext context) => switch (kind) {
    ExchangeKind.reply => context.l10n.messaging_SemanticsLabel_replying,
    ExchangeKind.edit => context.l10n.messaging_SemanticsLabel_editing,
    ExchangeKind.forward => context.l10n.messaging_SemanticsLabel_forwarding,
  };

  String _cancelLabel(BuildContext context) => switch (kind) {
    ExchangeKind.reply => context.l10n.messaging_SemanticsLabel_stopReplying,
    ExchangeKind.edit => context.l10n.messaging_SemanticsLabel_stopEditing,
    ExchangeKind.forward => context.l10n.messaging_SemanticsLabel_stopForwarding,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      child: Container(
        color: theme.primaryColor.withAlpha(200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const SizedBox(width: 8),
            // The icon says nothing of its own; the name in front of the
            // quoted message is what carries the difference.
            Icon(_icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              // Not a control - a stop that reads "Replying to, <the message>",
              // so the name and the quoted text arrive together.
              child: MergeSemantics(
                child: Semantics(
                  label: _label(context),
                  identifier: _identifier,
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                    overflow: .ellipsis,
                  ),
                ),
              ),
            ),
            if (onConfirm != null) ...[
              const SizedBox(width: 8),
              SemanticAction(
                label: context.l10n.messaging_SemanticsLabel_sendForward,
                identifier: messageExchangeConfirmId,
                child: IconButton(icon: const Icon(Icons.check), onPressed: onConfirm, color: Colors.white),
              ),
            ],
            const SizedBox(width: 8),
            SemanticAction(
              label: _cancelLabel(context),
              identifier: messageExchangeCancelId,
              child: IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
