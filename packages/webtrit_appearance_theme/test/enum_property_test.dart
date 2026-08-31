import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/schema/enum_properties.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// An enum-typed property states the values it may take.
///
/// json_serializable has no branch for an enum: the property falls through to the
/// complex-type case, the element is not a class, and out comes a bare
/// `{"type": "object"}` - no values, no default, nothing a configurator could
/// build a chooser from. The package names such properties and fills them in.
///
/// A list that has to be kept by hand is only as good as what catches a gap in
/// it, so the first test here is the one that matters: it does not read the list
/// at all. It walks the published schema and fails on any property still
/// described as a bare object - which is precisely what an enum nobody listed
/// looks like.
void main() {
  final published = <String, Map<String, Object?>>{
    'ThemeSettings': ThemeSettings.jsonSchema,
    'AppConfig': AppConfig.jsonSchema,
    'EmbeddedResource': EmbeddedResource.jsonSchema,
  };

  group('what the published schema says about an enum', () {
    /// Every property of every object in [schema], as `<path>` to its schema.
    ///
    /// Only entries directly under a `properties` map count. `additionalProperties`
    /// is skipped on purpose: a `Map<String, dynamic>` is described as a bare
    /// object there and is telling the truth when it does.
    Map<String, Map<String, Object?>> propertiesOf(Map<String, Object?> schema) {
      final found = <String, Map<String, Object?>>{};

      void walk(Object? node, String path, {required bool isProperty}) {
        if (node is Map) {
          if (isProperty) found[path] = node.cast<String, Object?>();
          for (final entry in node.entries) {
            // A `Map<String, dynamic>` is described as a bare object under
            // `additionalProperties`, and is telling the truth when it is.
            if (entry.key == 'additionalProperties') continue;
            walk(entry.value, '$path/${entry.key}', isProperty: node['properties'] == entry.value ? false : isProperty);
          }
          final properties = node['properties'];
          if (properties is Map) {
            for (final entry in properties.entries) {
              walk(entry.value, '$path/properties/${entry.key}', isProperty: true);
            }
          }
        } else if (node is List) {
          for (var i = 0; i < node.length; i++) {
            walk(node[i], '$path/$i', isProperty: false);
          }
        }
      }

      walk(schema, '', isProperty: false);
      return found;
    }

    test('no property is left as a bare object', () {
      // The check that needs no list. An enum property nobody named comes out
      // exactly like this, so a forgotten entry fails here rather than shipping
      // as a contract that says nothing.
      for (final root in published.entries) {
        // `{"type": "object"}` with nothing under it. A real nested class is a
        // `$ref`, and a `Map<String, X>` carries `additionalProperties`; only the
        // generator's fallback - which is what an enum falls into - looks like
        // this. A doc comment may have put a `description` beside it.
        final bare = propertiesOf(root.value).entries
            .where(
              (property) =>
                  property.value['type'] == 'object' &&
                  !property.value.containsKey('additionalProperties') &&
                  !property.value.containsKey('properties'),
            )
            .map((property) => property.key)
            .toList();

        expect(
          bare,
          isEmpty,
          reason:
              'These properties of ${root.key} are described as a bare object. An enum-typed one '
              'belongs in lib/schema/enum_properties.dart.',
        );
      }
    });

    test('a listed property states its enum values in the schema', () {
      final tables = {
        'ThemeSettings': (ThemeSettings.jsonSchema, themeEnumProperties),
        'AppConfig': (AppConfig.jsonSchema, appConfigEnumProperties),
        'EmbeddedResource': (EmbeddedResource.jsonSchema, embeddedResourceEnumProperties),
      };

      for (final table in tables.entries) {
        final (schema, listed) = table.value;
        final defs = schema[r'$defs'] as Map<String, Object?>? ?? const {};

        listed.forEach((type, properties) {
          final owner =
              (type == table.key ? schema['properties'] : (defs[type]! as Map<String, Object?>)['properties'])!
                  as Map<String, Object?>;

          properties.forEach((name, property) {
            final described = owner[name]! as Map<String, Object?>;
            expect(described['enum'], [
              for (final value in property.values) value.name,
            ], reason: '$type.$name does not state its values');
          });
        });
      }
    });

    test('a default is one of the values the property offers', () {
      // The one way the values could be wrong: an enum renamed on the wire with
      // `@JsonValue`, which `Enum.name` would not know about. The default is
      // read off a real instance, so if a rename existed this would catch it.
      for (final table in [themeEnumProperties, appConfigEnumProperties, embeddedResourceEnumProperties]) {
        table.forEach((type, properties) {
          properties.forEach((name, property) {
            final fallback = property.defaultsOf()[name];
            if (fallback == null) return;

            expect(
              [for (final value in property.values) value.name],
              contains(fallback),
              reason: '$type.$name defaults to "$fallback", which is not one of its values',
            );
          });
        });
      }
    });
  });
}
