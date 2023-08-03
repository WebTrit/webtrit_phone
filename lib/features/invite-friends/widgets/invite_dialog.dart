import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../theme/elevated_button_styles.dart';

class InviteDialog extends StatelessWidget {
  const InviteDialog({
    super.key,
    required this.onInvite,
    required this.onHide,
  });

  final Function() onInvite;
  final Function() onHide;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.inviteFriends_Dialog_title,
              style: themeData.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onInvite,
              style: elevatedButtonStyles?.primary,
              child: Text(
                context.l10n.inviteFriends_Dialog_invite,
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: onHide,
              child: Text(
                context.l10n.inviteFriends_Dialog_close,
                style: themeData.textTheme.labelMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
