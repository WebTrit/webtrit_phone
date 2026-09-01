import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema/json_schema.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// Every theme document the app ships validates against the published schema.
///
/// This is the end the whole contract exists for: a configurator generates a form
/// from `<Root>.jsonSchema` and a validator checks a document against it before
/// the app is asked to parse it. A schema that describes the DTOs correctly but
/// rejects the app's own assets is of no use to either, so the assets are the
/// test.
///
/// It catches the two ways such a schema goes quietly wrong. A union whose
/// discriminator is not pinned to one value lets a document match several
/// branches of the `oneOf` at once, which `oneOf` rejects - every `bottomMenu`
/// tab of `app.config.json` matched six of the seven variants before the
/// discriminator carried a `const`. And a nullable field described without its
/// nullability rejects the explicit `null` that `toJson` itself writes.
void main() {
  final defs = ThemeSettings.jsonSchema[r'$defs']! as Map<String, Object?>;

  /// The schema of one type out of a root's `$defs`, resolvable on its own.
  ///
  /// The `$defs` travel with it, because a type describes its own nested types by
  /// `$ref` into the same map.
  JsonSchema schemaOf(String type) =>
      JsonSchema.create(<String, Object?>{...defs[type]! as Map<String, Object?>, r'$defs': defs});

  Object? readAsset(String name) => jsonDecode(File('assets/themes/$name').readAsStringSync());

  void expectValid(JsonSchema schema, Object? document, String what) {
    final result = schema.validate(document);
    expect(
      result.errors,
      isEmpty,
      reason: '$what does not validate:\n${result.errors.map((error) => '  $error').join('\n')}',
    );
  }

  group('what the app ships validates against what it publishes', () {
    test('app.config.json against AppConfig', () {
      expectValid(JsonSchema.create(AppConfig.jsonSchema), readAsset('app.config.json'), 'app.config.json');
    });

    test('every entry of app.embedded.config.json against EmbeddedResource', () {
      final schema = JsonSchema.create(EmbeddedResource.jsonSchema);
      final resources = readAsset('app.embedded.config.json')! as List<Object?>;

      expect(resources, isNotEmpty);
      for (var i = 0; i < resources.length; i++) {
        expectValid(schema, resources[i], 'app.embedded.config.json[$i]');
      }
    });

    test('the theme fragments against the types they are read as', () {
      // Each of these is a part of ThemeSettings rather than a whole one, which
      // is what `$defs` is for: the fragment is addressable as its own schema.
      const fragments = {
        'original.color_scheme.light.config.json': 'ColorSchemeConfig',
        'original.color_scheme.dark.config.json': 'ColorSchemeConfig',
        'original.page.light.config.json': 'ThemePageConfig',
        'original.page.dark.config.json': 'ThemePageConfig',
        'original.widget.light.config.json': 'ThemeWidgetConfig',
        'original.widget.dark.config.json': 'ThemeWidgetConfig',
      };

      fragments.forEach((asset, type) {
        expectValid(schemaOf(type), readAsset(asset), '$asset (as $type)');
      });
    });
  });

  group('what makes that possible', () {
    test('every union variant pins its discriminator to one value', () {
      // Without the `const` a variant accepts every other variant's word, so a
      // document matches several branches of the `oneOf` and none of them wins.
      for (final root in <String, Map<String, Object?>>{
        'ThemeSettings': ThemeSettings.jsonSchema,
        'AppConfig': AppConfig.jsonSchema,
      }.entries) {
        final rootDefs = root.value[r'$defs']! as Map<String, Object?>;

        for (final entry in rootDefs.entries) {
          final union = (entry.value as Map<String, Object?>)['oneOf'];
          if (union is! List<Object?>) continue;

          for (final offered in union) {
            final name = ((offered! as Map<String, Object?>)[r'$ref']! as String).split('/').last;
            final variant = rootDefs[name]! as Map<String, Object?>;
            final properties = variant['properties']! as Map<String, Object?>;
            final discriminator = properties['type']! as Map<String, Object?>;

            expect(
              discriminator['const'],
              discriminator['default'],
              reason: '${root.key}: $name does not pin its discriminator',
            );
          }
        }
      }
    });

    test('a nullable property accepts null', () {
      // Read off a property known to be nullable in the DTO, so the check is
      // against the contract rather than against the table that describes it.
      final border = (defs['BorderConfig']! as Map<String, Object?>)['properties']! as Map<String, Object?>;
      final radius = border['borderRadius']! as Map<String, Object?>;

      expect(radius['type'], ['number', 'null']);
      expect(JsonSchema.create(<String, Object?>{...radius}).validate(null).errors, isEmpty);
    });
  });
}
