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
      // TODO: Migrate client configurations first before fully removing this property.
      // ignore: deprecated_member_use_from_same_package, deprecated_member_use
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
      final favorites = tabs[0] as FavoritesTabScheme;
      // Off by default: favourites are reached inside contacts now, and a
      // section of their own beside it would offer the same list twice.
      expect(favorites.enabled, isFalse);
      expect(favorites.initial, isFalse);
      expect(favorites.titleL10n, 'main_BottomNavigationBarItemLabel_favorites');
      expect(favorites.icon, '0xe5fd');

      // Recents
      final recents = tabs[1] as RecentsTabScheme;
      expect(recents.enabled, isTrue);
      expect(recents.initial, isFalse);
      expect(recents.titleL10n, 'main_BottomNavigationBarItemLabel_recents');
      expect(recents.icon, '0xe03a');
      expect(recents.supportsCallHistory, isTrue);

      // Contacts
      final contacts = tabs[2] as ContactsTabScheme;
      expect(contacts.enabled, isTrue);
      expect(contacts.initial, isFalse);
      expect(contacts.titleL10n, 'main_BottomNavigationBarItemLabel_contacts');
      expect(contacts.icon, '0xee35');
      expect(contacts.contactSourceTypes, ['local', 'external']);
      // The arrangement that takes the place of the section the tab above
      // no longer offers, with favourites inside it.
      expect(contacts.layout, ContactsLayoutScheme.unified);
      expect(contacts.favorites, isTrue);

      // Keypad
      final keypad = tabs[3] as KeypadTabScheme;
      expect(keypad.enabled, isTrue);
      expect(keypad.initial, isTrue);
      expect(keypad.titleL10n, 'main_BottomNavigationBarItemLabel_keypad');
      expect(keypad.icon, '0xe1ce');

      // Messaging
      final messaging = tabs[4] as MessagingTabScheme;
      expect(messaging.enabled, isTrue);
      expect(messaging.initial, isFalse);
      expect(messaging.titleL10n, 'main_BottomNavigationBarItemLabel_chats');
      expect(messaging.icon, '0xe155');

      // Embedded #1
      final embedded = tabs[5] as EmbeddedTabScheme;
      expect(embedded.enabled, isFalse);
      expect(embedded.initial, isFalse);
      expect(embedded.titleL10n, 'main_BottomNavigationBarItemLabel_embedded');
      expect(embedded.icon, '0xe2ce');
      expect(embedded.embeddedResourceId, 'example_embedded_payload_data');

      // Embedded #2
      final embeddedSpa = tabs[6] as EmbeddedTabScheme;
      expect(embeddedSpa.enabled, isFalse);
      expect(embeddedSpa.initial, isFalse);
      expect(embeddedSpa.titleL10n, 'main_BottomNavigationBarItemLabel_embedded_spa_example');
      expect(embeddedSpa.icon, '0xe2ce');
      expect(embeddedSpa.embeddedResourceId, 'example_embedded_spa');
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

    test('the default terms item carries no embedded resource reference', () {
      // `0` used to stand here for "none". It is not an id: the app looks it up
      // among the application's embedded resources, finds nothing and falls
      // back to its built-in terms screen, so it only ever meant absence.
      // Both routes to the default matter: an absent settings block uses the
      // constructor default, a present-but-empty one uses the generated one.
      for (final json in const [
        <String, dynamic>{},
        <String, dynamic>{'settingsConfig': <String, dynamic>{}},
      ]) {
        // `settingsSections` and not `sections`: the default no longer sits in
        // the constructor, because a non-empty collection default crashes the
        // schema generator. Both routes still reach it - an absent settings
        // block and a present-but-empty one.
        final items = AppConfig.fromJson(json).settingsConfig.settingsSections.expand((section) => section.items);
        final terms = items.firstWhere((item) => item.type == 'terms');
        expect(terms.embeddedResourceId, isNull, reason: 'json: $json');
      }
    });
  });

  group('AppConfig.localization parsing', () {
    test('the bundled config lists every supported language by default', () async {
      final json = await loadFixtureJson('../../assets/themes/app.config.json');
      final config = AppConfig.fromJson(json);
      expect(config.localization.enabledLanguages, ['en', 'it', 'th', 'uk']);
    });

    test('parses an explicit allowlist', () {
      final config = AppConfig.fromJson({
        'localization': {
          'enabledLanguages': ['en', 'it'],
        },
      });
      expect(config.localization.enabledLanguages, ['en', 'it']);
    });

    test('defaults to an empty allowlist when the block is absent', () {
      final config = AppConfig.fromJson(const {});
      expect(config.localization.enabledLanguages, isEmpty);
    });
  });

  group('ContactsTabScheme.layout parsing', () {
    ContactsTabScheme contactsTab(Map<String, Object?> extra) {
      return BottomMenuTabScheme.fromJson({
            'type': 'contacts',
            'enabled': true,
            'titleL10n': 'contacts',
            'icon': '0xee35',
            ...extra,
          })
          as ContactsTabScheme;
    }

    test('a configuration that names an arrangement gets it', () {
      expect(contactsTab({'layout': 'tabbed'}).layout, ContactsLayoutScheme.tabbed);
      expect(contactsTab({'layout': 'unified'}).layout, ContactsLayoutScheme.unified);
    });

    test('one that names none keeps the arrangement it has', () {
      expect(contactsTab(const {}).layout, ContactsLayoutScheme.tabbed);
      expect(contactsTab(const {}).favorites, isTrue);
    });

    test('and one written for a newer app still opens', () {
      // The configurator can offer an arrangement before every installed app
      // can draw it. Such a build has to fall back to the one it knows, not
      // fail to read its own settings and take the whole configuration down
      // with it.
      expect(contactsTab({'layout': 'something-this-build-never-heard-of'}).layout, ContactsLayoutScheme.tabbed);
    });

    test('favourites are read as their own answer', () {
      expect(contactsTab({'layout': 'unified', 'favorites': false}).favorites, isFalse);
      expect(contactsTab({'layout': 'unified'}).favorites, isTrue);
    });
  });

  group('VoicemailTabScheme parsing', () {
    VoicemailTabScheme voicemailTab(Map<String, Object?> extra) {
      return BottomMenuTabScheme.fromJson({
            'type': 'voicemail',
            'titleL10n': 'main_BottomNavigationBarItemLabel_voicemail',
            'icon': '0xe0b7',
            ...extra,
          })
          as VoicemailTabScheme;
    }

    test('reads its own type and fields', () {
      final tab = voicemailTab({'enabled': true, 'initial': true});

      expect(tab.enabled, isTrue);
      expect(tab.initial, isTrue);
      expect(tab.titleL10n, 'main_BottomNavigationBarItemLabel_voicemail');
      expect(tab.icon, '0xe0b7');
    });

    test('a tab that says nothing about itself is enabled and not initial', () {
      final tab = voicemailTab(const {});

      expect(tab.enabled, isTrue);
      expect(tab.initial, isFalse);
    });

    test('round-trips through json', () {
      final tab = voicemailTab({'enabled': false});

      expect(BottomMenuTabScheme.fromJson(tab.toJson()), equals(tab));
    });
  });

  group('RecentsTabScheme.supportsCallHistory parsing & useCdrs migration', () {
    bool recentsSupportsCallHistory(Map<String, Object?> extra) {
      final scheme = BottomMenuTabScheme.fromJson({
        'type': 'recents',
        'enabled': true,
        'titleL10n': 'recents',
        'icon': '0xe03a',
        ...extra,
      });
      return (scheme as RecentsTabScheme).supportsCallHistory;
    }

    test('new key is honoured', () {
      expect(recentsSupportsCallHistory({'supportsCallHistory': false}), isFalse);
      expect(recentsSupportsCallHistory({'supportsCallHistory': true}), isTrue);
    });

    test('legacy useCdrs key migrates when new key is absent', () {
      expect(recentsSupportsCallHistory({'useCdrs': false}), isFalse);
      expect(recentsSupportsCallHistory({'useCdrs': true}), isTrue);
    });

    test('new key wins over legacy useCdrs when both present', () {
      expect(recentsSupportsCallHistory({'supportsCallHistory': true, 'useCdrs': false}), isTrue);
      expect(recentsSupportsCallHistory({'supportsCallHistory': false, 'useCdrs': true}), isFalse);
    });

    test('explicit null new key does not fall back to legacy useCdrs (default applies)', () {
      expect(recentsSupportsCallHistory({'supportsCallHistory': null, 'useCdrs': false}), isTrue);
    });

    test('defaults to true when neither key is present', () {
      expect(recentsSupportsCallHistory(const {}), isTrue);
    });
  });
}
