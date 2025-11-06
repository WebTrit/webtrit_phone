import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'helpers/helpers.dart';

void main() {
  group('AppConfig.mainConfig parsing', () {
    late Map<String, dynamic> json;

    setUp(() async {
      json = await loadFixtureJson('../../assets/themes/app.config.json');
    });

    test('parses AppConfig and bottomMenu tabs with correct variants & values', () {
      final config = AppConfig.fromJson(json);

      // sanity
      expect(config.mainConfig.systemNotificationsEnabled, isTrue);
      expect(config.mainConfig.bottomMenu.cacheSelectedTab, isTrue);

      final tabs = config.mainConfig.bottomMenu.tabs;
      expect(tabs, hasLength(7));

      // variants in order
      expect(tabs[0], isA<FavoritesTabScheme>());
      expect(tabs[1], isA<RecentsTabScheme>());
      expect(tabs[2], isA<ContactsTabScheme>());
      expect(tabs[3], isA<KeypadTabScheme>());
      expect(tabs[4], isA<MessagingTabScheme>());
      expect(tabs[5], isA<EmbeddedTabScheme>());
      expect(tabs[6], isA<EmbeddedTabScheme>());

      // Favorites
      tabs[0].when(
        favorites: (enabled, initial, titleL10n, icon) {
          expect(enabled, isTrue);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_favorites');
          expect(icon, '0xe5fd');
        },
        recents: unexpectedRecents,
        contacts: unexpectedContacts,
        keypad: unexpectedKeypad,
        messaging: unexpectedMessaging,
        embedded: unexpectedEmbedded,
      );

      // Recents
      tabs[1].when(
        favorites: unexpectedFavorites,
        recents: (enabled, initial, titleL10n, icon, useCdrs) {
          expect(enabled, isFalse);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_recents');
          expect(icon, '0xe03a');
          expect(useCdrs, isFalse); // default
        },
        contacts: unexpectedContacts,
        keypad: unexpectedKeypad,
        messaging: unexpectedMessaging,
        embedded: unexpectedEmbedded,
      );

      // Contacts
      tabs[2].when(
        favorites: unexpectedFavorites,
        recents: unexpectedRecents,
        contacts: (enabled, initial, titleL10n, icon, contactSourceTypes) {
          expect(enabled, isTrue);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_contacts');
          expect(icon, '0xee35');
          expect(contactSourceTypes, ['local', 'external']);
        },
        keypad: unexpectedKeypad,
        messaging: unexpectedMessaging,
        embedded: unexpectedEmbedded,
      );

      // Keypad
      tabs[3].when(
        favorites: unexpectedFavorites,
        recents: unexpectedRecents,
        contacts: unexpectedContacts,
        keypad: (enabled, initial, titleL10n, icon) {
          expect(enabled, isTrue);
          expect(initial, isTrue);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_keypad');
          expect(icon, '0xe1ce');
        },
        messaging: unexpectedMessaging,
        embedded: unexpectedEmbedded,
      );

      // Messaging
      tabs[4].when(
        favorites: unexpectedFavorites,
        recents: unexpectedRecents,
        contacts: unexpectedContacts,
        keypad: unexpectedKeypad,
        messaging: (enabled, initial, titleL10n, icon) {
          expect(enabled, isFalse);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_chats');
          expect(icon, '0xe155');
        },
        embedded: unexpectedEmbedded,
      );

      // Embedded #1
      tabs[5].when(
        favorites: unexpectedFavorites,
        recents: unexpectedRecents,
        contacts: unexpectedContacts,
        keypad: unexpectedKeypad,
        messaging: unexpectedMessaging,
        embedded: (enabled, initial, titleL10n, icon, embeddedResourceId) {
          expect(enabled, isFalse);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_embedded');
          expect(icon, '0xe2ce');
          expect(embeddedResourceId, 'example_embedded_payload_data');
        },
      );

      // Embedded #2
      tabs[6].when(
        favorites: unexpectedFavorites,
        recents: unexpectedRecents,
        contacts: unexpectedContacts,
        keypad: unexpectedKeypad,
        messaging: unexpectedMessaging,
        embedded: (enabled, initial, titleL10n, icon, embeddedResourceId) {
          expect(enabled, isFalse);
          expect(initial, isFalse);
          expect(titleL10n, 'main_BottomNavigationBarItemLabel_embedded_spa_example');
          expect(icon, '0xe2ce');
          expect(embeddedResourceId, 'example_embedded_spa');
        },
      );
    });

    test('loginConfig [modeSelect screen] & settingsConfig basic fields parsed', () {
      final config = AppConfig.fromJson(json);

      expect(config.loginConfig.modeSelect.greetingL10n, 'WebTrit');
      expect(config.loginConfig.modeSelect.actions, isNotEmpty);
      expect(config.loginConfig.modeSelect.actions.first.enabled, isTrue);
      expect(config.loginConfig.modeSelect.actions.first.type, 'login');

      final sections = config.settingsConfig.sections;
      expect(sections, isNotEmpty);

      final settingsSection = sections.firstWhere((s) => s.titleL10n == 'settings_ListViewTileTitle_settings');
      expect(settingsSection.enabled, isTrue);
      expect(settingsSection.items.any((i) => i.type == 'terms'), isTrue);
    });
  });
}
