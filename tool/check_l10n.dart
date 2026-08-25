// Validates ARB localization files against the template (app_en.arb):
//   1. every file is valid JSON;
//   2. every locale carries exactly the template's key set (including @-metadata);
//   3. ICU placeholder arguments in every translated value match the template value;
//   4. no empty values, except the intentionally empty white-label keys below;
//   5. every template key is covered by the generated l10n mapper
//      (lib/l10n/app_localizations.g.mapper.dart) - a missing key means
//      `dart run build_runner build` was not run after `flutter gen-l10n`.
//   6. the generated l10n sources are formatted at the project page width.
//      `flutter gen-l10n` and `build_runner` format their output at the Dart
//      default of 80 columns and neither reads `formatter.page_width` from
//      analysis_options.yaml, so a regeneration that skips the reformat lands
//      as a few thousand lines of rewrapping noise on top of the real change.
//      The repository's `fmt` scripts deliberately skip generated files, so
//      nothing else would catch it.
//
// Usage: dart tool/check_l10n.dart (or `melos run l10n:check`). Exits 1 on any finding.

import 'dart:convert';
import 'dart:io';

const arbDir = 'lib/l10n/arb';
const templateFile = 'app_en.arb';
const mapperFile = 'lib/l10n/app_localizations.g.mapper.dart';
const generatedDir = 'lib/l10n';

// Keep in step with `formatter.page_width` in analysis_options.yaml and with the
// `--line-length` the fmt scripts in pubspec.yaml pass.
const pageWidth = 120;

// White-label placeholders: intentionally empty in every locale, filled
// per application through the configurator overrides.
const intentionallyEmptyKeys = {
  'login_Text_otpSigninRequestPreDescription',
  'login_Text_otpSigninRequestPostDescription',
  'login_Text_passwordSigninPreDescription',
  'login_Text_passwordSigninPostDescription',
  'login_Text_signupRequestPreDescription',
  'login_Text_signupRequestPostDescription',
  'login_Text_signupRequestPreDescriptionDemo',
};

void main() {
  final errors = <String>[];

  final templatePath = '$arbDir/$templateFile';
  final template = _loadArb(templatePath, errors);
  if (template == null) {
    _report(errors);
    return;
  }

  final localeFiles =
      Directory(arbDir)
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.arb') && !file.path.endsWith(templateFile))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  if (localeFiles.isEmpty) {
    errors.add('$arbDir: no locale ARB files found besides the template');
  }

  final templateKeys = template.keys.toSet();
  final mapperSource = File(mapperFile).existsSync() ? File(mapperFile).readAsStringSync() : null;
  if (mapperSource == null) {
    errors.add('$mapperFile: not found - run `dart run build_runner build`');
  }

  _checkValues(templatePath, template, template, errors);
  if (mapperSource != null) {
    _checkMapperCoverage(template, mapperSource, errors);
  }

  _checkGeneratedFormatting(errors);

  for (final file in localeFiles) {
    final arb = _loadArb(file.path, errors);
    if (arb == null) continue;

    final keys = arb.keys.toSet();
    for (final missing in templateKeys.difference(keys).toList()..sort()) {
      errors.add('${file.path}: missing key "$missing"');
    }
    for (final extra in keys.difference(templateKeys).toList()..sort()) {
      errors.add('${file.path}: extra key "$extra" not present in $templateFile');
    }

    _checkValues(file.path, arb, template, errors);
  }

  _report(errors);
}

/// Verifies that the generated l10n sources are formatted at [pageWidth].
///
/// Runs the formatter of the SDK that is running this script, so it agrees with
/// whatever `dart format` the caller would have used.
void _checkGeneratedFormatting(List<String> errors) {
  final generated = Directory(
    generatedDir,
  ).listSync().whereType<File>().map((file) => file.path).where((path) => path.endsWith('.g.dart')).toList()..sort();

  if (generated.isEmpty) {
    errors.add('$generatedDir: no generated l10n sources found - run `flutter gen-l10n`');
    return;
  }

  final ProcessResult result;
  try {
    result = Process.runSync(Platform.resolvedExecutable, [
      'format',
      '--output=none',
      '--set-exit-if-changed',
      '--line-length',
      '$pageWidth',
      ...generated,
    ]);
  } on ProcessException catch (e) {
    errors.add('$generatedDir: could not run the formatter - ${e.message}');
    return;
  }

  if (result.exitCode == 0) return;

  // `--set-exit-if-changed` exits 1 for unformatted input; anything else is the
  // formatter itself failing, and its own message is more useful than ours.
  if (result.exitCode != 1) {
    errors.add('$generatedDir: formatter failed - ${(result.stderr as String).trim()}');
    return;
  }

  // `dart format --output=none` names each file it would rewrite as
  // `Changed <path>`, so only the actual offenders are reported.
  final changed = (result.stdout as String)
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.startsWith('Changed '))
      .map((line) => line.substring('Changed '.length))
      .toList();

  for (final path in changed.isEmpty ? generated : changed) {
    errors.add(
      '$path: not formatted at $pageWidth columns - '
      'run `dart format --line-length $pageWidth $generatedDir` after regenerating',
    );
  }
}

Map<String, dynamic>? _loadArb(String path, List<String> errors) {
  final file = File(path);
  if (!file.existsSync()) {
    errors.add('$path: file not found');
    return null;
  }
  try {
    return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  } on FormatException catch (e) {
    errors.add('$path: invalid JSON - ${e.message}');
    return null;
  }
}

void _checkValues(String path, Map<String, dynamic> arb, Map<String, dynamic> template, List<String> errors) {
  for (final entry in arb.entries) {
    final key = entry.key;
    final value = entry.value;
    if (key.startsWith('@') || value is! String) continue;

    if (value.isEmpty && !intentionallyEmptyKeys.contains(key)) {
      errors.add('$path: empty value for "$key" (not in the intentionally-empty allow-list)');
    }

    final templateValue = template[key];
    if (templateValue is! String || identical(arb, template)) continue;

    final expected = _icuArguments(templateValue);
    final actual = _icuArguments(value);
    if (!_sameSet(expected, actual)) {
      errors.add(
        '$path: ICU placeholder mismatch for "$key" - '
        'template uses {${(expected.toList()..sort()).join(', ')}}, '
        'translation uses {${(actual.toList()..sort()).join(', ')}}',
      );
    }
  }
}

void _checkMapperCoverage(Map<String, dynamic> template, String mapperSource, List<String> errors) {
  for (final key in template.keys) {
    if (key.startsWith('@')) continue;
    if (!mapperSource.contains("'$key'")) {
      errors.add(
        '$mapperFile: key "$key" is not covered by lookupKey - '
        'run `flutter gen-l10n` and `dart run build_runner build --delete-conflicting-outputs`',
      );
    }
  }
}

bool _sameSet(Set<String> a, Set<String> b) => a.length == b.length && a.containsAll(b);

/// Extracts ICU argument names from a message, honoring plural/select branch
/// structure, so literal branch text like `empty{No phone}` never produces a
/// phantom argument. Apostrophes are treated as literal characters because
/// `flutter gen-l10n` runs without `use-escaping` in this repo.
Set<String> _icuArguments(String message) {
  final arguments = <String>{};
  _parseMessage(message, 0, arguments);
  return arguments;
}

final _identifier = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
const _branchedTypes = {'plural', 'select', 'selectOrdinal'};

/// Parses message text starting at [start]; stops at an unmatched `}` (end of
/// a branch) or at end of input. Returns the index after the stopping point.
int _parseMessage(String message, int start, Set<String> arguments) {
  var i = start;
  while (i < message.length) {
    final char = message[i];
    if (char == '{') {
      i = _parseArgument(message, i + 1, arguments);
    } else if (char == '}') {
      return i + 1;
    } else {
      i++;
    }
  }
  return i;
}

/// Parses an argument body after its opening `{`.
int _parseArgument(String message, int start, Set<String> arguments) {
  final nameEnd = _indexOfAny(message, start, const [',', '}']);
  final name = message.substring(start, nameEnd).trim();
  if (_identifier.hasMatch(name)) {
    arguments.add(name);
  }
  if (nameEnd >= message.length || message[nameEnd] == '}') {
    return nameEnd + 1;
  }

  final typeEnd = _indexOfAny(message, nameEnd + 1, const [',', '}']);
  final type = message.substring(nameEnd + 1, typeEnd).trim();
  if (typeEnd >= message.length || message[typeEnd] == '}') {
    return typeEnd + 1;
  }

  if (_branchedTypes.contains(type)) {
    return _parseBranches(message, typeEnd + 1, arguments);
  }
  return _skipStyle(message, typeEnd + 1);
}

/// Parses `selector {message} selector {message} ... }` of a plural/select.
int _parseBranches(String message, int start, Set<String> arguments) {
  var i = start;
  while (i < message.length) {
    final char = message[i];
    if (char == '}') {
      return i + 1;
    } else if (char == '{') {
      i = _parseMessage(message, i + 1, arguments);
    } else {
      i++;
    }
  }
  return i;
}

/// Skips a non-branched argument style (e.g. number format) to its closing `}`.
int _skipStyle(String message, int start) {
  var depth = 1;
  var i = start;
  while (i < message.length && depth > 0) {
    final char = message[i];
    if (char == '{') depth++;
    if (char == '}') depth--;
    i++;
  }
  return i;
}

int _indexOfAny(String message, int start, List<String> needles) {
  for (var i = start; i < message.length; i++) {
    if (needles.contains(message[i])) return i;
  }
  return message.length;
}

void _report(List<String> errors) {
  if (errors.isEmpty) {
    stdout.writeln('l10n:check OK - all ARB files are consistent with $templateFile');
    return;
  }
  stderr.writeln('l10n:check found ${errors.length} problem(s):');
  for (final error in errors) {
    stderr.writeln('  $error');
  }
  exitCode = 1;
}
