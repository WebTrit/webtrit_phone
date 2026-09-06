import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/app_metadata_provider.dart';
import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'package:screenshots/screenshots/screenshots.dart';

/// The contacts flavor never asks it anything; only the embedded one does. It
/// is read before the switch, so the preview cannot be mounted without one.
class _StubAppMetadataProvider implements AppMetadataProvider {
  @override
  Map<String, String> get logLabels => const {};

  @override
  String get userAgent => 'screenshots-test';

  @override
  String get appInfo => 'screenshots-test';

  @override
  String get deviceInfo => 'screenshots-test';

  @override
  String get exportFilenamePrefix => 'screenshots-test';
}

/// Which contacts screen the preview builds.
///
/// The app has two, and `AppRouter` picks between them by the tab's layout.
/// This one built the tabbed screen whatever the configuration said, so the
/// arrangement, the address-book switches and the favourites entry all read as
/// ignored in the editor: the preview was answering a question nobody asked.
void main() {
  FeatureAccess featureAccessWith(ContactsLayoutScheme layout, {bool favorites = true}) => FeatureAccess.create(
    AppConfig(
      mainConfig: AppConfigMain(
        bottomMenu: AppConfigBottomMenu(
          cacheSelectedTab: true,
          tabs: [
            ContactsTabScheme(
              enabled: true,
              initial: true,
              titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
              icon: '0xee35',
              contactSourceTypes: const ['local'],
              layout: layout,
              favorites: favorites,
            ),
          ],
        ),
      ),
    ),
    // `FeatureAccess.create` refuses a configuration with no terms resource,
    // so this is the one thing here that is not about contacts.
    const [
      EmbeddedResource(
        id: 'terms',
        uri: 'https://example.com/terms',
        type: EmbeddedResourceType.terms,
        toolbar: ToolbarConfig(titleL10n: 'Terms'),
      ),
    ],
    CoreSupportFactory.create(null),
    null,
    const FeatureOverrides(),
  );

  Widget host(FeatureAccess featureAccess) {
    return MultiProvider(
      providers: [
        Provider<FeatureAccess?>.value(value: featureAccess),
        Provider<AppMetadataProvider>(create: (_) => _StubAppMetadataProvider()),
      ],
      // What the screenshots app puts above everything in `main.dart`: the
      // scaffold reads the theme from a provider rather than the ambient
      // `Theme`, and a favourite row asks for the presence parameters.
      child: PresenceViewParams(
        hybridPresenceSupport: true,
        blfViaSipSupport: true,
        presenceViaSipSupport: true,
        child: ThemeProvider(
          settings: const ThemeSettings(),
          lightDynamic: null,
          darkDynamic: null,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MainScreenScreenshot(MainFlavor.contacts, null),
          ),
        ),
      ),
    );
  }

  testWidgets('the tabbed arrangement builds the tabbed screen', (tester) async {
    await tester.pumpWidget(host(featureAccessWith(ContactsLayoutScheme.tabbed)));
    await tester.pump();

    expect(find.byType(ContactsScreen), findsOneWidget);
    expect(find.byType(ContactsFilterScreen), findsNothing);
  });

  testWidgets('the unified arrangement builds the screen with the chooser', (tester) async {
    await tester.pumpWidget(host(featureAccessWith(ContactsLayoutScheme.unified)));
    await tester.pump();

    expect(find.byType(ContactsFilterScreen), findsOneWidget);
    expect(find.byType(ContactsScreen), findsNothing);
  });

  // Favourites are an entry of the chooser, so what the tab says about them has
  // to reach the screen that draws it. Two mounts rather than two pumps: the
  // preview widget is a const, so re-pumping the same one changes nothing.
  testWidgets('the favourites entry is offered when the tab offers it', (tester) async {
    await tester.pumpWidget(host(featureAccessWith(ContactsLayoutScheme.unified)));
    await tester.pump();

    final screen = tester.widget<ContactsFilterScreen>(find.byType(ContactsFilterScreen));

    expect(screen.selections.whereType<ContactsFavoritesSelection>(), isNotEmpty);
  });

  testWidgets('the favourites entry is absent when the tab withholds it', (tester) async {
    await tester.pumpWidget(host(featureAccessWith(ContactsLayoutScheme.unified, favorites: false)));
    await tester.pump();

    final screen = tester.widget<ContactsFilterScreen>(find.byType(ContactsFilterScreen));

    expect(screen.selections.whereType<ContactsFavoritesSelection>(), isEmpty);
  });
}
