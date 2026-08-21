import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';

/// Least space left between the chooser and the button beside it, so a long
/// address book name stops short of the circle rather than against it.
const _controlGap = 10.0;

/// The line under the title of a contacts screen: the search box, and on the
/// screen that has one, the address book chooser that shares the line with
/// it.
///
/// A widget rather than a block inside one screen because the keys and
/// identifiers automation finds the box by are an interface: a second contacts
/// layout that spelled them out again would drift from this one silently, and
/// the tests would still pass against whichever copy they happened to find.
class ContactsSearchRow extends StatelessWidget {
  const ContactsSearchRow({
    super.key,
    this.leading,
    this.width,
    this.searching = true,
    this.onSearchOpened,
    this.onSearchClosed,
  });

  /// Takes the line while the box is closed.
  final Widget? leading;

  /// Whether the box itself is shown. With no [leading] there is nothing else
  /// to put on the line, so the box is always open.
  final bool searching;

  /// Called by the round button that opens the box.
  final VoidCallback? onSearchOpened;

  /// Called by the box's own cross once the box is open and already empty.
  final VoidCallback? onSearchClosed;

  /// How wide the row is, when it has to line up with something above it.
  /// Null takes the whole line, which is what the screen without the filter
  /// does.
  final double? width;

  /// What this row asks of the app bar, so a caller sizing the bar does not
  /// have to know how the row is built.
  static const height = kMainAppBarBottomSearchHeight;

  @override
  Widget build(BuildContext context) {
    final width = this.width;

    return Padding(
      padding: EdgeInsets.only(
        left: width == null ? kMainAppBarBottomPaddingGap : 0,
        right: width == null ? kMainAppBarBottomPaddingGap : 0,
        bottom: kMainAppBarBottomPaddingGap,
      ),
      // Centred like whatever sits above it, so the two line up on both sides.
      child: Align(
        heightFactor: 1,
        child: SizedBox(
          width: width,
          child: IgnoreUnfocuser(
            child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                final contactsBloc = context.read<ContactsBloc>();
                final leading = this.leading;

                // Nothing to share the line with, so nothing to close the box
                // back into: it takes the line and keeps it, and a button to
                // open what is already open would only cost a tap.
                final pinned = leading == null;

                final field = ClearedTextField(
                  key: contactsSearchInputKey,
                  identifier: contactsSearchInputId,
                  clearButtonKey: contactsSearchInputClearKey,
                  clearButtonIdentifier: contactsSearchInputClearId,
                  initialValue: state.search,
                  onChanged: (value) => contactsBloc.add(ContactsSearchChanged(value)),
                  onSubmitted: (value) => contactsBloc.add(ContactsSearchSubmitted(value)),
                  // Only where the box is something you leave: pinned, a
                  // cross that took it away would leave the line empty.
                  onDismissed: pinned ? null : onSearchClosed,
                  iconConstraints: const BoxConstraints.expand(
                    width: kMainAppBarBottomControlHeight,
                    height: kMainAppBarBottomControlHeight,
                  ),
                );

                if (pinned || searching) return field;

                // Closed, the line belongs to the chooser - which is what
                // leaves it room for a name long enough to read. Opened, the
                // box takes the whole line, and its own cross is the way back.
                return Row(
                  spacing: _controlGap,
                  children: [
                    Expanded(child: leading),
                    ContactsRoundButton(
                      buttonKey: contactsSearchOpenKey,
                      identifier: contactsSearchOpenId,
                      label: context.l10n.contacts_ContactsScreen_searchSemanticsLabel,
                      icon: Icons.search,
                      onTap: onSearchOpened,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// A round button of the line under the title, in the size every other control
/// there uses.
class ContactsRoundButton extends StatelessWidget {
  const ContactsRoundButton({
    super.key,
    required this.buttonKey,
    required this.identifier,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final Key buttonKey;
  final String identifier;
  final String label;
  final IconData icon;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Named from outside the tap target rather than inside it: an identifier
    // put on the icon opens a boundary of its own, and what comes out is one
    // node carrying the name and another carrying the press.
    return SemanticAction.button(
      label: label,
      identifier: identifier,
      child: SizedBox.square(
        dimension: kMainAppBarBottomControlHeight,
        child: Material(
          color: colors.surfaceContainerHigh,
          shape: const CircleBorder(),
          child: InkWell(
            key: buttonKey,
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(icon, color: colors.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}
