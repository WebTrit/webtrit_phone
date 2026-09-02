import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ContactEmailTile extends StatelessWidget {
  const ContactEmailTile({super.key, required this.address, required this.label, this.index = 0, this.onEmailPressed});

  final String address;
  final String label;

  /// Position of the address on the card; a contact can carry several, and
  /// every row offers the same button, so the ids are numbered by it.
  final int index;

  final VoidCallback? onEmailPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      title: CopyToClipboard(data: address, child: Text(address)),
      subtitle: label.isEmpty ? null : Text(label),
      trailing: onEmailPressed != null
          ? SemanticAction(
              label: context.l10n.contact_SemanticsLabel_sendEmail(address),
              identifier: numberedId(contactEmailSendId, index),
              child: IconButton(splashRadius: 24, icon: const Icon(Icons.email), onPressed: onEmailPressed),
            )
          : null,
    );
  }
}
