import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  final emptyEmbedded = EmbeddedMapper.map(const []);

  BottomMenuConfig mapTabs(
    List<BottomMenuTabScheme> tabs, {
    List<String> flags = const [],
    FeatureOverrides overrides = const FeatureOverrides(),
  }) {
    return BottomMenuMapper.map(
      AppConfig(
        mainConfig: AppConfigMain(bottomMenu: AppConfigBottomMenu(tabs: tabs)),
      ),
      emptyEmbedded,
      CoreSupportImpl(flags),
      overrides,
    );
  }

  group('BottomMenuMapper voicemail tab gated by the core capability', () {
    BottomMenuConfig mapWithVoicemail({required bool enabled, required List<String> flags}) {
      return mapTabs([
        BottomMenuTabScheme.voicemail(enabled: enabled, titleL10n: 'voicemail', icon: '0xe0b7'),
        const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
      ], flags: flags);
    }

    test('a configured tab on a core that advertises voicemail is offered', () {
      final config = mapWithVoicemail(enabled: true, flags: [kVoicemailFeatureFlag]);

      expect(config.getTabEnabled<VoicemailBottomMenuTab>(), isNotNull);
    });

    // A section the server cannot fill would lead to a screen saying so, which
    // is worse than no entry - the same rule a sourceless contacts tab follows.
    test('a core that does not advertise voicemail drops the tab from the menu', () {
      final config = mapWithVoicemail(enabled: true, flags: const []);

      expect(config.tabs.whereType<VoicemailBottomMenuTab>(), isEmpty);
    });

    test('a disabled tab is not offered even where the core advertises voicemail', () {
      final config = mapWithVoicemail(enabled: false, flags: [kVoicemailFeatureFlag]);

      expect(config.tabs.whereType<VoicemailBottomMenuTab>(), isEmpty);
    });
  });

  group('BottomMenuMapper recents call history gated by local flag AND callHistory capability', () {
    bool? resolvedSupportsCallHistory({required bool localFlag, required List<String> flags, bool? firebaseOverride}) {
      final config = mapTabs(
        [
          BottomMenuTabScheme.recents(
            enabled: true,
            titleL10n: 'recents',
            icon: '0xe03a',
            supportsCallHistory: localFlag,
          ),
          const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
        ],
        flags: flags,
        overrides: FeatureOverrides(isCallHistoryEnabled: firebaseOverride),
      );
      return config.getTabEnabled<RecentsBottomMenuTab>()?.supportsCallHistory;
    }

    test('local flag true AND callHistory advertised -> true', () {
      expect(resolvedSupportsCallHistory(localFlag: true, flags: [kCallHistoryFeatureFlag]), isTrue);
    });

    test('local flag true but callHistory NOT advertised -> false (local call log fallback)', () {
      expect(resolvedSupportsCallHistory(localFlag: true, flags: const []), isFalse);
    });

    test('local flag false even when callHistory advertised -> false', () {
      expect(resolvedSupportsCallHistory(localFlag: false, flags: [kCallHistoryFeatureFlag]), isFalse);
    });

    test('local flag false and callHistory NOT advertised -> false', () {
      expect(resolvedSupportsCallHistory(localFlag: false, flags: const []), isFalse);
    });

    test('firebase override true lifts a false local flag when callHistory is advertised -> true', () {
      expect(
        resolvedSupportsCallHistory(localFlag: false, flags: [kCallHistoryFeatureFlag], firebaseOverride: true),
        isTrue,
      );
    });

    test('firebase override false suppresses a true local flag even when callHistory is advertised -> false', () {
      expect(
        resolvedSupportsCallHistory(localFlag: true, flags: [kCallHistoryFeatureFlag], firebaseOverride: false),
        isFalse,
      );
    });

    test('firebase override true cannot bypass a missing callHistory capability -> false', () {
      expect(resolvedSupportsCallHistory(localFlag: false, flags: const [], firebaseOverride: true), isFalse);
    });

    test('null firebase override falls back to the local flag', () {
      expect(
        resolvedSupportsCallHistory(localFlag: true, flags: [kCallHistoryFeatureFlag], firebaseOverride: null),
        isTrue,
      );
    });
  });

  group('BottomMenuMapper external contact source gating by the extensions capability', () {
    BottomMenuTabScheme contactsScheme(List<String> sources) {
      return BottomMenuTabScheme.contacts(
        enabled: true,
        titleL10n: 'contacts',
        icon: '0xee35',
        contactSourceTypes: sources,
      );
    }

    ContactsBottomMenuTab? contactsTab(List<String> sources, List<String> flags) {
      final config = mapTabs([
        contactsScheme(sources),
        const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
      ], flags: flags);
      return config.getTabEnabled<ContactsBottomMenuTab>();
    }

    test('keeps external source when extensions is advertised', () {
      final tab = contactsTab(['local', 'external'], [kExtensionsFeatureFlag]);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, containsAll([ContactSourceType.local, ContactSourceType.external]));
    });

    test('drops external source when extensions is not advertised', () {
      final tab = contactsTab(['local', 'external'], const []);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, [ContactSourceType.local]);
    });

    test('drops the whole contacts tab when only external is configured and unsupported', () {
      final tab = contactsTab(['external'], const []);

      expect(tab, isNull);
    });

    test('keeps an external-only contacts tab when extensions is advertised', () {
      final tab = contactsTab(['external'], [kExtensionsFeatureFlag]);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, [ContactSourceType.external]);
    });
  });

  // Two entries of one identity render with one widget key and bring the bar
  // down with a duplicate-key crash, so a config that repeats a section must
  // keep only its first entry.
  group('BottomMenuMapper duplicate sections', () {
    BottomMenuTabScheme embedded(String id, {String? title}) {
      return BottomMenuTabScheme.embedded(titleL10n: title ?? id, icon: '0xe2ce', embeddedResourceId: id);
    }

    test('a repeated embedded id keeps only its first entry', () {
      final config = mapTabs([
        const BottomMenuTabScheme.keypad(titleL10n: 'keypad', icon: '0xe1ce'),
        embedded('help', title: 'first'),
        embedded('help', title: 'second'),
      ]);

      final embeddedTabs = config.embeddedTabs;
      expect(embeddedTabs, hasLength(1));
      expect(embeddedTabs.single.titleL10n, 'first');
    });

    test('embedded sections with distinct ids all stay', () {
      final config = mapTabs([embedded('help'), embedded('shop')]);

      expect(config.embeddedTabs.map((tab) => tab.id), ['help', 'shop']);
    });

    test('a repeated fixed section keeps only its first entry', () {
      final config = mapTabs([
        const BottomMenuTabScheme.keypad(titleL10n: 'first', icon: '0xe1ce'),
        const BottomMenuTabScheme.keypad(titleL10n: 'second', icon: '0xe1ce'),
        embedded('help'),
      ]);

      expect(config.tabs, hasLength(2));
      expect(config.getTabEnabled<KeypadBottomMenuTab>()!.titleL10n, 'first');
    });

    test('an embedded id spelled like a fixed kind is not mistaken for it', () {
      final config = mapTabs([
        const BottomMenuTabScheme.keypad(titleL10n: 'keypad', icon: '0xe1ce'),
        embedded('keypad'),
      ]);

      expect(config.tabs, hasLength(2));
    });

    test('ids differing only in first-letter case dedupe: the widget key capitalizes them into one', () {
      final config = mapTabs([embedded('help'), embedded('Help')]);

      expect(config.embeddedTabs, hasLength(1));
    });

    test('a disabled duplicate does not claim the identity', () {
      // The dedup filter runs after the enabled filter; were the order
      // flipped, the disabled first entry would swallow the enabled one.
      final config = mapTabs([
        const BottomMenuTabScheme.keypad(enabled: false, titleL10n: 'off', icon: '0xe1ce'),
        const BottomMenuTabScheme.keypad(titleL10n: 'on', icon: '0xe1ce'),
      ]);

      expect(config.tabs.whereType<KeypadBottomMenuTab>().single.titleL10n, 'on');
    });

    test('an entry dropped for having no contact sources does not claim the identity', () {
      // Same order dependency against the empty-contacts filter: without the
      // extensions capability the external-only entry is dropped first, so
      // the local one must survive the dedup.
      final config = mapTabs([
        const BottomMenuTabScheme.keypad(titleL10n: 'keypad', icon: '0xe1ce'),
        const BottomMenuTabScheme.contacts(titleL10n: 'external', icon: '0xee35', contactSourceTypes: ['external']),
        const BottomMenuTabScheme.contacts(titleL10n: 'local', icon: '0xee35', contactSourceTypes: ['local']),
      ]);

      final contacts = config.tabs.whereType<ContactsBottomMenuTab>().single;
      expect(contacts.titleL10n, 'local');
      expect(contacts.contactSourceTypes, [ContactSourceType.local]);
    });

    test('the survivor keeps its own flags: a dropped duplicate does not hand over initial', () {
      final config = mapTabs([
        const BottomMenuTabScheme.messaging(titleL10n: 'chats', icon: '0xe155'),
        const BottomMenuTabScheme.keypad(titleL10n: 'keypad', icon: '0xe1ce'),
        const BottomMenuTabScheme.keypad(initial: true, titleL10n: 'landing', icon: '0xe1ce'),
      ]);

      expect(config.tabs.whereType<KeypadBottomMenuTab>().single.initial, isFalse);
    });
  });
}
