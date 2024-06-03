import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:io/ansi.dart';
import 'package:io/io.dart';

import 'package:app_database/app_database.dart';
import 'package:app_database/src/migrations/migrations.dart';

Future<void> main(List<String> args) async {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final version = migrations.schemaVersion;
  final appDatabasePath = '${Directory.systemTemp.path}/$timestamp-db_stub_v$version.sqlite';

  await _executeStep(1, 3, 'Creating reference application database', () async {
    final appDatabase = AppDatabase(DatabaseConnection(
      NativeDatabase(
        File(appDatabasePath),
      ),
    ));
    await appDatabase.doWhenOpened((e) {});
    await appDatabase.close();
    return true;
  });

  var manager = ProcessManager();

  await _executeStep(2, 3, 'Dumping schema of reference application database', () async {
    final schemaDumpProcess = await manager.spawn('dart', [
      'run',
      'drift_dev',
      'schema',
      'dump',
      appDatabasePath,
      'lib/src/drift_schemas/drift_schema_v$version.json',
    ]);
    return await schemaDumpProcess.exitCode == ExitCode.success.code;
  });

  await _executeStep(2, 3, 'Dumping schema of reference application database', () async {
    final schemaGenerateProcess = await manager.spawn('dart', [
      'run',
      'drift_dev',
      'schema',
      'generate',
      'lib/src/drift_schemas/',
      'lib/src/migrations/generated/',
    ]);
    return await schemaGenerateProcess.exitCode == ExitCode.success.code;
  });

  exit(ExitCode.success.code);
}

Future<void> _executeStep(int index, int count, String? name, Future<bool> Function() entry) async {
  stdout.write(wrapWith('BEGIN $index/$count: ', [styleBold]));
  stdout.writeln(wrapWith(name, [darkGray]));
  if (await entry()) {
    stdout.write(wrapWith('END $index/$count: ', [styleBold]));
    stdout.writeln(wrapWith('done', [green]));
  } else {
    stdout.write(wrapWith('END $index/$count: ', [styleBold]));
    stdout.writeln(wrapWith('error', [red]));
    exit(ExitCode.usage.code);
  }
}
