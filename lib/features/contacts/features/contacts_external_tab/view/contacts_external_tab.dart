import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../../contacts.dart';

class ContactsExternalTab extends StatelessWidget {
  const ContactsExternalTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsExternalTabBloc, ContactsExternalTabState>(
      builder: (context, state) {
        if (state.status == ContactsExternalTabStatus.initial || state.status == ContactsExternalTabStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                displayName: contact.name,
                onTap: () async {
                  context.goNamed(MainRoute.contact, params: {contactIdPathParameterName: contact.id.toString()});
                },
              );
            },
          );
        } else {
          late final List<Widget> children;
          if (state.status == ContactsExternalTabStatus.failure) {
            children = [
              Text(context.l10n.contacts_ExternalTabText_failure),
            ];
          } else {
            if (state.searching) {
              children = [
                Text(context.l10n.contacts_ExternalTabText_emptyOnSearching),
              ];
            } else {
              children = [
                Text(context.l10n.contacts_ExternalTabText_empty),
                TextButton(
                  onPressed: () => context.read<ContactsExternalTabBloc>().add(const ContactsExternalTabRefreshed()),
                  child: Text(context.l10n.contacts_ExternalTabButton_refresh),
                ),
              ];
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
        }
      },
    );
  }
}
