import 'dart:io';

import 'package:path/path.dart' as p;

class DatabaseFileHelper {
  static const _walExtension = '-wal';
  static const _shmExtension = '-shm';

  /// Deletes the main database file along with its WAL and SHM temporary files.
  ///
  /// Swallows any [FileSystemException] to ensure test teardown doesn't crash.
  static Future<void> deleteDatabaseFiles({required String directoryPath, required String dbName}) async {
    try {
      await _deleteFile(p.join(directoryPath, dbName));
      await _deleteFile(p.join(directoryPath, '$dbName$_walExtension'));
      await _deleteFile(p.join(directoryPath, '$dbName$_shmExtension'));
    } catch (_) {
      // Ignore cleanup errors during test teardown
    }
  }

  static Future<void> _deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
