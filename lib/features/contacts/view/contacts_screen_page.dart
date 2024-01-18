import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ContactsTabPage extends AutoRouter {
  const ContactsTabPage({super.key});
}

@RoutePage()
class ContactsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactsScreenPage();

  @override
  Widget build(BuildContext context) {
    final widget = ContactsScreen(
      title: const Text(EnvironmentConfig.APP_NAME),
      sourceTypes: const [
        ContactSourceType.local,
        ContactSourceType.external,
      ],
      sourceTypeWidgetBuilder: _contactSourceTypeWidgetBuilder,
    );
    final provider = BlocProvider(
      create: (context) => ContactsBloc(
        appPreferences: context.read<AppPreferences>(),
      ),
      child: widget,
    );
    return provider;
  }

  Widget _contactSourceTypeWidgetBuilder(BuildContext context, ContactSourceType sourceType) {
    switch (sourceType) {
      case ContactSourceType.local:
        const widget = ContactsLocalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsBloc>();
            return ContactsLocalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              localContactsSyncBloc: context.read<LocalContactsSyncBloc>(),
            )..add(ContactsLocalTabStarted(search: contactsSearchBloc.state.search));
          },
          child: widget,
        );
        return provider;
      case ContactSourceType.external:
        const widget = ContactsExternalTab();
        final provider = BlocProvider(
          create: (context) {
            final contactsSearchBloc = context.read<ContactsBloc>();
            return ContactsExternalTabBloc(
              contactsRepository: context.read<ContactsRepository>(),
              contactsSearchBloc: contactsSearchBloc,
              externalContactsSyncBloc: context.read<ExternalContactsSyncBloc>(),
            )..add(ContactsExternalTabStarted(search: contactsSearchBloc.state.search));
          },
          child: widget,
        );
        return provider;
    }
  }
}
