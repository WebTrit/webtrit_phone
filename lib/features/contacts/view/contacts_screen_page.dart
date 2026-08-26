import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ContactsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactsScreenPage({required this.sourceTypes});

  final List<ContactSourceType> sourceTypes;

  static PageRouteInfo<dynamic>? getPageRouteInfo(RouteMatch route, List<ContactSourceType> Function() sourceTypes) {
    final featureRoute = route.findRouteWithRequiredParams(ContactsScreenPageRoute.page);
    return featureRoute != null ? ContactsScreenPageRoute(sourceTypes: sourceTypes()) : null;
  }

  @override
  Widget build(BuildContext context) {
    final widget = ContactsScreen(
      title: Text(EnvironmentConfig.APP_NAME),
      sourceTypes: sourceTypes,
      sourceTypeWidgetBuilder: contactSourceTypeWidgetBuilder,
    );
    final provider = BlocProvider(
      create: (context) =>
          ContactsBloc(activeContactSourceTypeRepository: context.read<ActiveContactSourceTypeRepository>()),
      child: widget,
    );
    return provider;
  }
}

/// Mounts the list of one contact source with the blocs that feed it.
///
/// Shared by both contacts screens: the arrangement around the lists differs
/// between them, the lists themselves do not.
Widget contactSourceTypeWidgetBuilder(
  BuildContext context,
  ContactSourceType sourceType, {
  bool markFavorites = false,
}) {
  switch (sourceType) {
    case ContactSourceType.local:
      final widget = ContactsLocalTab(markFavorites: markFavorites);
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
      final widget = ContactsExternalTab(markFavorites: markFavorites);
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

/// Mounts the list one selection of the unified arrangement stands for.
///
/// The address books are the very lists the tabbed screen draws, so they go
/// through [contactSourceTypeWidgetBuilder]; favourites are a list of their
/// own, spanning every address book, and have a bloc to match.
///
/// Stars on every row here, on none there: this is the arrangement favourites
/// are reachable from, and a star that leads nowhere is worse than no star.
Widget contactsListSelectionWidgetBuilder(BuildContext context, ContactsListSelection selection) {
  switch (selection) {
    case ContactsSourceSelection(:final sourceType):
      return contactSourceTypeWidgetBuilder(context, sourceType, markFavorites: true);
    case ContactsFavoritesSelection():
      return BlocProvider(
        create: (context) {
          final contactsSearchBloc = context.read<ContactsBloc>();
          return ContactsFavoritesTabBloc(
            contactsRepository: context.read<ContactsRepository>(),
            contactsSearchBloc: contactsSearchBloc,
          )..add(ContactsFavoritesTabStarted(search: contactsSearchBloc.state.search));
        },
        child: const ContactsFavoritesTab(),
      );
  }
}
