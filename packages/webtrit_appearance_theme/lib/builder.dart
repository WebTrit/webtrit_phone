// The AST accessors this uses - `EnumDeclaration.constants`, `ClassDeclaration.members`,
// `.name` - are marked deprecated in analyzer 10.2 in favour of `body` and `namePart`.
// The replacement is only half landed: `ClassBody` is a public sealed marker that
// declares nothing, so a class's members are unreachable through it. Migrating what
// can be migrated would leave the file split across two spellings of the same walk,
// so it stays on one until the new shape is whole.
//
// The build tooling below is a dev dependency, and this library is named only by
// `build.yaml` - nothing at run time imports it - so `depend_on_referenced_packages`
// is silenced rather than answered by making a contract package depend on an
// analyzer.
// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:async';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';

/// The builder behind `webtrit_appearance_theme:schema_tables`.
Builder schemaTablesBuilder(BuilderOptions options) => SchemaTablesBuilder();

/// Writes the two things json_serializable's `create_json_schema` cannot state
/// about the theme contract: what an enum-typed property may hold, and which
/// classes a union is made of.
///
/// The generator reads fields off a source class and has no notion of either. An
/// enum property falls through to the complex-type case and is published as a
/// bare `{"type": "object"}`; a sealed base declares no fields, so it is
/// published as an empty object with no `oneOf` and no variant in sight. Both
/// gaps are filled by assembly at the point a root exposes its schema - and
/// everything the assembly needs is already in the source: the enum's constants,
/// the `@JsonValue` that may rename one, the default on the constructor
/// parameter, and which classes extend which sealed base.
///
/// The source is read **syntactically** - parsed, not resolved. Resolving would
/// need each model library's `part` files, which do not exist until freezed and
/// json_serializable have run, while those in turn need these tables to resolve
/// the roots that import them. Parsing has no such cycle, needs no build phase to
/// come first, and leans only on the AST, which moves far less than the element
/// model does between analyzer majors. The cost is that a type counts as an enum,
/// or as a variant, only within this package - which is where the contract lives.
class SchemaTablesBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const {
    r'$lib$': ['schema/enum_properties.g.dart', 'schema/union_variants.g.dart', 'schema/nullable_properties.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final sources = <String, String>{};
    await for (final input in buildStep.findAssets(Glob('lib/**.dart'))) {
      if (input.path.endsWith('.g.dart') || input.path.endsWith('.freezed.dart')) continue;
      sources[input.path] = await buildStep.readAsString(input);
    }

    // Sorted, because a union offers its variants in a fixed order and the glob
    // does not promise one.
    final ordered = <String, String>{for (final path in sources.keys.toList()..sort()) path: sources[path]!};

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/schema/enum_properties.g.dart'),
      enumPropertiesSource(ordered.values),
    );
    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/schema/union_variants.g.dart'),
      unionVariantsSource(ordered),
    );
    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/schema/nullable_properties.g.dart'),
      nullablePropertiesSource(ordered.values),
    );
  }
}

/// The properties of one type, by their JSON name.
typedef _Properties = Map<String, _Property>;

class _Property {
  const _Property(this.values, this.defaultValue);

  final List<String> values;
  final String? defaultValue;
}

class _EnumInfo {
  const _EnumInfo(this.name, this.byConstant);

  final String name;

  /// Constant name to the word it is written as in JSON.
  final Map<String, String> byConstant;
}

class _ClassInfo {
  const _ClassInfo(this.name, this.superName, this.isSealed, this.path, this.fields);

  final String name;
  final String? superName;
  final bool isSealed;

  /// The library that declares it, so a generated table can import it.
  final String path;

  final Map<String, _FieldInfo> fields;
}

class _FieldInfo {
  const _FieldInfo(this.jsonName, this.typeName, this.isNullable, this.defaultConstant);

  final String jsonName;
  final String typeName;

  /// Whether the field's Dart type admits null, and so whether a document may
  /// carry the key with `null` in it.
  final bool isNullable;

  /// The enum constant the constructor defaults this field to, if any.
  final String? defaultConstant;
}

/// Every enum and class [sources] declare, in the order they were handed over.
({Map<String, _EnumInfo> enums, List<_ClassInfo> classes}) _parse(Map<String, String> sources) {
  final enums = <String, _EnumInfo>{};
  final classes = <_ClassInfo>[];

  sources.forEach((path, source) {
    final unit = parseString(content: source, throwIfDiagnostics: false).unit;
    for (final declaration in unit.declarations) {
      if (declaration is EnumDeclaration) {
        final info = _enumInfo(declaration);
        enums[info.name] = info;
      } else if (declaration is ClassDeclaration) {
        classes.add(_classInfo(declaration, path));
      }
    }
  });

  return (enums: enums, classes: classes);
}

/// Every field a class is described with, its base's included.
///
/// The walk goes up `extends` within this package, which is as far as a shared
/// base ever reaches here, and a field already seen wins - the subclass overrides.
Iterable<_FieldInfo> _fieldsOf(_ClassInfo info, Map<String, _ClassInfo> byName) {
  final seen = <String, _FieldInfo>{};
  for (var owner = info; ;) {
    for (final field in owner.fields.values) {
      seen.putIfAbsent(field.jsonName, () => field);
    }
    final next = byName[owner.superName];
    if (next == null || next.name == owner.name) break;
    owner = next;
  }
  return seen.values;
}

/// The enum table [sources] describe, as the Dart of `enum_properties.g.dart`.
String enumPropertiesSource(Iterable<String> sources) {
  final parsed = _parse({for (final (index, source) in sources.indexed) 'lib/$index.dart': source});
  final byName = {for (final info in parsed.classes) info.name: info};

  final table = <String, _Properties>{};
  for (final info in parsed.classes) {
    final properties = <String, _Property>{};
    for (final field in _fieldsOf(info, byName)) {
      final declared = parsed.enums[field.typeName];
      if (declared == null) continue;
      properties[field.jsonName] = _Property(
        declared.byConstant.values.toList(),
        field.defaultConstant == null ? null : declared.byConstant[field.defaultConstant],
      );
    }

    if (properties.isNotEmpty) table[info.name] = properties;
  }

  final buffer = StringBuffer()
    ..writeln(_header)
    ..writeln("import 'union_assembly.dart';")
    ..writeln()
    ..writeln('/// Which properties of the published contract are enum-typed, and what each may hold.')
    ..writeln('///')
    ..writeln('/// json_serializable has no branch for an enum, so such a property comes out of')
    ..writeln('/// the generator as a bare `{"type": "object"}` - no values, no default.')
    ..writeln('/// [assembleEnums] fills them in from here.')
    ..writeln('const enumProperties = <String, Map<String, EnumProperty>>{');

  for (final typeName in table.keys.toList()..sort()) {
    buffer.writeln('  ${_string(typeName)}: {');
    final properties = table[typeName]!;
    for (final name in properties.keys.toList()..sort()) {
      final property = properties[name]!;
      final values = property.values.map(_string).join(', ');
      final fallback = property.defaultValue == null ? 'null' : _string(property.defaultValue!);
      buffer.writeln('    ${_string(name)}: EnumProperty(<String>[$values], $fallback),');
    }
    buffer.writeln('  },');
  }

  return _format(buffer..writeln('};'));
}

/// The nullability table [sources] describe, as the Dart of
/// `nullable_properties.g.dart`.
///
/// json_serializable does not model nullability: a field of type `String?` is
/// published as `{"type": "string"}`, so a document that carries the key with
/// `null` in it - which `toJson` writes and `fromJson` reads back - fails
/// validation against the very schema the class produced.
String nullablePropertiesSource(Iterable<String> sources) {
  final parsed = _parse({for (final (index, source) in sources.indexed) 'lib/$index.dart': source});
  final byName = {for (final info in parsed.classes) info.name: info};

  final table = <String, List<String>>{};
  for (final info in parsed.classes) {
    final nullable = [
      for (final field in _fieldsOf(info, byName))
        if (field.isNullable) field.jsonName,
    ]..sort();
    if (nullable.isNotEmpty) table[info.name] = nullable;
  }

  final buffer = StringBuffer()
    ..writeln(_header)
    ..writeln('/// Which properties of the published contract accept `null`.')
    ..writeln('///')
    ..writeln('/// json_serializable describes a field by its type without its nullability, so a')
    ..writeln('/// `String?` is published as `{"type": "string"}` and an explicit `null` - which')
    ..writeln('/// `toJson` writes and `fromJson` reads - fails against it.')
    ..writeln('/// [assembleNullability] widens the ones listed here.')
    ..writeln('const nullableProperties = <String, List<String>>{');

  for (final typeName in table.keys.toList()..sort()) {
    final names = table[typeName]!.map(_string).join(', ');
    buffer.writeln('  ${_string(typeName)}: [$names],');
  }

  return _format(buffer..writeln('};'));
}

/// The union table [sources] describe, as the Dart of `union_variants.g.dart`.
///
/// Keyed by path, because the table names each variant's own `jsonSchema` and so
/// has to import the library that declares it.
String unionVariantsSource(Map<String, String> sources) {
  final parsed = _parse(sources);

  final unions = <String, List<_ClassInfo>>{
    for (final info in parsed.classes)
      if (info.isSealed) info.name: [],
  };
  for (final info in parsed.classes) {
    unions[info.superName]?.add(info);
  }
  unions.removeWhere((_, variants) => variants.isEmpty);

  final imports = {
    for (final variants in unions.values)
      for (final variant in variants) _importOf(variant.path),
  }.toList()..sort();

  final buffer = StringBuffer()..writeln(_header);
  for (final import in imports) {
    buffer.writeln("import '$import';");
  }
  buffer
    ..writeln()
    ..writeln('/// Which classes each union of the published contract is made of.')
    ..writeln('///')
    ..writeln('/// A sealed base declares no fields of its own, so the generator publishes it as')
    ..writeln('/// an empty object and reaches none of its variants. [assembleUnions] turns it')
    ..writeln('/// into a `oneOf` over the schemas below.')
    ..writeln('const unionVariants = <String, Map<String, Map<String, Object?>>>{');

  for (final union in unions.keys.toList()..sort()) {
    buffer.writeln('  ${_string(union)}: {');
    for (final variant in unions[union]!) {
      buffer.writeln('    ${_string(variant.name)}: ${variant.name}.jsonSchema,');
    }
    buffer.writeln('  },');
  }

  return _format(buffer..writeln('};'));
}

const _header = '// GENERATED CODE - DO NOT MODIFY BY HAND\n';

/// Both tables are written into `lib/schema/`, so a model library is one level up.
String _importOf(String path) => '../${path.startsWith('lib/') ? path.substring('lib/'.length) : path}';

String _format(StringBuffer buffer) =>
    DartFormatter(languageVersion: DartFormatter.latestLanguageVersion, pageWidth: 120).format(buffer.toString());

_EnumInfo _enumInfo(EnumDeclaration declaration) {
  final byConstant = <String, String>{};
  for (final constant in declaration.constants) {
    final name = constant.name.lexeme;
    byConstant[name] = _stringArgument(constant.metadata, 'JsonValue') ?? name;
  }
  return _EnumInfo(declaration.name.lexeme, byConstant);
}

_ClassInfo _classInfo(ClassDeclaration declaration, String path) {
  final defaults = <String, String>{};
  for (final member in declaration.members) {
    if (member is! ConstructorDeclaration || member.name != null) continue;
    for (final parameter in member.parameters.parameters) {
      if (parameter is! DefaultFormalParameter) continue;
      final name = parameter.name?.lexeme;
      final value = parameter.defaultValue;
      if (name != null && value != null) defaults[name] = value.toSource();
    }
  }

  final fields = <String, _FieldInfo>{};
  for (final member in declaration.members) {
    if (member is! FieldDeclaration || member.isStatic) continue;
    final type = member.fields.type;
    if (type == null) continue;
    if (_boolArgument(member.metadata, 'JsonKey', 'includeToJson') == false) continue;
    final jsonKeyDefault = _namedArgument(member.metadata, 'JsonKey', 'defaultValue')?.toSource();
    for (final variable in member.fields.variables) {
      final name = variable.name.lexeme;
      fields[name] = _FieldInfo(
        _stringArgument(member.metadata, 'JsonKey', named: 'name') ?? name,
        _bareTypeName(type),
        type.toSource().endsWith('?'),
        _enumConstantOf(jsonKeyDefault ?? defaults[name]),
      );
    }
  }

  return _ClassInfo(
    declaration.name.lexeme,
    declaration.extendsClause?.superclass.name.lexeme,
    declaration.sealedKeyword != null,
    path,
    fields,
  );
}

/// The type without its nullability, so `BoxFitConfig?` reads as `BoxFitConfig`.
String _bareTypeName(TypeAnnotation type) {
  final source = type.toSource();
  return source.endsWith('?') ? source.substring(0, source.length - 1) : source;
}

/// The constant of `SomeEnum.someValue`, or null for anything else.
String? _enumConstantOf(String? expression) {
  if (expression == null) return null;
  final match = RegExp(r'^(\w+)\.(\w+)$').firstMatch(expression);
  return match?.group(2);
}

Expression? _namedArgument(List<Annotation> metadata, String annotation, String argument) {
  for (final entry in metadata) {
    if (entry.name.name != annotation) continue;
    for (final expression in entry.arguments?.arguments ?? const <Expression>[]) {
      if (expression is NamedExpression && expression.name.label.name == argument) return expression.expression;
    }
  }
  return null;
}

/// The value of a string argument - the sole positional one of `@JsonValue`, or
/// the [named] one of `@JsonKey`.
String? _stringArgument(List<Annotation> metadata, String annotation, {String? named}) {
  if (named != null) {
    final expression = _namedArgument(metadata, annotation, named);
    return expression is SimpleStringLiteral ? expression.value : null;
  }
  for (final entry in metadata) {
    if (entry.name.name != annotation) continue;
    final positional = entry.arguments?.arguments.firstOrNull;
    if (positional is SimpleStringLiteral) return positional.value;
  }
  return null;
}

bool? _boolArgument(List<Annotation> metadata, String annotation, String argument) {
  final expression = _namedArgument(metadata, annotation, argument);
  return expression is BooleanLiteral ? expression.value : null;
}

String _string(String value) => "'${value.replaceAll(r'\', r'\\').replaceAll("'", r"\'")}'";
