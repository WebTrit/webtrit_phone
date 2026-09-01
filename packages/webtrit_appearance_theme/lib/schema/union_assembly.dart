/// Writing the one part of a JSON Schema the generator cannot.
///
/// json_serializable describes a class from the fields that class declares. A
/// sealed union declares none - its variants are separate classes - so it comes
/// out as `{"type": "object", "properties": {}}`, and because nothing traverses
/// an object with no properties, the variants get no `$def` either. There is no
/// `oneOf` anywhere in the generator to reach for.
///
/// The missing fact is small and single: which classes a union is made of. Given
/// that list, the rest is assembly - each variant already carries its own
/// generated schema, and this puts them under the union's name.
library;

/// Returns [root] with each union in [unions] described as a `oneOf`.
///
/// [unions] maps a union's type name to its variants, each variant's name to the
/// schema generated for it. A variant's schema is a root in its own right, so
/// three things are done to it: its `$schema` header is dropped, its own `$defs`
/// are lifted into the root's (an existing entry wins, the names being unique
/// across the package), and a self-reference - `{"$ref": "#"}`, which meant "this
/// variant" while the variant was the root - is rewritten to point at where the
/// variant now lives.
Map<String, Object?> assembleUnions(Map<String, Object?> root, Map<String, Map<String, Map<String, Object?>>> unions) {
  final defs = <String, Object?>{...?root[r'$defs'] as Map<String, Object?>?};

  unions.forEach((union, variants) {
    for (final variant in variants.entries) {
      final schema = <String, Object?>{...variant.value}
        ..remove(r'$schema')
        ..remove(r'$defs');
      defs[variant.key] = _pointSelfRefsAt(schema, variant.key) as Map<String, Object?>;

      final nested = variant.value[r'$defs'] as Map<String, Object?>?;
      nested?.forEach((name, schema) => defs.putIfAbsent(name, () => schema));
    }

    defs[union] = <String, Object?>{
      'oneOf': [
        for (final name in variants.keys) <String, Object?>{r'$ref': '#/\$defs/$name'},
      ],
    };
  });

  return <String, Object?>{...root, if (defs.isNotEmpty) r'$defs': defs};
}

Object? _pointSelfRefsAt(Object? node, String variant) {
  if (node is Map) {
    if (node.length == 1 && node[r'$ref'] == '#') {
      return <String, Object?>{r'$ref': '#/\$defs/$variant'};
    }
    return <String, Object?>{
      for (final entry in node.entries) entry.key as String: _pointSelfRefsAt(entry.value, variant),
    };
  }
  if (node is List) {
    return [for (final item in node) _pointSelfRefsAt(item, variant)];
  }
  return node;
}

/// An enum-typed property: the words it may take, and the one it defaults to.
///
/// Written by `webtrit_appearance_theme_builder` into `enum_properties.g.dart`,
/// off the enum's own constants and the default on the constructor parameter, so
/// neither is stated twice.
class EnumProperty {
  const EnumProperty(this.values, this.defaultValue);

  /// The words the property accepts, as `toJson` writes them - the `@JsonValue`
  /// of a constant where there is one, its name otherwise.
  final List<String> values;

  /// The word the constructor falls back to, or null where it has no default.
  final String? defaultValue;
}

/// Returns [root] with each enum-typed property in [enums] stating its values.
///
/// json_serializable has no branch for an enum: `_getPropertySchema` falls
/// through to the complex-type case, the element is not a `ClassElement`, and the
/// property comes out as a bare `{"type": "object"}` - no value list, no default,
/// nothing a reader could build a chooser from.
///
/// [enums] is the whole package's table, keyed by type name - [rootName] for the
/// root's own object, a `$defs` entry otherwise. A type this root does not reach
/// is skipped, so all three roots are handed the same table. Whatever the
/// generator did write for a property is kept, its `description` included.
Map<String, Object?> assembleEnums(
  Map<String, Object?> root,
  String rootName,
  Map<String, Map<String, EnumProperty>> enums,
) {
  final defs = <String, Object?>{...?root[r'$defs'] as Map<String, Object?>?};
  var rootProperties = root['properties'] as Map<String, Object?>?;

  enums.forEach((typeName, properties) {
    final owner = typeName == rootName ? rootProperties : (defs[typeName] as Map<String, Object?>?)?['properties'];
    if (owner is! Map<String, Object?>) return;

    final described = <String, Object?>{...owner};
    properties.forEach((name, property) {
      final generated = described[name];
      if (generated is! Map<String, Object?>) return;
      described[name] = <String, Object?>{
        'enum': property.values,
        for (final entry in generated.entries)
          if (entry.key != 'type') entry.key: entry.value,
        'default': ?property.defaultValue,
      };
    });

    if (typeName == rootName) {
      rootProperties = described;
    } else {
      defs[typeName] = <String, Object?>{...defs[typeName]! as Map<String, Object?>, 'properties': described};
    }
  });

  return <String, Object?>{...root, 'properties': ?rootProperties, if (defs.isNotEmpty) r'$defs': defs};
}
