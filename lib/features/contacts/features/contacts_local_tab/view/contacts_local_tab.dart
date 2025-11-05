import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/extension/elevated_button_styles.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../contacts.dart';

class ContactsLocalTab extends StatelessWidget {
  const ContactsLocalTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final elevatedButtonStyles = theme.extension<ElevatedButtonStyles>();

    Future routeToContactScreen(int contactId) async {
      context.router.navigate(ContactScreenPageRoute(contactId: contactId));
    }

    Future routeToDiagnosticScreen() async {
      context.router.push(const SettingsRouterPageRoute(children: [DiagnosticScreenPageRoute()]));
    }

    Future refreshContacts() async {
      final tabBloc = context.read<ContactsLocalTabBloc>();
      tabBloc.add(const ContactsLocalTabRefreshed());
      await tabBloc.stream.firstWhere((state) => state.status != ContactsLocalTabStatus.inProgress);
    }

    return BlocBuilder<ContactsLocalTabBloc, ContactsLocalTabState>(
      builder: (context, state) {
        if (state.status == ContactsLocalTabStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ContactsLocalTabStatus.permissionFailure) {
          return NoDataPlaceholder(
            content: Text(context.l10n.contacts_LocalTabText_permissionFailure),
            actions: [
              TextButton(
                onPressed: () => openAppSettings(),
                child: Text(context.l10n.contacts_LocalTabButton_openAppSettings, textAlign: TextAlign.center),
              ),
            ],
          );
        } else if (state.contacts.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: refreshContacts,
            child: ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ContactTile(
                  key: contactsLocalContactTileKey,
                  displayName: contact.displayTitle,
                  thumbnail: contact.thumbnail,
                  thumbnailUrl: contact.thumbnailUrl,
                  onTap: () => routeToContactScreen(contact.id),
                );
              },
            ),
          );
        } else {
          if (state.status == ContactsLocalTabStatus.failure) {
            return NoDataPlaceholder(content: Text(context.l10n.contacts_LocalTabText_failure));
          }
          if (state.status == ContactsLocalTabStatus.contactsAgreementFailure) {
            return NoDataPlaceholder(
              content: Column(
                children: [
                  Text(context.l10n.contacts_LocalTabText_contactsAgreementFailure),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: routeToDiagnosticScreen,
                    style: elevatedButtonStyles?.neutral,
                    child: Text(context.l10n.contacts_LocalTabButton_contactsAgreement),
                  ),
                  TextButton(
                    onPressed: refreshContacts,
                    style: elevatedButtonStyles?.neutral,
                    child: Text(context.l10n.contacts_LocalTabButton_refresh),
                  ),
                ],
              ),
            );
          } else {
            if (state.searching) {
              return NoDataPlaceholder(content: Text(context.l10n.contacts_LocalTabText_emptyOnSearching));
            } else {
              return NoDataPlaceholder(
                content: Text(context.l10n.contacts_LocalTabText_empty),
                actions: [
                  TextButton(onPressed: refreshContacts, child: Text(context.l10n.contacts_LocalTabButton_refresh)),
                ],
              );
            }
          }
        }
      },
    );
  }
}
