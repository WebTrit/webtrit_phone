import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    stdout.writeln('Usage: dart run tool/extenvsubst.dart <file_to_subst>');
    exit(1);
  }

  final file = File(args.single);
  var fileData = await file.readAsString();

  fileData = fileData.replaceAllMapped(
    RegExp(r'\$\{(\w+)\}'),
    (Match match) {
      final entireMatch = match.group(0)!;
      final variableName = match.group(1)!;

      if (bool.hasEnvironment(variableName)) {
        final variableValue = String.fromEnvironment(variableName);
        stdout.writeln('Substitute "$entireMatch" with environment declaration "$variableValue"');
        return variableValue;
      } else {
        final variableValue = Platform.environment[variableName];
        if (variableValue != null) {
          stdout.writeln('Substitute "$entireMatch" with environment variable "$variableValue"');
          return variableValue;
        } else {
          stdout.writeln('Substitute "$entireMatch" skipped');
          return entireMatch;
        }
      }
    },
  );

  await file.writeAsString(fileData);
}
