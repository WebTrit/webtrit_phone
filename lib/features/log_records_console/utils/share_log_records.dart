import 'dart:io';

import 'package:path/path.dart' show basename, join;
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

Future<ShareResult> shareLogRecords(
  List<String> logRecords, {
  required String name,
  String? callkeepLogFilePath,
  String? callkeepLogName,
}) async {
  final temporaryPath = await getTemporaryPath();
  final logRecordsPath = join(temporaryPath, name);
  final logRecordsFile = File(logRecordsPath);

  final logRecordsSink = logRecordsFile.openWrite();
  for (final logRecord in logRecords) {
    logRecordsSink.writeln(logRecord);
  }
  await logRecordsSink.close();

  final files = <XFile>[XFile(logRecordsPath, mimeType: 'text/plain', name: name)];

  if (callkeepLogFilePath != null) {
    final callkeepFile = File(callkeepLogFilePath);
    if (await callkeepFile.exists()) {
      files.add(
        XFile(callkeepLogFilePath, mimeType: 'text/plain', name: callkeepLogName ?? basename(callkeepLogFilePath)),
      );
    }
  }

  try {
    return await SharePlus.instance.share(ShareParams(files: files));
  } finally {
    if (await logRecordsFile.exists()) {
      await logRecordsFile.delete();
    }
  }
}
