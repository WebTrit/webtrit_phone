import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// The contacts screen of a deployment that offers favourites as a filter
/// inside the list rather than as a section of their own.
///
/// A screen of its own rather than a switch inside the existing one: the two
/// arrange the same lists differently enough that one widget serving both
/// would be a pile of conditions, and a deployment that keeps the current
/// screen must not be able to reach the other by accident. The lists, the
/// search box and the row are the same pieces in both.
@RoutePage()
class ContactsFilterScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactsFilterScreenPage({required this.selections});

  /// What the chooser offers, decided by the tab configuration rather than
  /// here - see `ContactsBottomMenuTab.listSelections`.
  final List<ContactsListSelection> selections;

  static PageRouteInfo<dynamic>? getPageRouteInfo(RouteMatch route, List<ContactsListSelection> Function() selections) {
    final featureRoute = route.findRouteWithRequiredParams(ContactsFilterScreenPageRoute.page);
    return featureRoute != null ? ContactsFilterScreenPageRoute(selections: selections()) : null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ContactsBloc(activeContactSourceTypeRepository: context.read<ActiveContactSourceTypeRepository>()),
        ),
        // Above the screen rather than inside its body: the button that turns
        // rearranging on lives in the scaffold and reads this list too.
        BlocProvider(
          create: (context) =>
              FavoritesBloc(favoritesRepository: context.read<FavoritesRepository>())..add(const FavoritesStarted()),
        ),
      ],
      child: ContactsFilterScreen(
        title: Text(EnvironmentConfig.APP_NAME),
        selections: selections,
        sourceTypeWidgetBuilder: contactSourceTypeWidgetBuilder,
        favoritesWidgetBuilder: contactsFavoritesWidgetBuilder,
      ),
    );
  }
}
