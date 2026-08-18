import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  final emptyEmbedded = EmbeddedMapper.map(const []);

  group('BottomMenuMapper recents call history gated by local flag AND callHistory capability', () {
    AppConfig appConfigWithRecents({required bool supportsCallHistory}) {
      return AppConfig(
        mainConfig: AppConfigMain(
          bottomMenu: AppConfigBottomMenu(
            tabs: [
              BottomMenuTabScheme.recents(
                enabled: true,
                titleL10n: 'recents',
                icon: '0xe03a',
                supportsCallHistory: supportsCallHistory,
              ),
              const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
            ],
          ),
        ),
      );
    }

    bool? resolvedSupportsCallHistory({required bool localFlag, required List<String> flags, bool? firebaseOverride}) {
      final config = BottomMenuMapper.map(
        appConfigWithRecents(supportsCallHistory: localFlag),
        emptyEmbedded,
        CoreSupportImpl(flags),
        FeatureOverrides(isCallHistoryEnabled: firebaseOverride),
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
    AppConfig appConfigWithContacts({required List<String> sources}) {
      return AppConfig(
        mainConfig: AppConfigMain(
          bottomMenu: AppConfigBottomMenu(
            tabs: [
              BottomMenuTabScheme.contacts(
                enabled: true,
                titleL10n: 'contacts',
                icon: '0xee35',
                contactSourceTypes: sources,
              ),
              const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
            ],
          ),
        ),
      );
    }

    ContactsBottomMenuTab? contactsTab(AppConfig appConfig, List<String> flags) {
      final config = BottomMenuMapper.map(appConfig, emptyEmbedded, CoreSupportImpl(flags), const FeatureOverrides());
      return config.getTabEnabled<ContactsBottomMenuTab>();
    }

    test('keeps external source when extensions is advertised', () {
      final tab = contactsTab(appConfigWithContacts(sources: ['local', 'external']), [kExtensionsFeatureFlag]);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, containsAll([ContactSourceType.local, ContactSourceType.external]));
    });

    test('drops external source when extensions is not advertised', () {
      final tab = contactsTab(appConfigWithContacts(sources: ['local', 'external']), const []);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, [ContactSourceType.local]);
    });

    test('drops the whole contacts tab when only external is configured and unsupported', () {
      final tab = contactsTab(appConfigWithContacts(sources: ['external']), const []);

      expect(tab, isNull);
    });

    test('keeps an external-only contacts tab when extensions is advertised', () {
      final tab = contactsTab(appConfigWithContacts(sources: ['external']), [kExtensionsFeatureFlag]);

      expect(tab, isNotNull);
      expect(tab!.contactSourceTypes, [ContactSourceType.external]);
    });
  });

  // Two entries of one identity render with one widget key and bring the bar
  // down with a duplicate-key crash, so a config that repeats a section must
  // keep only its first entry.
  group('BottomMenuMapper duplicate sections', () {
    BottomMenuConfig mapTabs(List<BottomMenuTabScheme> tabs) {
      return BottomMenuMapper.map(
        AppConfig(
          mainConfig: AppConfigMain(bottomMenu: AppConfigBottomMenu(tabs: tabs)),
        ),
        emptyEmbedded,
        CoreSupportImpl(const []),
        const FeatureOverrides(),
      );
    }

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
  });
}
