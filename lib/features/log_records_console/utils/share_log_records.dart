import 'dart:io';

import 'package:path/path.dart' show basename, join;
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

Future<ShareResult> shareLogRecords(
  List<String> logRecords, {
  required String name,
  String? nativeLogFilePath,
  String? nativeLogName,
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

  if (nativeLogFilePath != null) {
    final nativeFile = File(nativeLogFilePath);
    if (await nativeFile.exists()) {
      files.add(XFile(nativeLogFilePath, mimeType: 'text/plain', name: nativeLogName ?? basename(nativeLogFilePath)));
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
