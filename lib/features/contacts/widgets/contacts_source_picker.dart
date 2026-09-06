import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

/// Picks which list is drawn, as a compact control that opens the line under
/// the title: one address book, or the favourites a person has kept.
///
/// Compact because it is the rarest thing a person changes on this screen -
/// seldom, and never twice in a row - so it is given the room a word needs
/// and no more, which is what leaves the line to the search box.
/// Size of the icons this control is built from, and the space between them:
/// a size down from the controls beside it, because it is a line of text with
/// marks around it rather than a button.
const _pickerIconSize = 20.0;
const _pickerGap = 8.0;
const _pickerMenuGap = 12.0;

class ContactsSourcePicker extends StatelessWidget {
  const ContactsSourcePicker({super.key, required this.selections, required this.selected, required this.onSelected});

  final List<ContactsListSelection> selections;
  final ContactsListSelection selected;
  final ValueChanged<ContactsListSelection> onSelected;

  IconData _icon(ContactsListSelection selection) => switch (selection) {
    ContactsSourceSelection(sourceType: ContactSourceType.local) => Icons.smartphone_outlined,
    ContactsSourceSelection(sourceType: ContactSourceType.external) => Icons.cloud_outlined,
    // Outlined like the two beside it: the check mark of the open menu says
    // which entry is on, so a filled star would answer that a second time.
    ContactsFavoritesSelection() => Icons.star_outline,
  };

  /// The anchor automation reaches the favourites entry by.
  ///
  /// Only that entry carries one: it replaced a control of the title row that
  /// had an identifier of its own, and dropping the anchor rather than moving
  /// it is what breaks an end-to-end run while every widget test stays green.
  Key? _itemKey(ContactsListSelection selection) =>
      selection is ContactsFavoritesSelection ? contactsSourceFavoritesKey : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Semantics(
      label: l10n.contacts_ContactsScreen_sourceSemanticsLabel,
      identifier: contactsSourcePickerId,
      button: true,
      child: PopupMenuButton<ContactsListSelection>(
        key: contactsSourcePickerKey,
        initialValue: selected,
        onSelected: onSelected,
        tooltip: l10n.contacts_ContactsScreen_sourceSemanticsLabel,
        itemBuilder: (context) => [
          for (final selection in selections)
            PopupMenuItem(
              key: _itemKey(selection),
              value: selection,
              child: Row(
                spacing: _pickerMenuGap,
                children: [
                  Icon(_icon(selection), size: _pickerIconSize),
                  Expanded(child: Text(selection.l10n(context))),
                  if (selection == selected) Icon(Icons.check, size: _pickerIconSize, color: theme.colorScheme.primary),
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
            spacing: _pickerGap,
            children: [
              Icon(_icon(selected), size: _pickerIconSize, color: theme.colorScheme.onSurfaceVariant),
              Text(selected.l10n(context), style: theme.textTheme.bodyMedium),
              Icon(Icons.expand_more, size: _pickerIconSize, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
