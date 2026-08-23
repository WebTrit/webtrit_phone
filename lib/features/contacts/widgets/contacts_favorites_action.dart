import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// The star on the title row that narrows the list to favourites.
///
/// It keeps company with the controls that belong to the whole screen rather
/// than sitting on the line below: that line says which address book is shown
/// and lets it be searched, and a filter is neither. Built like the other
/// controls of that row, so it reads as one of them and not as a guest.
class ContactsFavoritesAction extends StatelessWidget {
  const ContactsFavoritesAction({super.key, required this.selected, this.onTap});

  /// Filled and in the accent colour while on. A control that stays pressed
  /// has to look different from one that was merely tapped, and the shape
  /// carries the state as well as the colour, so it survives a palette that
  /// tells the two apart poorly.
  final bool selected;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SemanticAction.button(
      label: context.l10n.contacts_ContactsScreen_filterFavorites,
      identifier: contactsFilterFavoritesId,
      child: Semantics(
        selected: selected,
        child: SizedBox(
          width: kMinInteractiveDimension,
          height: kMinInteractiveDimension,
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                key: contactsFilterFavoritesKey,
                onTap: onTap,
                child: Center(
                  child: Icon(
                    selected ? Icons.star : Icons.star_border,
                    color: selected ? colorScheme.tertiary : colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
