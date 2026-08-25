// Takes the translation catalog's export and puts it in place of the ARB files
// in this repository - but only when the export is not older than the code.
//
// `configurator-translations-fetch` OVERWRITES each app_<locale>.arb with what
// the catalog holds; it does not merge. That is correct - the catalog owns the
// values - but it makes the command destructive whenever the catalog has not
// been synced since the last keys were added here. The catalog would simply not
// carry them, and overwriting would delete them from every locale at once. The
// app calls those keys, so the damage surfaces as `undefined_getter` from
// `flutter analyze` on generated code, a long way from the command that caused
// it.
//
// So the export is fetched to a scratch directory and adopted only if it covers
// every key the current template defines. If it does not, nothing is written
// and the missing keys are named: the fix is to run `npm run translations:sync`
// in the configurator backend against a ref that carries this code, not to
// force the files across.
//
// Usage: dart tool/adopt_l10n_export.dart <export-dir> [--dry-run]

import 'dart:convert';
import 'dart:io';

const arbDir = 'lib/l10n/arb';
const templateFile = 'app_en.arb';

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final positional = args.where((a) => !a.startsWith('--')).toList();
  if (positional.length != 1) {
    stderr.writeln('Usage: dart tool/adopt_l10n_export.dart <export-dir> [--dry-run]');
    exit(64);
  }
  final exportDir = positional.single;

  final current = _read('$arbDir/$templateFile');
  final exported = _read('$exportDir/$templateFile');

  final currentKeys = current.keys.where((k) => !k.startsWith('@')).toSet();
  final exportedKeys = exported.keys.where((k) => !k.startsWith('@')).toSet();

  final missing = (currentKeys.difference(exportedKeys).toList()..sort());
  if (missing.isNotEmpty) {
    stderr.writeln(
      'The catalog export is behind this repository: it carries ${exportedKeys.length} keys '
      'where $templateFile defines ${currentKeys.length}, so adopting it would delete '
      '${missing.length} of them from every locale.',
    );
    stderr.writeln('\nFirst of the ${missing.length}:');
    for (final key in missing.take(10)) {
      stderr.writeln('  $key');
    }
    if (missing.length > 10) stderr.writeln('  ... and ${missing.length - 10} more');
    stderr.writeln(
      '\nRun `npm run translations:sync` in the configurator backend against a ref that '
      'carries these keys, then pull again. Nothing was written.',
    );
    exit(1);
  }

  // All locales or nothing, for the same reason the fetch itself insists on it:
  // a partial set leaves some locales current and others frozen, and nothing
  // afterwards says which is which.
  final localeFiles =
      Directory(arbDir)
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last)
          .where((name) => name.endsWith('.arb'))
          .toList()
        ..sort();

  final absent = localeFiles.where((name) => !File('$exportDir/$name').existsSync()).toList();
  if (absent.isNotEmpty) {
    stderr.writeln('The export is missing ${absent.join(', ')}. Nothing was written.');
    exit(1);
  }

  // Compared by CONTENT, not by text. The ARB files here are not formatted the
  // way the export renders them - some `@key` objects sit on one line, some are
  // expanded, because that is what years of gen-l10n and hand edits left - and
  // the export also orders keys differently. Comparing the bytes would call
  // every file changed on every pull and bury a one-word correction under three
  // thousand lines of reformatting. A file whose content matches is left
  // exactly as it is.
  var written = 0;
  for (final name in localeFiles) {
    final source = File('$exportDir/$name');
    final destination = File('$arbDir/$name');
    if (_canonical(_read(source.path)) == _canonical(_read(destination.path))) {
      stdout.writeln('  unchanged  $name');
      continue;
    }
    stdout.writeln('  updated    $name');
    written++;
    if (!dryRun) source.copySync(destination.path);
  }
  if (written == 0) {
    stdout.writeln('The catalog holds exactly what this repository holds. Nothing to do.');
    return;
  }

  stdout.writeln(
    dryRun
        ? 'Dry run: $written file(s) would be rewritten, nothing written.'
        : 'Adopted the catalog export into $written file(s). '
              'Run `melos run l10n:generate` next.',
  );
}

/// A form two ARB files can be compared by: key order and whitespace removed,
/// so only a difference in what a key MEANS counts as a change.
String _canonical(Map<String, dynamic> arb) {
  final keys = arb.keys.toList()..sort();
  return jsonEncode({for (final key in keys) key: arb[key]});
}

Map<String, dynamic> _read(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('$path: not found');
    exit(1);
  }
  try {
    return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  } on FormatException catch (e) {
    stderr.writeln('$path: invalid JSON - ${e.message}');
    exit(1);
  }
}
