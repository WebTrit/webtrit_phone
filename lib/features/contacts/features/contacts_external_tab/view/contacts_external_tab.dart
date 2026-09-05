import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../contacts.dart';

class ContactsExternalTab extends StatefulWidget {
  const ContactsExternalTab({super.key, this.markFavorites = false});

  /// Whether a star marks the people with a favourite among their numbers.
  /// Only where favourites are reachable from this screen: a star that leads
  /// nowhere is worse than no star at all.
  final bool markFavorites;

  @override
  State<ContactsExternalTab> createState() => _ContactsExternalTabState();
}

class _ContactsExternalTabState extends State<ContactsExternalTab> {
  int? _expandedContactId;

  void _toggleExpanded(int contactId) {
    setState(() => _expandedContactId = _expandedContactId == contactId ? null : contactId);
  }

  @override
  Widget build(BuildContext context) {
    Future refreshContacts() async {
      // The indicator closes when the operation ends, so await the worker's
      // own single-flight cycle: waiting for a bloc state change instead
      // would spin forever when a finished sync leaves the status as it was.
      try {
        await context.read<ExternalContactsSyncWorker>().refresh();
      } on Exception {
        // With items on screen the status-driven failure placeholder is not
        // built, so the failed pull must be told here or it looks like a
        // silent no-op (same wording the account screen uses).
        if (context.mounted) {
          context.showErrorSnackBar(context.l10n.settings_registerStatusSnackBar_requestFailed);
        }
      }
    }

    return BlocBuilder<ContactsExternalTabBloc, ContactsExternalTabState>(
      builder: (context, state) {
        final contacts = state.contacts;

        if (contacts.isNotEmpty) {
          return RefreshIndicator(
            // See the local tab: the body runs behind the app bar, so the
            // spinner needs the same inset the list content is given, or it
            // is drawn underneath the bar.
            edgeOffset: MediaQuery.of(context).padding.top,
            onRefresh: refreshContacts,
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return ContactTileAdapter(
                  tileKey: contactsExtContactTileKey,
                  markFavorite: widget.markFavorites,
                  contact: contact,
                  expanded: _expandedContactId == contact.id,
                  onToggleExpanded: () => _toggleExpanded(contact.id),
                );
              },
            ),
          );
        }

        // No contacts to show yet: keep a loading indicator visible while the
        // initial remote fetch is still in flight, so an empty list is not
        // mistaken for "no data".
        switch (state.status) {
          case ContactsExternalTabStatus.initial:
          case ContactsExternalTabStatus.inProgress:
            return const Center(child: CircularProgressIndicator());
          case ContactsExternalTabStatus.failure:
            return NoDataPlaceholder(content: Text(context.l10n.contacts_ExternalTabText_failure));
          case ContactsExternalTabStatus.success:
            if (state.searching) {
              return NoDataPlaceholder(content: Text(context.l10n.contacts_ExternalTabText_emptyOnSearching));
            }
            return NoDataPlaceholder(
              content: Text(context.l10n.contacts_ExternalTabText_empty),
              actions: [
                TextButton(onPressed: refreshContacts, child: Text(context.l10n.contacts_ExternalTabButton_refresh)),
              ],
            );
        }
      },
    );
  }
}
