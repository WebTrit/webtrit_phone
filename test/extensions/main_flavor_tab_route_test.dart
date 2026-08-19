import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  test('the recents section is recognised whichever of its two routes a build carries', () {
    // The tab opens the call history when the backend can answer for it and
    // the plain list otherwise. The call history was missing here, so on any
    // build with it the section was reported as no section at all.
    expect(mainFlavorOfTabRoute(RecentsRouterPageRoute.name), MainFlavor.recents);
    expect(mainFlavorOfTabRoute(RecentCdrsRouterPageRoute.name), MainFlavor.recents);
  });

  test('every section of the main screen is reachable by some tab route', () {
    // The mapping takes a route name, so the compiler cannot demand a case per
    // section. This is what does: a section added later, or one whose route is
    // renamed, leaves nothing to find it by and fails here.
    final routeNames = [
      FavoritesRouterPageRoute.name,
      RecentsRouterPageRoute.name,
      RecentCdrsRouterPageRoute.name,
      ContactsRouterPageRoute.name,
      KeypadScreenPageRoute.name,
      ConversationsScreenPageRoute.name,
      EmbeddedTabPageRoute.name,
    ];

    final recognised = routeNames.map(mainFlavorOfTabRoute).nonNulls.toSet();

    expect(recognised, MainFlavor.values.toSet());
  });

  test('a screen inside a tab is not the tab itself', () {
    // The near miss worth guarding: these sit under the tab routes and share
    // their family name, so anything that matched by prefix would take them.
    expect(mainFlavorOfTabRoute(RecentsScreenPageRoute.name), isNull);
    expect(mainFlavorOfTabRoute(RecentCdrsScreenPageRoute.name), isNull);
  });
}
