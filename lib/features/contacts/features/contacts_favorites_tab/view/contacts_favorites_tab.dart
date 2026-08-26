import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../contacts.dart';

/// The favourites of every address book, drawn with the rows the other lists
/// use so a person recognises them.
///
/// A star on every row, because a row is here for exactly one reason - a
/// favourite among its numbers - and the star is how it leaves again.
class ContactsFavoritesTab extends StatefulWidget {
  const ContactsFavoritesTab({super.key});

  @override
  State<ContactsFavoritesTab> createState() => _ContactsFavoritesTabState();
}

class _ContactsFavoritesTabState extends State<ContactsFavoritesTab> {
  int? _expandedContactId;

  void _toggleExpanded(int contactId) {
    setState(() => _expandedContactId = _expandedContactId == contactId ? null : contactId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsFavoritesTabBloc, ContactsFavoritesTabState>(
      builder: (context, state) {
        final contacts = state.contacts;

        if (contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return ContactTileAdapter(
                tileKey: contactsFavoriteContactTileKey,
                markFavorite: true,
                contact: contact,
                expanded: _expandedContactId == contact.id,
                onToggleExpanded: () => _toggleExpanded(contact.id),
              );
            },
          );
        }

        // Nothing read yet is not the same answer as nothing to show, and the
        // first read of a local query lands within a frame or two.
        if (state.status == ContactsFavoritesTabStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        // A search that matched nothing is a different answer from an address
        // book with no favourites in it, and only the second one is worth
        // telling someone how to fix.
        if (state.searching) {
          return NoDataPlaceholder(content: Text(context.l10n.contacts_FavoritesTabText_emptyOnSearching));
        }

        return NoDataPlaceholder(content: Text(context.l10n.contacts_ContactsScreen_emptyFavorites));
      },
    );
  }
}
