import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// Every union variant states its discriminator, and the decoder agrees.
///
/// Freezed writes a `$type` of its own and puts the value in the constructor's
/// initialiser list, where the schema generator cannot see it - the parameter
/// default it reads is `null`. So each variant declares the field instead, and
/// the generated schema states `{'type': 'string', 'default': 'solid'}`. No
/// hand-written map repeats it, which is the point.
///
/// A declared field can be given another value, which freezed's synthetic one
/// could not. That is what these tests are: every variant is built, written and
/// read back, and has to come back as itself. And the schema is checked to
/// carry the same word the decoder dispatches on.
void main() {
  _typesMatchTheWire();

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

  group('what the schema says about it', () {
    /// The default the schema states for one variant's discriminator, read the
    /// way a consumer reads it: out of a root's `$defs`, not off a Dart class.
    String statedBy(Map<String, Object?> root, String variant) {
      final defs = root[r'$defs']! as Map<String, Object?>;
      final schema = defs[variant]! as Map<String, Object?>;
      final properties = schema['properties']! as Map<String, Object?>;
      final discriminator = properties['type']! as Map<String, Object?>;
      return discriminator['default']! as String;
    }

    test('a background variant states the word the decoder dispatches on', () {
      // Both halves, against each other: the schema says `solid`, and a
      // `PageBackgroundSolid` written out says `solid` too. One of them
      // changing without the other is the failure this catches.
      for (final variant in {
        'PageBackgroundSolid': const PageBackground.solid(color: '#000000'),
        'PageBackgroundGradient': const PageBackground.gradient(colors: ['#000000']),
        'PageBackgroundImage': const PageBackground.image(imageUrl: 'a'),
      }.entries) {
        expect(
          statedBy(ThemeSettings.jsonSchema, variant.key),
          variant.value.toJson()['type'],
          reason: '${variant.key} disagrees with what it writes',
        );
      }
    });

    test('a bottom menu tab variant states the word the decoder dispatches on', () {
      for (final variant in {
        'FavoritesTabScheme': const BottomMenuTabScheme.favorites(titleL10n: 'a', icon: 'b'),
        'RecentsTabScheme': const BottomMenuTabScheme.recents(titleL10n: 'a', icon: 'b'),
        'VoicemailTabScheme': const BottomMenuTabScheme.voicemail(titleL10n: 'a', icon: 'b'),
      }.entries) {
        expect(
          statedBy(AppConfig.jsonSchema, variant.key),
          variant.value.toJson()['type'],
          reason: '${variant.key} disagrees with what it writes',
        );
      }
    });
  });
}

/// A field's type is the type the JSON carries.
///
/// A `JsonConverter<T, S>` is the one way those two can differ, and the schema
/// generator describes `T` - so a converted field is published as something the
/// document never contains. `IconDataConfig.codePoint` was an `int` behind
/// `JsonConverter<int, String>` and went out as `integer`, which every real
/// icon fails.
///
/// The answer is not to teach the generator about converters. It is to have no
/// converter: a field whose type is the wire's cannot describe itself wrongly.
void _typesMatchTheWire() {
  group('what a converted field used to claim', () {
    test('an icon code point is a string, and says so', () {
      const icon = IconDataConfig(codePoint: 'e491');

      expect(icon.toJson()['codePoint'], isA<String>());

      final defs = ThemeSettings.jsonSchema[r'$defs']! as Map<String, Object?>;
      final schema = defs['IconDataConfig']! as Map<String, Object?>;
      final properties = schema['properties']! as Map<String, Object?>;
      final codePoint = properties['codePoint']! as Map<String, Object?>;

      expect(codePoint['type'], 'string');
    });

    test('and still reads as a number where one is wanted', () {
      // The parse moved to where the number is used. Both spellings are read,
      // because a theme stored before this carried either.
      expect(const IconDataConfig(codePoint: 'e491').codePointValue, 0xe491);
      expect(const IconDataConfig(codePoint: '0xe491').codePointValue, 0xe491);
    });

    test('round-trips whatever was stored', () {
      for (final written in ['e491', '0xe491']) {
        final icon = IconDataConfig.fromJson({'codePoint': written});
        expect(icon.toJson()['codePoint'], written);
      }
    });
  });
}
