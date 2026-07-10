import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../contacts.dart';

class ContactsExternalTab extends StatefulWidget {
  const ContactsExternalTab({super.key});

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
      final tabBloc = context.read<ContactsExternalTabBloc>();
      tabBloc.add(const ContactsExternalTabRefreshed());
      await tabBloc.stream.firstWhere((state) => state.status != ContactsExternalTabStatus.inProgress);
    }

    return BlocBuilder<ContactsExternalTabBloc, ContactsExternalTabState>(
      builder: (context, state) {
        if (state.contacts.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: refreshContacts,
            child: ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];

                return ContactTileAdapter(
                  tileKey: contactsExtContactTileKey,
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
