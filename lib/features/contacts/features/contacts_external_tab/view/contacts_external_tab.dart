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
        if (state.status == ContactsExternalTabStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.contacts.isNotEmpty) {
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
        } else {
          if (state.status == ContactsExternalTabStatus.failure) {
            return NoDataPlaceholder(content: Text(context.l10n.contacts_ExternalTabText_failure));
          } else {
            if (state.searching) {
              return NoDataPlaceholder(content: Text(context.l10n.contacts_ExternalTabText_emptyOnSearching));
            } else {
              return NoDataPlaceholder(
                content: Text(context.l10n.contacts_ExternalTabText_empty),
                actions: [
                  TextButton(onPressed: refreshContacts, child: Text(context.l10n.contacts_ExternalTabButton_refresh)),
                ],
              );
            }
          }
        }
      },
    );
  }
}
