import 'dart:io';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('VoicemailCacheSection');

/// The on-disk cache of voicemail audio as a manageable [CacheSection].
///
/// Playback caches audio in two places: `LockCachingAudioSource` writes to
/// `<temp>/media_cache` when an explicit cache file is provided (Android) and
/// to just_audio's own `<temp>/just_audio_cache` otherwise (iOS). Both
/// locations hold nothing but voicemail audio in this app, so sizing and
/// clearing them together covers the whole voicemail cache.
class VoicemailCacheSection implements CacheSection {
  VoicemailCacheSection({required String mediaCacheBasePath, required String temporaryPath})
    : _directories = [Directory(mediaCacheBasePath), Directory('$temporaryPath/just_audio_cache')];

  final List<Directory> _directories;

  @override
  String get id => 'voicemail';

  @override
  String get titleL10n => 'voicemail_Cache_title';

  @override
  String get descriptionL10n => 'voicemail_Cache_description';

  @override
  Future<CacheUsage> usage() async {
    var total = 0;

    for (final directory in _directories) {
      try {
        total += await directorySizeBytes(directory);
      } catch (e) {
        _logger.warning('Failed to size cache directory ${directory.path}: $e');
      }
    }

    return CacheUsage.bytes(total);
  }

  /// Deletes all cached voicemail audio; the audio of a message is downloaded
  /// again on its next playback. Stop the active playback first - its cache
  /// file may still be open.
  @override
  Future<void> clear() async {
    for (final directory in _directories) {
      try {
        await deleteDirectoryRecursively(directory);
      } catch (e) {
        _logger.warning('Failed to clear cache directory ${directory.path}: $e');
      }
    }
  }
}
