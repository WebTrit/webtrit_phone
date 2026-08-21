import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockUnreadCountCubit extends MockCubit<UnreadCountState> implements UnreadCountCubit {}

void main() {
  final tabs = <BottomMenuTab>[
    const FavoritesBottomMenuTab(
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_favorites',
      icon: Icons.star,
    ),
    const KeypadBottomMenuTab(
      enabled: true,
      initial: true,
      titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
      icon: Icons.dialpad,
    ),
    ContactsBottomMenuTab(
      contactSourceTypes: const [ContactSourceType.local],
      favoritesFilter: false,
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_contacts',
      icon: Icons.contacts,
    ),
    const RecentsBottomMenuTab(
      supportsCallHistory: true,
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_recents',
      icon: Icons.history,
    ),
    const MessagingBottomMenuTab(
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_chats',
      icon: Icons.chat,
    ),
    // The embedded sections are switched off in the stand's configuration, so
    // this is the only place their entry is exercised at all.
    const EmbeddedBottomMenuTab(
      id: 'help',
      enabled: true,
      initial: false,
      titleL10n: 'main_BottomNavigationBarItemLabel_embedded',
      icon: Icons.help_outline,
    ),
  ];

  late _MockUnreadCountCubit unreadCountCubit;

  setUp(() {
    unreadCountCubit = _MockUnreadCountCubit();
    when(() => unreadCountCubit.state).thenReturn(UnreadCountState.initial());
  });

  Widget wrap({
    required ValueChanged<int> onTap,
    int currentIndex = 1,
    List<BottomMenuTab>? menu,
    TabIconDecorator? decorateIcon,
    bool provideUnreadState = true,
  }) {
    final scaffold = Scaffold(
      bottomNavigationBar: MainBottomNavigationBar(
        tabs: menu ?? tabs,
        currentIndex: currentIndex,
        onTap: onTap,
        decorateIcon: decorateIcon,
      ),
    );
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: provideUnreadState
          ? BlocProvider<UnreadCountCubit>.value(value: unreadCountCubit, child: scaffold)
          : scaffold,
    );
  }

  testWidgets('two embedded sections can sit in the same bar', (tester) async {
    // An install can configure several embedded sections. They used to take
    // the one key of their kind, and the build came down on a duplicate key.
    await tester.pumpWidget(
      wrap(
        onTap: (_) {},
        currentIndex: 0,
        menu: const [
          EmbeddedBottomMenuTab(
            id: 'help',
            enabled: true,
            initial: true,
            titleL10n: 'main_BottomNavigationBarItemLabel_embedded',
            icon: Icons.help,
          ),
          EmbeddedBottomMenuTab(
            id: 'shop',
            enabled: true,
            initial: false,
            titleL10n: 'main_BottomNavigationBarItemLabel_embedded',
            icon: Icons.shopping_bag,
          ),
        ],
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    // Both per-id keys really are distinct - a shared key is exactly the bug.
    expect(find.byKey(embeddedNavBarKey('help')), findsOneWidget);
    expect(find.byKey(embeddedNavBarKey('shop')), findsOneWidget);
  });

  testWidgets('the bar shows one entry per configured section', (tester) async {
    await tester.pumpWidget(wrap(onTap: (_) {}));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    // The embedded entry is keyed by the section it opens rather than by its
    // kind, so it is checked with the pair below instead.
    for (final tab in tabs.where((tab) => tab is! EmbeddedBottomMenuTab)) {
      expect(find.byKey(tab.navBarKey), findsOneWidget, reason: tab.titleL10n);
    }
    expect(find.byKey(embeddedNavBarKey('help')), findsOneWidget);
  });

  testWidgets('a press reports the entry that was pressed', (tester) async {
    final pressed = <int>[];

    await tester.pumpWidget(wrap(onTap: pressed.add));
    await tester.tap(find.text('Contacts'));

    expect(pressed, [2]);
  });

  testWidgets('a bare bar renders a messaging tab with no messaging state around', (tester) async {
    // The badge used to be built into the bar, which made every host owe it
    // an UnreadCountCubit; a host that forgot one compiled clean and
    // red-screened at build time.
    await tester.pumpWidget(wrap(onTap: (_) {}, provideUnreadState: false));

    expect(tester.takeException(), isNull);
    expect(find.byType(MessagingFlavorOverlay), findsNothing);
  });

  testWidgets('the injected decoration overlays exactly the messaging entry', (tester) async {
    await tester.pumpWidget(wrap(onTap: (_) {}, decorateIcon: MessagingFlavorOverlay.forTab));

    expect(find.byType(MessagingFlavorOverlay), findsOneWidget);
  });

  testWidgets('the decoration without its state degrades to a bare icon, not a crash', (tester) async {
    // A future host can copy the decoration without copying the provider; the
    // ornament must not be able to take the navigation down.
    await tester.pumpWidget(
      wrap(onTap: (_) {}, decorateIcon: MessagingFlavorOverlay.forTab, provideUnreadState: false),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
