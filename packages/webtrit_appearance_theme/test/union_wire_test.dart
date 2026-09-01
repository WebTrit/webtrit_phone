import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// Every union variant states its discriminator, and the decoder agrees.
///
/// Freezed writes a `$type` of its own and puts the value in the constructor's
/// initialiser list, where nothing outside the constructor can read it. So each
/// variant declares the field instead, with its word as the parameter default -
/// one place, readable by anything that looks at the class.
///
/// A declared field can also be given another value, which freezed's synthetic
/// one could not. That is what these tests are: every variant is built, written
/// and read back, and has to come back as itself.
void main() {
  group('what the decoder makes of what the encoder wrote', () {
    test('a background comes back as the variant it says it is', () {
      for (final background in <PageBackground>[
        const PageBackground.solid(color: '#3A6EA5'),
        const PageBackground.gradient(colors: ['#000000', '#FFFFFF']),
        const PageBackground.image(imageUrl: 'https://example.invalid/a.png'),
      ]) {
        expect(PageBackground.fromJson(background.toJson()).runtimeType, background.runtimeType);
      }
    });

    test('a supported feature comes back as the variant it says it is', () {
      for (final feature in <SupportedFeature>[
        const SupportedFeature.themeMode(),
        const SupportedFeature.videoCall(),
        const SupportedFeature.loggingConfig(),
        const SupportedFeature.systemNotifications(),
        const SupportedFeature.hybridPresence(),
        const SupportedFeature.callPull(),
      ]) {
        expect(SupportedFeature.fromJson(feature.toJson()).runtimeType, feature.runtimeType);
      }
    });

    test('a bottom menu tab comes back as the variant it says it is', () {
      for (final tab in <BottomMenuTabScheme>[
        const BottomMenuTabScheme.favorites(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.recents(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.contacts(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.keypad(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.messaging(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.voicemail(titleL10n: 'a', icon: 'b'),
        const BottomMenuTabScheme.embedded(titleL10n: 'a', icon: 'b', embeddedResourceId: '1'),
      ]) {
        expect(BottomMenuTabScheme.fromJson(tab.toJson()).runtimeType, tab.runtimeType);
      }
    });
  });
}
