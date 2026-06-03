import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  final emptyEmbedded = EmbeddedMapper.map(const []);

  group('BottomMenuMapper recents useCdrs gating by the callHistory capability', () {
    AppConfig appConfigWithRecents({required bool useCdrs}) {
      return AppConfig(
        mainConfig: AppConfigMain(
          bottomMenu: AppConfigBottomMenu(
            tabs: [
              BottomMenuTabScheme.recents(enabled: true, titleL10n: 'recents', icon: '0xe03a', useCdrs: useCdrs),
              const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
            ],
          ),
        ),
      );
    }

    bool? recentsUseCdrs(AppConfig appConfig, List<String> flags) {
      final config = BottomMenuMapper.map(appConfig, emptyEmbedded, CoreSupportImpl(flags));
      return config.getTabEnabled<RecentsBottomMenuTab>()?.useCdrs;
    }

    test('useCdrs configured AND callHistory advertised -> true', () {
      expect(recentsUseCdrs(appConfigWithRecents(useCdrs: true), [kCallHistoryFeatureFlag]), isTrue);
    });

    test('useCdrs configured but callHistory NOT advertised -> false (local fallback)', () {
      expect(recentsUseCdrs(appConfigWithRecents(useCdrs: true), const []), isFalse);
    });

    test('callHistory advertised but useCdrs not configured -> false', () {
      expect(recentsUseCdrs(appConfigWithRecents(useCdrs: false), [kCallHistoryFeatureFlag]), isFalse);
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
