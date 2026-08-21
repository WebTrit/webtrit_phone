import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

/// Picks which address book the list is drawn from, as a compact control that
/// opens the line under the title.
///
/// Compact because it is the rarest thing a person changes on this screen -
/// seldom, and never twice in a row - so it is given the room a word needs
/// and no more, which is what leaves the line to the search box.
class ContactsSourcePicker extends StatelessWidget {
  const ContactsSourcePicker({super.key, required this.sourceTypes, required this.selected, required this.onSelected});

  final List<ContactSourceType> sourceTypes;
  final ContactSourceType selected;
  final ValueChanged<ContactSourceType> onSelected;

  IconData _icon(ContactSourceType sourceType) => switch (sourceType) {
    ContactSourceType.local => Icons.smartphone_outlined,
    ContactSourceType.external => Icons.cloud_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Semantics(
      label: l10n.contacts_ContactsScreen_sourceSemanticsLabel,
      identifier: contactsSourcePickerId,
      button: true,
      child: PopupMenuButton<ContactSourceType>(
        key: contactsSourcePickerKey,
        initialValue: selected,
        onSelected: onSelected,
        tooltip: l10n.contacts_ContactsScreen_sourceSemanticsLabel,
        itemBuilder: (context) => [
          for (final sourceType in sourceTypes)
            PopupMenuItem(
              value: sourceType,
              child: Row(
                spacing: 12,
                children: [
                  Icon(_icon(sourceType), size: 20),
                  Expanded(child: Text(sourceType.l10n(context))),
                  if (sourceType == selected) Icon(Icons.check, size: 20, color: theme.colorScheme.primary),
                ],
              ),
            ),
        ],
        // No pill of its own: the name, its icon and the chevron are the
        // control. A filled shape here would read as a second search box
        // beside the real one, and the line already carries enough of them.
        child: SizedBox(
          height: kMainAppBarBottomControlHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(_icon(selected), size: 20, color: theme.colorScheme.onSurfaceVariant),
              Text(selected.l10n(context), style: theme.textTheme.bodyMedium),
              Icon(Icons.expand_more, size: 20, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
