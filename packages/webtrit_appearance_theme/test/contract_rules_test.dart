import 'dart:io';

import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/builder.dart';

/// The contract stays describable by the released json_serializable.
///
/// That generator reads fields off the source class and knows nothing about a
/// union, an enum or a converter. Five ordinary-looking things you could write in
/// a DTO make it describe the contract wrongly, or stop describing it at all -
/// and one of them, a non-empty collection default, takes `fromJson` and `toJson`
/// down with it, so the damage is not limited to the schema.
///
/// This test reads the package's own source and fails by name on each. It exists
/// so that extending the contract needs no memory of any of it: write the DTO,
/// run the tests, and the rule you broke says what to do instead.
///
/// The companion checks are `enum_property_test.dart` and `union_schema_test.dart`
/// over the published schema, and `test/theme/shipped_theme_validates_test.dart`
/// in the parent project, which validates the app's own assets against it.
void main() {
  /// Every source file of the package, by path.
  Map<String, String> sourcesOf(String directory) => {
    for (final file in Directory(directory).listSync(recursive: true).whereType<File>())
      if (file.path.endsWith('.dart') && !file.path.endsWith('.g.dart') && !file.path.endsWith('.freezed.dart'))
        file.path: file.readAsStringSync(),
  };

  group('what the contract may not do', () {
    test('the package breaks none of the rules', () {
      final violations = contractViolations(
        sourcesOf('lib'),
        cliSource: File('bin/print_json_schema.dart').readAsStringSync(),
      );

      expect(
        violations,
        isEmpty,
        reason: 'The published schema will not describe this correctly:\n${violations.join('\n')}',
      );
    });
  });

  group('what each rule catches', () {
    // Each of these is the shape the rule exists to stop, written out, so the
    // rule itself is tested rather than only trusted.
    List<String> rulesBrokenBy(String source, {String? cli}) =>
        contractViolations({'lib/a.dart': source}, cliSource: cli).map((violation) => violation.rule).toList();

    test('a non-empty collection default', () {
      expect(
        rulesBrokenBy('''
@JsonSerializable(explicitToJson: true)
class Config {
  const Config({this.stops = const [0.0, 1.0]});
  final List<double> stops;
}
'''),
        ['collection-default'],
      );
    });

    test('an empty collection default is allowed', () {
      expect(
        rulesBrokenBy('''
@JsonSerializable(explicitToJson: true)
class Config {
  const Config({this.stops = const <double>[]});
  final List<double> stops;
}
'''),
        isEmpty,
      );
    });

    test('a converter that is not on the allowed list', () {
      expect(
        rulesBrokenBy('''
@JsonSerializable(explicitToJson: true)
class Config {
  const Config({this.codePoint});
  @HexCodePointConverter()
  final int? codePoint;
}
'''),
        ['converter'],
      );
    });

    test('UriConverter is allowed', () {
      expect(
        rulesBrokenBy('''
@JsonSerializable(explicitToJson: true)
class Config {
  const Config({this.uri});
  @UriConverter()
  final Uri? uri;
}
'''),
        isEmpty,
      );
    });

    test('a freezed union', () {
      expect(
        rulesBrokenBy('''
@Freezed(unionKey: 'type')
sealed class Background with _\$Background {
  const factory Background.solid({String color}) = BackgroundSolid;
}
'''),
        ['freezed-union'],
      );
    });

    test('state on a generated impl instead of the class', () {
      expect(
        rulesBrokenBy('''
@freezed
@JsonSerializable(explicitToJson: true)
class Config with _\$Config {
  const factory Config({double? radius}) = _Config;
}
'''),
        ['factory-shape'],
      );
    });

    test('a schema asked for but not exposed', () {
      expect(
        rulesBrokenBy('''
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class Config {
  const Config({this.a});
  final String? a;
}
'''),
        ['unreachable-schema'],
      );
    });

    test('a root the CLI cannot print', () {
      const source = '''
@JsonSerializable(explicitToJson: true, createJsonSchema: true)
class Config {
  const Config({this.a});
  final String? a;
  static final Map<String, Object?> jsonSchema = {};
}
''';

      expect(rulesBrokenBy(source, cli: 'final _roots = {};'), ['unprintable-root']);
      expect(rulesBrokenBy(source, cli: "{'Config': Config.jsonSchema}"), isEmpty);
    });
  });
}
