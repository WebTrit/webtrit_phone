import 'package:test/test.dart';
import 'package:webtrit_appearance_theme_builder/src/enum_properties_builder.dart';

/// What the builder reads out of a source file, and what it declines to invent.
///
/// The gate that a real contract is described correctly lives in the theme
/// package - `test/enum_property_test.dart` walks the published schema. These
/// tests are about the reading itself: the shapes a model file can take, and
/// which of them carry a default.
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
}
