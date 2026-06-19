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

    bool? recentsUseCdrs({required bool localFlag, required List<String> flags}) {
      final config = BottomMenuMapper.map(
        appConfigWithRecents(supportsCallHistory: localFlag),
        emptyEmbedded,
        CoreSupportImpl(flags),
      );
      return config.getTabEnabled<RecentsBottomMenuTab>()?.supportsCallHistory;
    }

    test('local flag true AND callHistory advertised -> true', () {
      expect(recentsUseCdrs(localFlag: true, flags: [kCallHistoryFeatureFlag]), isTrue);
    });

    test('local flag true but callHistory NOT advertised -> false (local call log fallback)', () {
      expect(recentsUseCdrs(localFlag: true, flags: const []), isFalse);
    });

    test('local flag false even when callHistory advertised -> false', () {
      expect(recentsUseCdrs(localFlag: false, flags: [kCallHistoryFeatureFlag]), isFalse);
    });

    test('local flag false and callHistory NOT advertised -> false', () {
      expect(recentsUseCdrs(localFlag: false, flags: const []), isFalse);
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
      final config = BottomMenuMapper.map(appConfig, emptyEmbedded, CoreSupportImpl(flags));
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
}
