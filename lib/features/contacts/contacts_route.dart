import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/models.dart';

/// Where a contacts tab leads, given how it is configured.
///
/// Stated once because it is asked in two places - when the tab set is built
/// and when the app opens straight onto contacts - and the two disagreeing is
/// invisible until someone runs the app and lands on the wrong screen: the
/// router's own default child answers whichever question is left unanswered.
PageRouteInfo<dynamic> contactsRouteOf(ContactsBottomMenuTab tab) {
  return ContactsRouterPageRoute(
    children: [
      if (tab.favoritesFilter)
        ContactsFilterScreenPageRoute(sourceTypes: tab.contactSourceTypes)
      else
        ContactsScreenPageRoute(sourceTypes: tab.contactSourceTypes),
    ],
  );
}
