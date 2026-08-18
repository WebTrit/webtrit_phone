import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../helpers/helpers.dart';

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

  Widget wrap({required ValueChanged<int> onTap, int currentIndex = 1, List<BottomMenuTab>? menu}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<UnreadCountCubit>.value(
        value: unreadCountCubit,
        child: Scaffold(
          bottomNavigationBar: MainBottomNavigationBar(tabs: menu ?? tabs, currentIndex: currentIndex, onTap: onTap),
        ),
      ),
    );
  }

  testWidgets('every entry carries its id on the node that says its caption and answers the press', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(onTap: (_) {}));

    // Which sections are in the bar, and what they are called, come from the
    // menu configuration of the install - so a flow can only address an entry
    // by the section it opens, and only if the id sits on the node that can
    // be pressed rather than on one beside it.
    for (final identifier in [
      favoritesNavBarId,
      keypadNavBarId,
      contactsNavBarId,
      recentsNavBarId,
      messagingNavBarId,
      embeddedNavBarId('help'),
    ]) {
      final entry = tester.getSemantics(find.bySemanticsIdentifier(identifier)).getSemanticsData();

      expect(entry.identifier, identifier, reason: identifier);
      expect(entry.label, isNotEmpty, reason: identifier);
      expect(entry.hasAction(ui.SemanticsAction.tap), isTrue, reason: identifier);
    }

    handle.dispose();
  });

  testWidgets('the id of an entry does not change when it becomes the open one', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(onTap: (_) {}, currentIndex: 0));

    // The bar swaps the icon of the open entry for its active variant, and the
    // id has to survive that: a flow presses the same entry twice.
    final entry = tester.getSemantics(find.bySemanticsIdentifier(favoritesNavBarId)).getSemanticsData();
    expect(entry.identifier, favoritesNavBarId);
    expect(entry.flagsCollection.isSelected, ui.Tristate.isTrue);

    handle.dispose();
  });

  testWidgets('pressing an entry through semantics reports its position', (tester) async {
    final handle = tester.ensureSemantics();

    int? tapped;
    await tester.pumpWidget(wrap(onTap: (index) => tapped = index));

    await tapViaSemantics(tester, find.bySemanticsIdentifier(contactsNavBarId));

    expect(tapped, 2);

    handle.dispose();
  });

  testWidgets('the bar leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(onTap: (_) {}));

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });

  testWidgets('two embedded sections get an id each', (tester) async {
    final handle = tester.ensureSemantics();

    // An install can configure several embedded sections; they are all called
    // whatever their configuration says, so the id each is set up with is the
    // only thing that tells their entries apart.
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

    expect(find.bySemanticsIdentifier(embeddedNavBarId('help')), findsOneWidget);
    expect(find.bySemanticsIdentifier(embeddedNavBarId('shop')), findsOneWidget);
    expect(embeddedNavBarId('help'), isNot(embeddedNavBarId('shop')));
    // They used to share one widget key too, and two of them in the same bar
    // brought the build down with a duplicate key.
    expect(tester.takeException(), isNull);

    handle.dispose();
  });
}
