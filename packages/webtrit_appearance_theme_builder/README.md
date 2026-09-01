# webtrit_appearance_theme_builder

Build-time generator for `webtrit_appearance_theme`. One builder,
`enum_properties`, which writes `lib/schema/enum_properties.g.dart` into that
package: the enum-typed properties of the published contract, the words each one
accepts, and the word it defaults to.

It exists because json_serializable's `create_json_schema` has no branch for an
enum — such a property falls through to the complex-type case and comes out as a
bare `{"type": "object"}`, with no values and no default. Everything needed to
say more is already in the source, so nothing here is kept by hand.

The source is read syntactically, parsed rather than resolved: resolving a model
library needs its `part` files, which do not exist until freezed and
json_serializable have run, and those in turn need this table to resolve the
roots that import it. Parsing has no such cycle, and leans only on the AST.

Applied from the theme package's `build.yaml`; it runs with `build_runner` and
needs no separate command. `test/enum_property_test.dart` over there is the gate:
it reads none of this output, walks the published schema, and fails on any
property still described as a bare object.
