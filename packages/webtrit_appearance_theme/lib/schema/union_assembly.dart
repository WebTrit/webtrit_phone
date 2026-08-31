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

/// An enum-typed property: the values it may take, and where its default is
/// written.
class EnumProperty {
  const EnumProperty(this.values, this.defaultsOf);

  /// The enum's values, in declaration order. Their JSON spelling is
  /// [Enum.name] - no enum in this package renames one with `@JsonValue`.
  final List<Enum> values;

  /// `toJson` of an instance built with nothing but its required arguments.
  ///
  /// The default is read back off that rather than repeated here, so the
  /// constructor stays the one place a default is written and no table can
  /// drift from it.
  final Map<String, Object?> Function() defaultsOf;
}

/// Returns [root] with each enum-typed property in [enums] stating its values.
///
/// json_serializable has no branch for an enum: `_getPropertySchema` falls
/// through to the complex-type case, the element is not a `ClassElement`, and the
/// property comes out as a bare `{"type": "object"}` - no value list, no default,
/// nothing a reader could build a chooser from.
///
/// [enums] maps a type's name - [rootName] for the root's own object, a `$defs`
/// entry otherwise - to its enum properties. Whatever the generator did write for
/// the property is kept, its `description` included.
Map<String, Object?> assembleEnums(
  Map<String, Object?> root,
  String rootName,
  Map<String, Map<String, EnumProperty>> enums,
) {
  final defs = <String, Object?>{...?root[r'$defs'] as Map<String, Object?>?};
  var rootProperties = root['properties'] as Map<String, Object?>?;

  enums.forEach((typeName, properties) {
    final owner = typeName == rootName ? rootProperties : (defs[typeName] as Map<String, Object?>?)?['properties'];
    if (owner is! Map<String, Object?>) {
      throw StateError('$typeName is named as carrying an enum property but the schema does not describe it');
    }

    final described = <String, Object?>{...owner};
    properties.forEach((name, property) {
      final generated = described[name];
      if (generated is! Map<String, Object?>) {
        throw StateError('$typeName.$name is named as an enum property but the schema does not describe it');
      }
      final fallback = property.defaultsOf()[name];
      described[name] = <String, Object?>{
        'enum': [for (final value in property.values) value.name],
        for (final entry in generated.entries)
          if (entry.key != 'type') entry.key: entry.value,
        'default': ?fallback,
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
