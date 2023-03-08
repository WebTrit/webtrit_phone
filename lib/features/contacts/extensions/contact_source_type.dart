import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../../blocs/external_contacts_sync/external_contacts_sync_bloc.dart';
import '../../../blocs/local_contacts_sync/local_contacts_sync_bloc.dart';
import '../contacts.dart';
import '../features/contacts_external_tab/contacts_external_tab.dart';
import '../features/contacts_local_tab/contacts_local_tab.dart';

extension ContactSourceTypeBuilder on ContactSourceType {
  Widget builder(BuildContext context) {
    switch (this) {
      case ContactSourceType.local:
        const widget = ContactsLocalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsSearchBloc>();
            return ContactsLocalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              localContactsSyncBloc: context.read<LocalContactsSyncBloc>(),
            )..add(ContactsLocalTabStarted(search: contactsSearchBloc.state));
          },
          child: widget,
        );
        return provider;
      case ContactSourceType.external:
        const widget = ContactsExternalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsSearchBloc>();
            return ContactsExternalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              externalContactsSyncBloc: context.read<ExternalContactsSyncBloc>(),
            )..add(ContactsExternalTabStarted(search: contactsSearchBloc.state));
          },
          child: widget,
        );
        return provider;
    }
  }
}
