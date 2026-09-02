import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';

class _SavedTab implements ActiveMainTabRepository {
  _SavedTab([this._path]);

  String? _path;

  @override
  String? getActiveTabPath() => _path;

  @override
  Future<void> setActiveTabPath(String value) async => _path = value;

  @override
  Future<void> clear() async => _path = null;
}

void main() {
  const keypad = KeypadBottomMenuTab(
    enabled: true,
    initial: true,
    titleL10n: 'main_BottomNavigationBarItemLabel_keypad',
    icon: Icons.dialpad,
  );
  const recents = RecentsBottomMenuTab(
    supportsCallHistory: false,
    enabled: true,
    initial: false,
    titleL10n: 'main_BottomNavigationBarItemLabel_recents',
    icon: Icons.history,
  );

  BottomMenuTab resolved({required bool remembers, String? saved}) => BottomMenuInitialTabResolver(
    config: BottomMenuConfig(tabs: const [keypad, recents], remembersSelectedTab: remembers),
    repository: _SavedTab(saved),
  ).resolve();

  group('BottomMenuInitialTabResolver', () {
    test('reopens the section the person left', () {
      expect(resolved(remembers: true, saved: recents.routePath), recents);
    });

    test('opens the configured one when the install does not remember', () {
      expect(resolved(remembers: false, saved: recents.routePath), keypad);
    });

    test('opens the configured one when nothing was ever left open', () {
      expect(resolved(remembers: false), keypad);
    });
  });
}
