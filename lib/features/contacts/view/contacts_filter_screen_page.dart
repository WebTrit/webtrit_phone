import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../contacts.dart';

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
  const ContactsFilterScreenPage({required this.sourceTypes});

  final List<ContactSourceType> sourceTypes;

  static PageRouteInfo<dynamic>? getPageRouteInfo(RouteMatch route, List<ContactSourceType> Function() sourceTypes) {
    final featureRoute = route.findRouteWithRequiredParams(ContactsFilterScreenPageRoute.page);
    return featureRoute != null ? ContactsFilterScreenPageRoute(sourceTypes: sourceTypes()) : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactsBloc(activeContactSourceTypeRepository: context.read<ActiveContactSourceTypeRepository>()),
      child: ContactsFilterScreen(
        title: Text(EnvironmentConfig.APP_NAME),
        sourceTypes: sourceTypes,
        sourceTypeWidgetBuilder: contactSourceTypeWidgetBuilder,
        favoritesWidgetBuilder: contactsFavoritesWidgetBuilder,
      ),
    );
  }
}
