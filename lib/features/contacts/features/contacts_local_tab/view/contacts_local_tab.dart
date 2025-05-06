import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
          return NoDataPlaceholder(
            content: Text(context.l10n.contacts_LocalTabText_permissionFailure),
            actions: [
              TextButton(
                onPressed: () => openAppSettings(),
                child: Text(
                  context.l10n.contacts_LocalTabButton_openAppSettings,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else if (state.contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              final contact = state.contacts[index];
              return ContactTile(
                key: contactsLocalContactTileKey,
                displayName: contact.displayTitle,
                thumbnail: contact.thumbnail,
                thumbnailUrl: contact.thumbnailUrl,
                onTap: () {
                  context.router.navigate(ContactScreenPageRoute(
                    contactId: contact.id,
                  ));
                },
              );
            },
          );
        } else {
          if (state.status == ContactsLocalTabStatus.failure) {
            return NoDataPlaceholder(
              content: Text(context.l10n.contacts_LocalTabText_failure),
            );
          } else {
            if (state.searching) {
              return NoDataPlaceholder(
                content: Text(context.l10n.contacts_LocalTabText_emptyOnSearching),
              );
            } else {
              return NoDataPlaceholder(
                content: Text(context.l10n.contacts_LocalTabText_empty),
                actions: [
                  TextButton(
                    onPressed: () => context.read<ContactsLocalTabBloc>().add(const ContactsLocalTabRefreshed()),
                    child: Text(context.l10n.contacts_LocalTabButton_refresh),
                  ),
                ],
              );
            }
          }
        }
      },
    );
  }
}
