import 'dart:io';

/// Total size in bytes of all files under [directory], 0 when it is absent.
///
/// File sizes are gathered concurrently and files that vanish mid-walk count
/// as 0; errors listing the directory itself propagate to the caller.
Future<int> directorySizeBytes(Directory directory) async {
  if (!await directory.exists()) return 0;

  final sizes = <Future<int>>[];
  await for (final entity in directory.list(recursive: true, followLinks: false)) {
    if (entity is File) sizes.add(entity.length().catchError((Object _) => 0));
  }

  return (await Future.wait(sizes)).fold<int>(0, (sum, size) => sum + size);
}

/// Deletes [directory] with its contents; absent directories are a no-op.
Future<void> deleteDirectoryRecursively(Directory directory) async {
  if (!await directory.exists()) return;
  await directory.delete(recursive: true);
}
