import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/builder.dart';

/// What the builder reads out of a source file, and what it declines to invent.
///
/// The gate that a real contract is described correctly lives in the theme
/// package - `test/enum_property_test.dart` and `test/union_schema_test.dart`
/// walk the published schema. These tests are about the reading itself: the
/// shapes a model file can take, and which of them the builder can see.
void main() {
  group('enumPropertiesSource', () {
    test('a field of a declared enum is described with its values and default', () {
      final source = enumPropertiesSource([
        '''
enum Fit { fill, cover }

@freezed
@JsonSerializable(explicitToJson: true)
class Spec with _\$Spec {
  const Spec({this.fit = Fit.cover});

  @override
  final Fit fit;
}
''',
      ]);

      expect(source, contains("'Spec': {"));
      expect(source, contains("'fit': EnumProperty(<String>['fill', 'cover'], 'cover')"));
    });

    test('a field with no default says so rather than picking one', () {
      final source = enumPropertiesSource([
        'enum Fit { fill, cover }',
        'class Spec { const Spec({this.fit}); final Fit? fit; }',
      ]);

      expect(source, contains("'fit': EnumProperty(<String>['fill', 'cover'], null)"));
    });

    test('the words are what toJson writes, so @JsonValue wins over the name', () {
      final source = enumPropertiesSource([
        "enum Layout { @JsonValue('tabs') tabbed, unified }",
        'class Scheme { const Scheme({this.layout = Layout.tabbed}); final Layout layout; }',
      ]);

      expect(source, contains("'layout': EnumProperty(<String>['tabs', 'unified'], 'tabs')"));
    });

    test('a property renamed with @JsonKey is described under the name it is written as', () {
      final source = enumPropertiesSource([
        'enum Mode { light, dark }',
        "class Config { const Config({this.mode}); @JsonKey(name: 'theme_mode') final Mode? mode; }",
      ]);

      expect(source, contains("'theme_mode': EnumProperty(<String>['light', 'dark'], null)"));
    });

    test('a class carries the enum field it inherits', () {
      // json_serializable describes a subclass with its base's fields too, so a
      // base that holds the enum has to reach the subclass here as well.
      final source = enumPropertiesSource([
        'enum Mode { light, dark }',
        'class Base { const Base({this.mode = Mode.dark}); final Mode mode; }',
        'class Leaf extends Base { const Leaf(); }',
      ]);

      expect(source, contains("'Leaf': {\n    'mode': EnumProperty(<String>['light', 'dark'], 'dark'),"));
    });

    test('a field of a type this package does not declare is not guessed at', () {
      // The cost of reading source without resolving it: an enum from elsewhere
      // is not seen. It surfaces downstream as the bare object the theme
      // package's schema walk fails on, not as a wrong description here.
      final source = enumPropertiesSource(['class Spec { const Spec({this.fit}); final BoxFit? fit; }']);

      expect(source, isNot(contains("'Spec'")));
    });

    test('a property excluded from toJson is not described', () {
      final source = enumPropertiesSource([
        'enum Mode { light, dark }',
        'class Config { const Config({this.mode}); @JsonKey(includeToJson: false) final Mode? mode; }',
      ]);

      expect(source, isNot(contains("'Config'")));
    });
  });

  group('unionVariantsSource', () {
    test('a sealed base is described by the classes that extend it, in the order declared', () {
      final source = unionVariantsSource({
        'lib/models/pages/page_background.dart': '''
sealed class PageBackground {
  const PageBackground();
}

class PageBackgroundSolid extends PageBackground {
  const PageBackgroundSolid();
}

class PageBackgroundImage extends PageBackground {
  const PageBackgroundImage();
}
''',
      });

      expect(source, contains("import '../models/pages/page_background.dart';"));
      expect(
        source,
        contains(
          "  'PageBackground': {\n"
          "    'PageBackgroundSolid': PageBackgroundSolid.jsonSchema,\n"
          "    'PageBackgroundImage': PageBackgroundImage.jsonSchema,\n"
          '  },',
        ),
      );
    });

    test('a variant declared in another library is imported from there', () {
      final source = unionVariantsSource({
        'lib/models/a.dart': 'sealed class Union { const Union(); }',
        'lib/models/b.dart': 'class Variant extends Union { const Variant(); }',
      });

      expect(source, contains("import '../models/b.dart';"));
      expect(source, isNot(contains("import '../models/a.dart';")));
      // A single entry is short enough that the formatter keeps the map on one
      // line, so no trailing comma to match on.
      expect(source, contains("'Union': {'Variant': Variant.jsonSchema}"));
    });

    test('a sealed base with no variant is left out rather than offered empty', () {
      final source = unionVariantsSource({'lib/models/a.dart': 'sealed class Union { const Union(); }'});

      expect(source, isNot(contains("'Union'")));
    });

    test('an ordinary base class is not mistaken for a union', () {
      // Only `sealed` marks a union here. A plain base is a shared-field parent,
      // and the schema describes each subclass on its own.
      final source = unionVariantsSource({
        'lib/models/a.dart': 'class Base { const Base(); }\nclass Leaf extends Base { const Leaf(); }',
      });

      expect(source, isNot(contains("'Base'")));
    });
  });

  group('nullablePropertiesSource', () {
    test('a field whose type admits null is listed, one that does not is not', () {
      final source = nullablePropertiesSource([
        'class Config { const Config({this.a, this.b = 0.0}); final String? a; final double b; }',
      ]);

      expect(source, contains("'Config': ['a']"));
    });

    test('a property renamed with @JsonKey is listed under the name it is written as', () {
      final source = nullablePropertiesSource([
        "class Config { const Config({this.mode}); @JsonKey(name: 'theme_mode') final String? mode; }",
      ]);

      expect(source, contains("'Config': ['theme_mode']"));
    });

    test('a class with nothing nullable is left out', () {
      final source = nullablePropertiesSource(['class Config { const Config({this.a = 0.0}); final double a; }']);

      expect(source, isNot(contains("'Config'")));
    });

    test('a class carries the nullable field it inherits', () {
      final source = nullablePropertiesSource([
        'class Base { const Base({this.a}); final String? a; }',
        'class Leaf extends Base { const Leaf(); }',
      ]);

      expect(source, contains("'Leaf': ['a']"));
    });
  });
}
