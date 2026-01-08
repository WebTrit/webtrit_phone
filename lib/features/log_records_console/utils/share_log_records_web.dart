import 'dart:convert';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

Future<ShareResult> shareLogRecords(List<String> logRecords, {required String name}) {
  final logRecordsBuffer = StringBuffer();
  for (final logRecord in logRecords) {
    logRecordsBuffer.writeln(logRecord);
  }

  final logRecordsData = Uint8List.fromList(utf8.encode(logRecordsBuffer.toString()));

  final logRecordsXFile = XFile.fromData(logRecordsData, mimeType: 'text/plain', name: name);
  final params = ShareParams(
    files: [logRecordsXFile],
    fileNameOverrides: [name],
    text: 'Attached log records',
    title: 'App Logs',
    subject: 'App Log Records',
  );
  return SharePlus.instance.share(params);
}
