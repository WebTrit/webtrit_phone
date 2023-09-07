import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final Map<String, dynamic> dartDefineJson;
  final File fileToSubst;
  if (args.length == 1) {
    dartDefineJson = {};
    fileToSubst = File(args[0]);
  } else if (args.length == 2) {
    dartDefineJson = jsonDecode(await File(args[0]).readAsString());
    fileToSubst = File(args[1]);
  } else {
    stdout.writeln('Usage: dart run tool/extenvsubst.dart [<dart define json file>] <file_to_subst>');
    exit(1);
  }

  var fileToSubstData = await fileToSubst.readAsString();

  fileToSubstData = fileToSubstData.replaceAllMapped(
    RegExp(r'\$\{(\w+)\}'),
    (Match match) {
      final entireMatch = match.group(0)!;
      final variableName = match.group(1)!;

      if (bool.hasEnvironment(variableName)) {
        final variableValue = String.fromEnvironment(variableName);
        stdout.writeln('Substitute "$entireMatch" with environment declaration "$variableValue"');
        return variableValue;
      } else if (dartDefineJson.containsKey(variableName)) {
        final variableValue = dartDefineJson[variableName];
        stdout.writeln('Substitute "$entireMatch" with dart define json declaration "$variableValue"');
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

  await fileToSubst.writeAsString(fileToSubstData);
}
