import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  group('BottomMenuMapper recents useCdrs gating by the callHistory capability', () {
    AppConfig appConfigWithRecents() {
      return AppConfig(
        mainConfig: AppConfigMain(
          bottomMenu: AppConfigBottomMenu(
            tabs: [
              const BottomMenuTabScheme.recents(enabled: true, titleL10n: 'recents', icon: '0xe03a'),
              const BottomMenuTabScheme.keypad(enabled: true, titleL10n: 'keypad', icon: '0xe1ce'),
            ],
          ),
        ),
      );
    }

    final emptyEmbedded = EmbeddedMapper.map(const []);

    bool? recentsUseCdrs(AppConfig appConfig, List<String> flags) {
      final config = BottomMenuMapper.map(appConfig, emptyEmbedded, CoreSupportImpl(flags));
      return config.getTabEnabled<RecentsBottomMenuTab>()?.supportsCallHistory;
    }

    test('callHistory advertised -> true', () {
      expect(recentsUseCdrs(appConfigWithRecents(), [kCallHistoryFeatureFlag]), isTrue);
    });

    test('callHistory NOT advertised -> false (local call log fallback)', () {
      expect(recentsUseCdrs(appConfigWithRecents(), const []), isFalse);
    });
  });
}
