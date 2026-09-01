// The AST accessors this uses - `EnumDeclaration.constants`, `ClassDeclaration.members`,
// `.name` - are marked deprecated in analyzer 10.2 in favour of `body` and `namePart`.
// The replacement is only half landed: `ClassBody` is a public sealed marker that
// declares nothing, so a class's members are unreachable through it. Migrating what
// can be migrated would leave the file split across two spellings of the same walk,
// so it stays on one until the new shape is whole.
// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';

/// Writes the one fact json_serializable cannot state about an enum-typed
/// property: which values it may take, and which of them it defaults to.
///
/// The generator has no branch for an enum at all - such a property falls
/// through to the complex-type case and comes out as a bare `{"type": "object"}`.
/// Everything needed to fix that is already in the source: the enum's constants,
/// the `@JsonValue` that may rename one, and the default written on the
/// constructor parameter. This reads them and writes the table the schema
/// assembly consumes, so nothing is kept by hand and nothing can drift.
///
/// The source is read **syntactically** - parsed, not resolved. Resolving would
/// need each model library's `part` files, which do not exist until freezed and
/// json_serializable have run, while those in turn need this table's output to
/// resolve the roots that import it. Parsing has no such cycle, needs no build
/// phase to come first, and leans only on the AST, which moves far less than the
/// element model does between analyzer majors. The cost is that a type counts as
/// an enum only if this package declares it - one from elsewhere is not seen, and
/// shows up as the bare object `test/enum_property_test.dart` fails on.
class EnumPropertiesBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const {
    r'$lib$': ['schema/enum_properties.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final sources = <String>[];
    await for (final input in buildStep.findAssets(Glob('lib/**.dart'))) {
      if (input.path.endsWith('.g.dart') || input.path.endsWith('.freezed.dart')) continue;
      sources.add(await buildStep.readAsString(input));
    }

    final output = AssetId(buildStep.inputId.package, 'lib/schema/enum_properties.g.dart');
    await buildStep.writeAsString(output, enumPropertiesSource(sources));
  }
}

/// The table [sources] describe, as the Dart of `enum_properties.g.dart`.
String enumPropertiesSource(Iterable<String> sources) {
  final enums = <String, _EnumInfo>{};
  final classes = <String, _ClassInfo>{};

  for (final source in sources) {
    final unit = parseString(content: source, throwIfDiagnostics: false).unit;
    for (final declaration in unit.declarations) {
      if (declaration is EnumDeclaration) {
        final info = _enumInfo(declaration);
        enums[info.name] = info;
      } else if (declaration is ClassDeclaration) {
        final info = _classInfo(declaration);
        classes[info.name] = info;
      }
    }
  }

  return _render(_table(classes, enums));
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
  const _ClassInfo(this.name, this.superName, this.fields);

  final String name;
  final String? superName;
  final Map<String, _FieldInfo> fields;
}

class _FieldInfo {
  const _FieldInfo(this.jsonName, this.typeName, this.defaultConstant);

  final String jsonName;
  final String typeName;

  /// The enum constant the constructor defaults this field to, if any.
  final String? defaultConstant;
}

_EnumInfo _enumInfo(EnumDeclaration declaration) {
  final byConstant = <String, String>{};
  for (final constant in declaration.constants) {
    final name = constant.name.lexeme;
    byConstant[name] = _stringArgument(constant.metadata, 'JsonValue') ?? name;
  }
  return _EnumInfo(declaration.name.lexeme, byConstant);
}

_ClassInfo _classInfo(ClassDeclaration declaration) {
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
        _enumConstantOf(jsonKeyDefault ?? defaults[name]),
      );
    }
  }

  return _ClassInfo(declaration.name.lexeme, declaration.extendsClause?.superclass.name.lexeme, fields);
}

/// The table, keyed by the type name the schema describes the class under.
///
/// A class inherits its base's fields, so the walk goes up `extends` - within
/// this package, which is as far as a shared base ever reaches here.
Map<String, _Properties> _table(Map<String, _ClassInfo> classes, Map<String, _EnumInfo> enums) {
  final table = <String, _Properties>{};

  for (final entry in classes.entries) {
    final properties = <String, _Property>{};
    for (var owner = entry.value; ;) {
      for (final field in owner.fields.values) {
        final declared = enums[field.typeName];
        if (declared == null || properties.containsKey(field.jsonName)) continue;
        properties[field.jsonName] = _Property(
          declared.byConstant.values.toList(),
          field.defaultConstant == null ? null : declared.byConstant[field.defaultConstant],
        );
      }
      final next = classes[owner.superName];
      if (next == null || next.name == owner.name) break;
      owner = next;
    }
    if (properties.isNotEmpty) table[entry.key] = properties;
  }

  return table;
}

String _render(Map<String, _Properties> table) {
  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln()
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

  buffer.writeln('};');

  return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion, pageWidth: 120).format(buffer.toString());
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
