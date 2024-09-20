import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ContactsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactsScreenPage({
    required this.sourceTypes,
  });

  final List<ContactSourceType> sourceTypes;

  static PageRouteInfo<dynamic>? getPageRouteInfo(RouteMatch route, List<ContactSourceType> Function() sourceTypes) {
    final featureRoute = route.findRouteWithRequiredParams(ContactsScreenPageRoute.page);
    return featureRoute != null ? ContactsScreenPageRoute(sourceTypes: sourceTypes()) : null;
  }

  @override
  Widget build(BuildContext context) {
    final widget = ContactsScreen(
      title: const Text(EnvironmentConfig.APP_NAME),
      sourceTypes: sourceTypes,
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
