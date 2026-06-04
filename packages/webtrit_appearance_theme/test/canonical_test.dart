// Drift guard for the canonical theme artifacts (`canonical/*.json`).
//
// Each file must survive a DTO round-trip without data loss: parsing it with the
// matching DTO `fromJson` and re-emitting via `toJson` must preserve every real
// (non-null) value (key order and freezed's default `null` fields are ignored).
// If a DTO field is renamed/removed (or a canonical file is hand-edited into a
// non-conforming shape) without re-running `tool/dump_canonical.dart`, a real
// value changes or disappears and this test fails — making schema drift
// impossible to merge silently.
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

typedef Normalizer = Map<String, dynamic> Function(Map<String, dynamic>);

final Map<String, Normalizer> _specs = {
  'color.light.json': (j) => ColorSchemeConfig.fromJson(j).toJson(),
  'color.dark.json': (j) => ColorSchemeConfig.fromJson(j).toJson(),
  'widget.light.json': (j) => ThemeWidgetConfig.fromJson(j).toJson(),
  'widget.dark.json': (j) => ThemeWidgetConfig.fromJson(j).toJson(),
  'page.light.json': (j) => ThemePageConfig.fromJson(j).toJson(),
  'page.dark.json': (j) => ThemePageConfig.fromJson(j).toJson(),
  'app.config.json': (j) => AppConfig.fromJson(j).toJson(),
};

/// Key-sorted JSON with null map entries dropped, so comparison ignores key
/// ordering and the default `null` fields freezed `toJson` adds. What remains
/// are the real (non-null) values — a renamed/removed DTO field changes or drops
/// one of those, which this catches; added default-null fields are tolerated.
/// Force full JSON serialization first (toJson may leave nested typed objects),
/// then drop nulls + sort keys.
String _stable(Object? o) => jsonEncode(_clean(jsonDecode(jsonEncode(o))));
Object? _clean(Object? o) {
  if (o is Map) {
    final keys = o.keys.map((k) => k.toString()).toList()..sort();
    final out = <String, Object?>{};
    for (final k in keys) {
      final v = _clean(o[k]);
      if (v != null) out[k] = v;
    }
    return out;
  }
  if (o is List) return o.map(_clean).toList();
  return o;
}

void main() {
  group('canonical theme is in DTO-normal form', () {
    for (final entry in _specs.entries) {
      test('${entry.key} matches its DTO round-trip', () {
        final file = File('canonical/${entry.key}');
        expect(file.existsSync(), isTrue, reason: 'missing ${file.path}; run: dart run tool/dump_canonical.dart');

        final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        final normalized = entry.value(raw);

        expect(
          _stable(normalized),
          _stable(raw),
          reason: 'Schema drift in ${entry.key}. Re-run: dart run tool/dump_canonical.dart',
        );
      });
    }
  });
}
