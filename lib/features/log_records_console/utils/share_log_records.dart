import 'dart:io';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<ShareResult> shareLogRecords(
  List<LogRecord> logRecords, {
  required LogRecordFormatter logRecordsFormatter,
  required String name,
}) async {
  final temporaryPath = (await getTemporaryDirectory()).path;
  final logRecordsPath = path.join(temporaryPath, name);
  final logRecordsFile = File(logRecordsPath);

  final logRecordsSink = logRecordsFile.openWrite();
  for (final logRecord in logRecords) {
    logRecordsSink.writeln(logRecordsFormatter.format(logRecord));
  }
  await logRecordsSink.close();

  final logRecordsXFile = XFile(
    logRecordsPath,
    mimeType: 'text/plain',
    name: name,
  );
  try {
    return await Share.shareXFiles([logRecordsXFile]);
  } finally {
    await logRecordsFile.delete();
  }
}
