import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// The values a deployed release parses. Changing one is a wire break, not a
/// refactor: the configurator's registry reads a removal plus an addition and
/// refuses the release at its door.
///
/// This table is the same one the Wire Contract section of AGENTS.md carries;
/// keep the two in step. The tests below go through `fromJson`/`toJson` rather
/// than reading string constants, so a renamed factory, a changed
/// `unionValueCase` and a dropped variant all fail here.
const _discriminators = {
  'PageBackground': ['solid', 'gradient', 'image'],
  'SupportedFeature': ['themeMode', 'videoCall', 'loggingConfig', 'systemNotifications', 'hybridPresence', 'callPull'],
  'BottomMenuTabScheme': ['favorites', 'recents', 'contacts', 'keypad', 'messaging', 'voicemail', 'embedded'],
};

/// What a variant needs before it will parse at all. Everything absent here
/// carries a default, and a default is not what this test pins.
const _tab = {'titleL10n': 'settings_TabTitle', 'icon': '0xe0af'};

const _required = <String, Map<String, Object?>>{
  'PageBackground.solid': {'color': '#FF102030'},
  'PageBackground.gradient': {
    'colors': ['#FF102030', '#FF405060'],
  },
  'PageBackground.image': {'imageUrl': 'asset://background.png'},
  'BottomMenuTabScheme.favorites': _tab,
  'BottomMenuTabScheme.recents': _tab,
  'BottomMenuTabScheme.contacts': _tab,
  'BottomMenuTabScheme.keypad': _tab,
  'BottomMenuTabScheme.messaging': _tab,
  'BottomMenuTabScheme.voicemail': _tab,
  'BottomMenuTabScheme.embedded': {..._tab, 'embeddedResourceId': 'example_embedded_tab'},
};

class _Union {
  const _Union(this.parse, this.encode);

  final Object Function(Map<String, Object?> json) parse;
  final Map<String, Object?> Function(Object variant) encode;
}

final _unions = <String, _Union>{
  'PageBackground': _Union(PageBackground.fromJson, (v) => (v as PageBackground).toJson()),
  'SupportedFeature': _Union(SupportedFeature.fromJson, (v) => (v as SupportedFeature).toJson()),
  'BottomMenuTabScheme': _Union(BottomMenuTabScheme.fromJson, (v) => (v as BottomMenuTabScheme).toJson()),
};

Map<String, Object?> _jsonFor(String union, String value) => {'type': value, ..._required['$union.$value'] ?? const {}};

void main() {
  group('the discriminator values a release parses', () {
    _discriminators.forEach((union, values) {
      final subject = _unions[union]!;

      group(union, () {
        test('every value parses, into a variant of its own', () {
          final variants = <Type>{};
          for (final value in values) {
            variants.add(subject.parse(_jsonFor(union, value)).runtimeType);
          }

          expect(
            variants,
            hasLength(values.length),
            reason: 'two of $union\'s values reached the same variant, so one of them no longer means what it did',
          );
        });

        test('every value comes back out the way it went in', () {
          for (final value in values) {
            final written = subject.encode(subject.parse(_jsonFor(union, value)));

            expect(
              written['type'],
              value,
              reason: 'a release writing anything but "$value" here is one an older phone cannot read',
            );
          }
        });

        test('a value this release does not know is refused, not guessed', () {
          expect(
            () => subject.parse(_jsonFor(union, 'not_a_variant')),
            throwsA(isA<CheckedFromJsonException>()),
            reason: 'an unknown $union arriving as a silent default would hide the reshape that caused it',
          );
        });
      });
    });
  });
}
