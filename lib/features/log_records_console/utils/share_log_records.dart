import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';

Future<ShareResult> shareLogRecords(List<String> logRecords, {required String name}) async {
  final temporaryPath = await getTemporaryPath();
  final logRecordsPath = join(temporaryPath, name);
  final logRecordsFile = File(logRecordsPath);

  final logRecordsSink = logRecordsFile.openWrite();
  for (final logRecord in logRecords) {
    logRecordsSink.writeln(logRecord);
  }
  await logRecordsSink.close();

  final logRecordsXFile = XFile(logRecordsPath, mimeType: 'text/plain', name: name);
  try {
    return await SharePlus.instance.share(ShareParams(files: [logRecordsXFile]));
  } finally {
    await logRecordsFile.delete();
  }
}
