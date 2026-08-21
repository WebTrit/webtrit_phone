import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

/// Picks which address book the list is drawn from, as a compact control that
/// sits beside the search box.
///
/// Compact because it is the rarer of the two choices on this screen: a person
/// changes address book seldom and filters the list often, so the filter takes
/// the wide control at the top and this takes the room a word needs.
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
        child: Container(
          height: kMainAppBarBottomControlHeight,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(kMainAppBarBottomControlHeight / 2),
          ),
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
