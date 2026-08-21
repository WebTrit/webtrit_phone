import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';

/// The search field of the contacts screen, with the keys and identifiers
/// automation and the accessibility tests address it by.
///
/// A widget rather than a block inside one screen because those identifiers
/// are an interface: a second contacts layout that spelled them out again
/// would drift from this one silently, and the tests would still pass against
/// whichever copy they happened to find.
class ContactsSearchRow extends StatelessWidget {
  const ContactsSearchRow({super.key, this.leading});

  /// Sits on the same line as the box, to the left of it. The row is the only
  /// full-width thing under the title, so a control that belongs beside the
  /// box goes here rather than taking a line of its own.
  final Widget? leading;

  /// What this row asks of the app bar, so a caller sizing the bar does not
  /// have to know how the row is built.
  static const height = kMainAppBarBottomSearchHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kMainAppBarBottomPaddingGap,
        right: kMainAppBarBottomPaddingGap,
        bottom: kMainAppBarBottomPaddingGap,
      ),
      child: IgnoreUnfocuser(
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            final contactsBloc = context.read<ContactsBloc>();

            final field = ClearedTextField(
              key: contactsSearchInputKey,
              identifier: contactsSearchInputId,
              clearButtonKey: contactsSearchInputClearKey,
              clearButtonIdentifier: contactsSearchInputClearId,
              initialValue: state.search,
              onChanged: (value) => contactsBloc.add(ContactsSearchChanged(value)),
              onSubmitted: (value) => contactsBloc.add(ContactsSearchSubmitted(value)),
              iconConstraints: const BoxConstraints.expand(
                width: kMainAppBarBottomControlHeight,
                height: kMainAppBarBottomControlHeight,
              ),
            );

            final leading = this.leading;
            if (leading == null) return field;

            return Row(
              spacing: kMainAppBarBottomPaddingGap,
              children: [
                leading,
                Expanded(child: field),
              ],
            );
          },
        ),
      ),
    );
  }
}
