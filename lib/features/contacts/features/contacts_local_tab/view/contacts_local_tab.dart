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

class ContactsLocalTab extends StatefulWidget {
  const ContactsLocalTab({super.key});

  @override
  State<ContactsLocalTab> createState() => _ContactsLocalTabState();
}

class _ContactsLocalTabState extends State<ContactsLocalTab> with WidgetsBindingObserver {
  int? _expandedContactId;

  void _toggleExpanded(int contactId) {
    setState(() => _expandedContactId = _expandedContactId == contactId ? null : contactId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh contacts when the app is resumed.
      // This is to account for cases where contacts were updated while the app was collapsed,
      // or if the user changed contact permissions in the background,
      // which is a common scenario on Android.
      _refreshContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final elevatedButtonStyles = theme.extension<ElevatedButtonStyles>();

    Future routeToDiagnosticScreen() async {
      FocusScope.of(context).unfocus();
      context.router.push(const SettingsRouterPageRoute(children: [DiagnosticScreenPageRoute()]));
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
            onRefresh: _refreshContacts,
            child: ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ContactTileAdapter(
                  tileKey: contactsLocalContactTileKey,
                  contact: contact,
                  expanded: _expandedContactId == contact.id,
                  onToggleExpanded: () => _toggleExpanded(contact.id),
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
                    onPressed: _refreshContacts,
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
                  TextButton(onPressed: _refreshContacts, child: Text(context.l10n.contacts_LocalTabButton_refresh)),
                ],
              );
            }
          }
        }
      },
    );
  }

  Future<void> _refreshContacts() async {
    final tabBloc = context.read<ContactsLocalTabBloc>();
    tabBloc.add(const ContactsLocalTabRefreshed());
    await tabBloc.stream.firstWhere((state) => state.status != ContactsLocalTabStatus.inProgress);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
