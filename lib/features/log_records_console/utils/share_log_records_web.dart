import 'dart:convert';
import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:share_plus/share_plus.dart';

Future<ShareResult> shareLogRecords(
  List<LogRecord> logRecords, {
  required LogRecordFormatter logRecordsFormatter,
  required String name,
}) {
  final logRecordsBuffer = StringBuffer();
  for (final logRecord in logRecords) {
    logRecordsBuffer.writeln(logRecordsFormatter.format(logRecord));
  }

  final logRecordsData = Uint8List.fromList(utf8.encode(logRecordsBuffer.toString()));

  final logRecordsXFile = XFile.fromData(
    logRecordsData,
    mimeType: 'text/plain',
    name: name,
  );
  return Share.shareXFiles([logRecordsXFile]);
}
