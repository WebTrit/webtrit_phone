import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  const help = EmbeddedBottomMenuTab(id: 'help', enabled: true, initial: false, titleL10n: 'Help', icon: Icons.help);
  const shop = EmbeddedBottomMenuTab(
    id: 'shop',
    enabled: true,
    initial: false,
    titleL10n: 'Shop',
    icon: Icons.shopping_bag,
  );
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

  const config = BottomMenuConfig(tabs: [keypad, recents, help, shop]);

  group('findInitialTab', () {
    test('restores the very embedded section that was open, not the first one', () {
      expect(config.findInitialTab(shop.routePath), same(shop));
    });

    test('restores a fixed tab by its path', () {
      expect(config.findInitialTab(recents.routePath), same(recents));
    });

    test('a kind-only value saved by an older build falls back to the first embedded section', () {
      expect(config.findInitialTab('embedded'), same(help));
    });

    test('a section no longer configured falls back to the first one of its kind', () {
      expect(config.findInitialTab('embedded/gone'), same(help));
    });

    test('with nothing saved the configuration decides', () {
      expect(config.findInitialTab(null), same(keypad));
    });

    test('an unknown value falls back to the configured initial tab', () {
      expect(config.findInitialTab('what-is-this'), same(keypad));
    });

    test('with neither a match nor an initial flag the first tab wins', () {
      const bare = BottomMenuConfig(tabs: [recents, help]);
      expect(bare.findInitialTab(null), same(recents));
    });
  });
}
