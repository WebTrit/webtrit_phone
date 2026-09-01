import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// What the published schema says, read the way a consumer reads it.
///
/// Every test here goes through `<Root>.jsonSchema` - out of a root's `$defs`,
/// never off a Dart class - because that is the artefact this change exists to
/// produce. The wire behaviour the same types were given earlier in this stack is
/// checked in `union_wire_test.dart`; this file is about whether the document
/// describes it truthfully.
void main() {
  _aUnionOffersItsVariants();

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

  group('what a field type is published as', () {
    test('an icon code point is described as a string', () {
      final defs = ThemeSettings.jsonSchema[r'$defs']! as Map<String, Object?>;
      final schema = defs['IconDataConfig']! as Map<String, Object?>;
      final properties = schema['properties']! as Map<String, Object?>;
      final codePoint = properties['codePoint']! as Map<String, Object?>;

      expect(codePoint['type'], 'string');
    });

    test('an embedded resource id is described as a string, not any shape', () {
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
  });
}
