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
/// [unions] is the whole package's table, mapping a union's type name to its
/// variants, each variant's name to the schema generated for it. A union this
/// root does not reach is skipped - the generator leaves an empty object in
/// `$defs` for one it does, and that placeholder is what says so - so all three
/// roots are handed the same table.
///
/// A variant's schema is a root in its own right, so three things are done to it:
/// its `$schema` header is dropped, its own `$defs` are lifted into the root's
/// (an existing entry wins, the names being unique across the package), and a
/// self-reference - `{"$ref": "#"}`, which meant "this variant" while the variant
/// was the root - is rewritten to point at where the variant now lives.
Map<String, Object?> assembleUnions(Map<String, Object?> root, Map<String, Map<String, Map<String, Object?>>> unions) {
  final defs = <String, Object?>{...?root[r'$defs'] as Map<String, Object?>?};

  unions.forEach((union, variants) {
    if (!defs.containsKey(union)) return;

    for (final variant in variants.entries) {
      final schema = <String, Object?>{...variant.value}
        ..remove(r'$schema')
        ..remove(r'$defs');
      defs[variant.key] = _pinDiscriminator(_pointSelfRefsAt(schema, variant.key) as Map<String, Object?>);

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

/// The key every union in this contract dispatches on. Each `fromJson` switches
/// on `json['type']`, and each variant declares `type` with its own word as the
/// default; `test/union_schema_test.dart` compares the two, so a drift is caught.
const _discriminator = 'type';

/// Returns [schema] with its discriminator pinned to the one value it may hold.
///
/// Without this the property is a plain `string` carrying a `default`, and every
/// variant of a union accepts every other variant's word - so a document matches
/// several branches of the `oneOf` at once, and `oneOf` demands exactly one. A
/// `bottomMenu` tab of the shipped `app.config.json` matched six of seven.
///
/// The value is not stated here: it is the `default` the generator already wrote
/// from the variant's own field.
Map<String, Object?> _pinDiscriminator(Map<String, Object?> schema) {
  final properties = schema['properties'];
  if (properties is! Map<String, Object?>) return schema;
  final described = properties[_discriminator];
  if (described is! Map<String, Object?>) return schema;
  final value = described['default'];
  if (value == null) return schema;

  return <String, Object?>{
    ...schema,
    'properties': <String, Object?>{
      ...properties,
      _discriminator: <String, Object?>{...described, 'const': value},
    },
  };
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
/// Written by `lib/builder.dart` into `enum_properties.g.dart`,
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

/// Returns [root] with every property in [nullable] widened to accept `null`.
///
/// json_serializable describes a field by its Dart type and drops the
/// nullability, so a `String?` is published as `{"type": "string"}` - and an
/// explicit `null`, which `toJson` writes and `fromJson` reads back, fails
/// against the schema the class itself produced. The shipped `app.config.json`
/// carries two.
///
/// [nullable] is the whole package's table, keyed by type name - [rootName] for
/// the root's own object, a `$defs` entry otherwise. A type this root does not
/// reach is skipped, so all three roots are handed the same table.
Map<String, Object?> assembleNullability(
  Map<String, Object?> root,
  String rootName,
  Map<String, List<String>> nullable,
) {
  final defs = <String, Object?>{...?root[r'$defs'] as Map<String, Object?>?};
  var rootProperties = root['properties'] as Map<String, Object?>?;

  void widen(Map<String, Object?> owner, List<String> names, Map<String, Object?> Function(Map<String, Object?>) put) {
    final described = <String, Object?>{...owner};
    var changed = false;
    for (final name in names) {
      final property = described[name];
      if (property is! Map<String, Object?>) continue;
      described[name] = _admitNull(property);
      changed = true;
    }
    if (changed) put(described);
  }

  nullable.forEach((typeName, names) {
    if (typeName == rootName) {
      final owner = rootProperties;
      if (owner != null) {
        widen(owner, names, (described) => rootProperties = described);
      }
      return;
    }

    final def = defs[typeName];
    if (def is! Map<String, Object?>) return;
    final owner = def['properties'];
    if (owner is! Map<String, Object?>) return;
    widen(owner, names, (described) => defs[typeName] = <String, Object?>{...def, 'properties': described});
  });

  return <String, Object?>{...root, 'properties': ?rootProperties, if (defs.isNotEmpty) r'$defs': defs};
}

/// Returns [property] describing the same thing, plus `null`.
///
/// Four shapes appear in a generated schema and each admits null differently: a
/// `$ref` has to be wrapped, because a sibling keyword beside `$ref` is ignored
/// in draft 2020-12; a stated `enum` takes null as one more member; a plain
/// `type` becomes a list of two; and anything already widened is left alone.
Map<String, Object?> _admitNull(Map<String, Object?> property) {
  if (property.containsKey(r'$ref')) {
    final ref = <String, Object?>{r'$ref': property[r'$ref']};
    return <String, Object?>{
      for (final entry in property.entries)
        if (entry.key != r'$ref') entry.key: entry.value,
      'anyOf': [
        ref,
        const <String, Object?>{'type': 'null'},
      ],
    };
  }

  final values = property['enum'];
  if (values is List<Object?>) {
    if (values.contains(null)) return property;
    return <String, Object?>{
      ...property,
      'enum': [...values, null],
    };
  }

  final type = property['type'];
  if (type is String) {
    return <String, Object?>{
      ...property,
      'type': [type, 'null'],
    };
  }

  return property;
}
