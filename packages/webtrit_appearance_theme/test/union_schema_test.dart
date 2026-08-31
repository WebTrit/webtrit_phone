import 'package:freezed_annotation/freezed_annotation.dart';
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
  _theEmbeddedIdIsAString();
  _aUnionOffersItsVariants();

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

/// An embedded resource is named by a string, and only by a string.
///
/// It used to be either: `JsonConverter<String, Object?>` read a number as
/// readily, and the Firestore data behind the old backend is half and half -
/// 75 numbers against 76 strings, counted. The schema could only describe that
/// as "any shape", which says nothing.
///
/// The frozen track still serves those themes. This one starts at 1.16.5, so
/// the shape is settled here: a string, said once and said truthfully.
void _theEmbeddedIdIsAString() {
  group('an embedded resource id', () {
    Map<String, Object?> tab(Object? id) => {
      'type': 'embedded',
      'titleL10n': 'a',
      'icon': 'b',
      'embeddedResourceId': id,
    };

    test('reads a string', () {
      final decoded = BottomMenuTabScheme.fromJson(tab('privacy-policy')) as EmbeddedTabScheme;

      expect(decoded.embeddedResourceId, 'privacy-policy');
    });

    test('refuses a number rather than reading one', () {
      // The converter that accepted this is gone. A theme carrying a number is
      // served by the frozen track, and one that reaches here is a mistake
      // worth seeing rather than one to paper over.
      expect(() => BottomMenuTabScheme.fromJson(tab(4)), throwsA(isA<TypeError>()));
    });

    test('and the schema says string, not any shape', () {
      final defs = AppConfig.jsonSchema[r'$defs']! as Map<String, Object?>;
      final schema = defs['EmbeddedTabScheme']! as Map<String, Object?>;
      final properties = schema['properties']! as Map<String, Object?>;
      final id = properties['embeddedResourceId']! as Map<String, Object?>;

      expect(id['type'], 'string');
    });
  });
}

/// A union is described as a `oneOf` over its variants.
///
/// The generator cannot write that: it describes a class from the fields the
/// class declares, and a sealed union declares none. So the package supplies the
/// one missing fact - which classes the union is made of - and `assembleUnions`
/// does the rest. These tests are what keeps that list honest: every word the
/// decoder dispatches on has to be a variant the schema offers, and the other way
/// round.
void _aUnionOffersItsVariants() {
  group('what the schema offers for a union', () {
    List<String> variantsOf(Map<String, Object?> root, String union) {
      final defs = root[r'$defs']! as Map<String, Object?>;
      final schema = defs[union]! as Map<String, Object?>;
      final oneOf = schema['oneOf']! as List<Object?>;
      return [for (final entry in oneOf) ((entry! as Map<String, Object?>)[r'$ref']! as String).split('/').last];
    }

    /// The discriminator values the schema states, read out of the variants the
    /// union offers - which is how a consumer learns what to write.
    Set<String> discriminatorsOf(Map<String, Object?> root, String union) {
      final defs = root[r'$defs']! as Map<String, Object?>;
      return {
        for (final variant in variantsOf(root, union))
          (((defs[variant]! as Map<String, Object?>)['properties']! as Map<String, Object?>)['type']!
                  as Map<String, Object?>)['default']!
              as String,
      };
    }

    test('a background offers three, and every one of them is described', () {
      expect(variantsOf(ThemeSettings.jsonSchema, 'PageBackground'), [
        'PageBackgroundSolid',
        'PageBackgroundGradient',
        'PageBackgroundImage',
      ]);

      final defs = ThemeSettings.jsonSchema[r'$defs']! as Map<String, Object?>;
      for (final variant in variantsOf(ThemeSettings.jsonSchema, 'PageBackground')) {
        final schema = defs[variant]! as Map<String, Object?>;
        expect(schema['properties'], isNotEmpty, reason: '$variant is offered but not described');
      }
    });

    test('every word a background decoder takes is a variant it offers', () {
      // Both directions. A variant added to the decoder and forgotten in the
      // list drops out of the schema; one added to the list and forgotten in
      // the decoder is offered and then refused.
      final offered = discriminatorsOf(ThemeSettings.jsonSchema, 'PageBackground');

      expect(offered, {'solid', 'gradient', 'image'});
      for (final word in offered) {
        expect(
          () => PageBackground.fromJson({'type': word, 'color': '#000000', 'colors': <String>[], 'imageUrl': 'a'}),
          returnsNormally,
          reason: 'the schema offers "$word" but the decoder refuses it',
        );
      }
    });

    test('a supported feature and a bottom menu tab offer theirs too', () {
      expect(discriminatorsOf(AppConfig.jsonSchema, 'SupportedFeature'), {
        'themeMode',
        'videoCall',
        'loggingConfig',
        'systemNotifications',
        'hybridPresence',
        'callPull',
      });
      expect(discriminatorsOf(AppConfig.jsonSchema, 'BottomMenuTabScheme'), {
        'favorites',
        'recents',
        'contacts',
        'keypad',
        'messaging',
        'voicemail',
        'embedded',
      });
    });

    test('an unknown word is refused rather than read as something else', () {
      expect(() => PageBackground.fromJson({'type': 'video'}), throwsA(isA<CheckedFromJsonException>()));
      expect(() => SupportedFeature.fromJson({'type': 'telepathy'}), throwsA(isA<CheckedFromJsonException>()));
      expect(() => BottomMenuTabScheme.fromJson({'type': 'radio'}), throwsA(isA<CheckedFromJsonException>()));
    });
  });
}
