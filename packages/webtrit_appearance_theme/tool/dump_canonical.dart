// Regenerates the canonical theme artifacts (`canonical/*.json`) straight from
// the DTOs, so they are the single source of truth and always conform to the
// current `webtrit_appearance_theme` schema.
//
// Each file is parsed with the matching DTO `fromJson` and re-emitted with
// `toJson` — i.e. normalized to whatever the DTOs currently produce. When a DTO
// changes (field added/renamed/removed), re-running this re-normalizes the
// output; `git diff` and `test/canonical_test.dart` then surface the drift.
//
// Seeds from the phone app's example assets on first run (when a canonical file
// is missing), then operates in-place.
//
// Run from the package root:  dart run tool/dump_canonical.dart
import 'dart:convert';
import 'dart:io';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

typedef Normalizer = Map<String, dynamic> Function(Map<String, dynamic>);

/// target file -> (normalizer, seed asset relative to the phone repo assets)
final Map<String, ({Normalizer normalize, String seed})> kSpecs = {
  'color.light.json': (
    normalize: (j) => ColorSchemeConfig.fromJson(j).toJson(),
    seed: 'original.color_scheme.light.config.json',
  ),
  'color.dark.json': (
    normalize: (j) => ColorSchemeConfig.fromJson(j).toJson(),
    seed: 'original.color_scheme.dark.config.json',
  ),
  'widget.light.json': (
    normalize: (j) => ThemeWidgetConfig.fromJson(j).toJson(),
    seed: 'original.widget.light.config.json',
  ),
  'widget.dark.json': (
    normalize: (j) => ThemeWidgetConfig.fromJson(j).toJson(),
    seed: 'original.widget.dark.config.json',
  ),
  'page.light.json': (normalize: (j) => ThemePageConfig.fromJson(j).toJson(), seed: 'original.page.light.config.json'),
  'page.dark.json': (normalize: (j) => ThemePageConfig.fromJson(j).toJson(), seed: 'original.page.dark.config.json'),
  'app.config.json': (normalize: (j) => AppConfig.fromJson(j).toJson(), seed: 'app.config.json'),
};

const _canonicalDir = 'canonical';
const _assetsDir = '../../assets/themes'; // phone app example assets (seed only)

void main() {
  Directory(_canonicalDir).createSync(recursive: true);
  const encoder = JsonEncoder.withIndent('  ');

  for (final entry in kSpecs.entries) {
    final target = File('$_canonicalDir/${entry.key}');
    final sourceFile = target.existsSync() ? target : File('$_assetsDir/${entry.value.seed}');

    if (!sourceFile.existsSync()) {
      stderr.writeln('SKIP ${entry.key}: no canonical and no seed (${sourceFile.path})');
      continue;
    }

    final raw = jsonDecode(sourceFile.readAsStringSync()) as Map<String, dynamic>;
    final normalized = entry.value.normalize(raw);
    target.writeAsStringSync('${encoder.convert(normalized)}\n');
    stdout.writeln('normalized ${entry.key}${target == sourceFile ? '' : ' (seeded from ${entry.value.seed})'}');
  }

  stdout.writeln('Done. Review `git diff canonical/` for any schema drift.');
}
