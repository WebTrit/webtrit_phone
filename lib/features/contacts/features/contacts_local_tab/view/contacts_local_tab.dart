import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../../contacts.dart';

class ContactsLocalTab extends StatelessWidget {
  const ContactsLocalTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsLocalTabBloc, ContactsLocalTabState>(
      builder: (context, state) {
        if (state.status == ContactsLocalTabStatus.initial || state.status == ContactsLocalTabStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == ContactsLocalTabStatus.permissionFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.contacts_LocalTabText_permissionFailure,
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () => openAppSettings(),
                  child: Text(context.l10n.contacts_LocalTabButton_openAppSettings),
                ),
              ],
            ),
          );
        } else if (state.contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                displayName: contact.name,
                thumbnail: contact.thumbnail,
                onTap: () async {
                  context.goNamed(MainRoute.contactsDetails, pathParameters: {
                    contactIdPathParameterName: contact.id.toString(),
                  });
                },
              );
            },
          );
        } else {
          late final List<Widget> children;
          if (state.status == ContactsLocalTabStatus.failure) {
            children = [
              Text(context.l10n.contacts_LocalTabText_failure),
            ];
          } else {
            if (state.searching) {
              children = [
                Text(context.l10n.contacts_LocalTabText_emptyOnSearching),
              ];
            } else {
              children = [
                Text(context.l10n.contacts_LocalTabText_empty),
                TextButton(
                  onPressed: () => context.read<ContactsLocalTabBloc>().add(const ContactsLocalTabRefreshed()),
                  child: Text(context.l10n.contacts_LocalTabButton_refresh),
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
