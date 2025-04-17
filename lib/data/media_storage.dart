import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http_cache_stream/http_cache_stream.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/file_kind.dart';

class MediaStorage {
  MediaStorage._(this._directory, this._httpClient, this._prefs) {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      final autoClearDuration = _prefs.getStorageAutoClearDuration();
      cleanStaleMediaCache(DateTime.now().subtract(autoClearDuration));

      // Use anough time to not delete temp files that are in use
      // One week probably should be enough
      cleanStaleUploadTemps(DateTime.now().subtract(const Duration(days: 7)));
    });
  }
  factory MediaStorage() => _instance;
  static late MediaStorage _instance;

  // Upload temps directories
  static const _filePickerPath = 'file_picker'; // Ensure kept in sync with used picker package
  static const _encodedVideoPath = 'video_compress'; // Ensure kept in sync with used video compress package
  static const _encodedImagePath = 'encoded_images';

  // Media cache directories
  static const _mediaCachePath = 'media_cache';

  final Directory _directory;
  final HttpClient _httpClient;
  final AppPreferences _prefs;

  static Future<MediaStorage> init(AppPreferences prefs, {HttpClient? httpClient}) async {
    await HttpCacheManager.init();
    HttpCacheManager.instance.config.rangeRequestSplitThreshold = 5 * 1024 * 1024;

    _instance = MediaStorage._(await getTemporaryDirectory(), httpClient ?? HttpClient(), prefs);
    return _instance;
  }

  /// Get file from cache if it exists
  File? getFileIfExist(String url) {
    final uri = Uri.parse(url);
    final file = File('${_directory.path}/$_mediaCachePath${uri.path}');

    final exist = file.existsSync();
    if (exist) return file;

    return null;
  }

  /// Get file from cache if it exists
  /// If the file is not in the cache, it will be downloaded and saved to the cache
  Future<File> downloadOrGetFile(String url) async {
    final uri = Uri.parse(url);
    final file = File('${_directory.path}/$_mediaCachePath${uri.path}');
    if (await file.exists()) return file;

    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Preload file to cache if it is smaller than maxSize and not already in the cache
  /// The file will be downloaded and saved to the cache
  Future preloadIf({required String url, required int maxSize}) async {
    final uri = Uri.parse(url);
    final file = File('${_directory.path}/$_mediaCachePath${uri.path}');
    if (await file.exists()) return;

    final headReq = await _httpClient.headUrl(uri);
    final headRes = await headReq.close();
    final contentLength = headRes.contentLength;
    if (contentLength > maxSize) return;

    final fileReq = await _httpClient.getUrl(uri);
    final fileRes = await fileReq.close();
    final bytes = await consolidateHttpClientResponseBytes(fileRes);
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  /// Get cachable stream uri for video/audio that can be used to play the file while it is downloading
  /// as regular network stream with range requests support(seeking)
  ///
  /// When fully downloaded, the file will be saved to the cache as regular file
  /// and can be accessed by getFileIfExist method
  ///
  Uri getCacheStreamUrl(String url) {
    final uri = Uri.parse(url);
    final file = File('${_directory.path}/$_mediaCachePath${uri.path}');

    final cacheStream = HttpCacheManager.instance.createStream(uri, file: file);
    return cacheStream.cacheUrl;
  }

  /// Get thumbnail for video by remote or local path
  /// If the thumbnail is not in the cache, it will be generated and saved to the cache
  Future<File> getVideoThumbnail(String url) async {
    final uri = Uri.parse(url);
    final file = File('${_directory.path}/$_mediaCachePath/thumbs${uri.path}.jpg');
    if (await file.exists()) return file;

    final thumb = await VideoThumbnail.thumbnailData(
      video: url,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 1080,
      quality: 90,
    );
    await file.create(recursive: true);
    await file.writeAsBytes(thumb);
    return file;
  }

  /// Returns ext/MB count for all files in the media cache directories
  /// in the format:
  /// {
  ///   'jpg': 1.2,
  ///   'mp4': 2.3,
  ///   'mp3': 0.5,
  ///   ...
  /// }
  /// The method will enumerate the directories and calculate the size of each file
  /// and sum them up by extension.
  /// The method will also print the size of each file in the console.
  Future<Map<FileKind, double>> enumerateMediaCache() async {
    Map<FileKind, double> extToMb = {};

    Future enumerateDir(Directory dir) async {
      if (await dir.exists() == false) return;
      final list = dir.listSync();
      for (var entity in list) {
        if (entity is Directory) await enumerateDir(entity);

        if (entity is File) {
          print('File: ${entity.path}');
          final stat = await entity.stat();
          final mb = stat.size / 1024 / 1024;
          print('Size:${mb}MB');

          FileKind kind;
          if (entity.path.isImagePath) {
            kind = FileKind.image;
          } else if (entity.path.isVideoPath || entity.path.isVideoPartPath) {
            kind = FileKind.video;
          } else if (entity.path.isAudioPath || entity.path.isAudioPartPath) {
            kind = FileKind.audio;
          } else if (entity.path.isDocumentPath) {
            kind = FileKind.document;
          } else {
            kind = FileKind.other;
          }

          extToMb[kind] = (extToMb[kind] ?? 0) + mb;
        }
      }
    }

    await enumerateDir(Directory('${_directory.path}/$_mediaCachePath'));

    // Sort the map by value
    extToMb = Map.fromEntries(
      extToMb.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    print('Sorted media cache:');
    extToMb.forEach((key, value) {
      print('${key.name}: ${value.toStringAsFixed(2)} MB');
    });
    return extToMb;
  }

  /// Clean media cache by removing files that were last accessed before the given date
  /// The method will enumerate the directories and delete the files that were last accessed before the given date
  Future cleanStaleMediaCache(DateTime date) async {
    Future enumerateDir(Directory dir) async {
      if (await dir.exists() == false) return;
      final list = dir.listSync();
      for (var entity in list) {
        if (entity is Directory) await enumerateDir(entity);

        if (entity is File) {
          final stat = await entity.stat();
          final lastAccessed = stat.accessed;
          if (lastAccessed.isBefore(date)) await entity.delete();
        }
      }
    }

    await enumerateDir(Directory('${_directory.path}/$_mediaCachePath'));
  }

  /// Clean upload temps by removing files that were last accessed before the given date
  /// The method will enumerate the directories and delete the files that were last accessed before the given date
  Future cleanStaleUploadTemps(DateTime date) async {
    Future enumerateDir(Directory dir) async {
      if (await dir.exists() == false) return;
      final list = dir.listSync();
      for (var entity in list) {
        if (entity is Directory) await enumerateDir(entity);

        if (entity is File) {
          final stat = await entity.stat();
          final lastAccessed = stat.accessed;
          if (lastAccessed.isBefore(date)) await entity.delete();
        }
      }
    }

    await enumerateDir(Directory('${_directory.path}/$_filePickerPath'));
    await enumerateDir(Directory('${_directory.path}/$_encodedVideoPath'));
    await enumerateDir(Directory('${_directory.path}/$_encodedImagePath'));
  }

  /// Clear all media cache
  Future clearMediaCache() async {
    final cacheDir = Directory('${_directory.path}/$_mediaCachePath');
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
  }

  /// Make sure to use this method when all uploads are done
  Future clearUploadTemps() async {
    final filePickerDir = Directory('${_directory.path}/$_filePickerPath');
    if (await filePickerDir.exists()) {
      await filePickerDir.delete(recursive: true);
    }
    final encodedVideoDir = Directory('${_directory.path}/$_encodedVideoPath');
    if (await encodedVideoDir.exists()) {
      await encodedVideoDir.delete(recursive: true);
    }
    final encodedImageDir = Directory('${_directory.path}/$_encodedImagePath');
    if (await encodedImageDir.exists()) {
      await encodedImageDir.delete(recursive: true);
    }
  }

  /// Encode image to a smaller size if needed
  Future<String?> encodeImage(String path, DestinationPreset preset) async {
    if (path.isImagePath == false) return null;

    final fileName = path.fileName;
    final encodedDir = Directory('${_directory.path}/$_encodedImagePath');
    if (!encodedDir.existsSync()) encodedDir.createSync(recursive: true);
    final targetPath = '${encodedDir.path}/$fileName.jpg';

    final encodedResult = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      minWidth: switch (preset) { DestinationPreset.chat => 2000, DestinationPreset.mms => 500 },
      minHeight: switch (preset) { DestinationPreset.chat => 2000, DestinationPreset.mms => 500 },
      quality: switch (preset) { DestinationPreset.chat => 90, DestinationPreset.mms => 70 },
      format: CompressFormat.jpeg,
      keepExif: false,
    );

    return encodedResult?.path;
  }

  /// Encode video to a smaller size if needed
  Future<String?> encodeVideo(
    String path,
    DestinationPreset preset, {
    Duration maxDuration = const Duration(minutes: 10),
  }) async {
    if (path.isVideoPath == false) return null;

    final encodedResult = await VideoCompress.compressVideo(
      path,
      quality: switch (preset) {
        DestinationPreset.chat => VideoQuality.Res1280x720Quality,
        DestinationPreset.mms => VideoQuality.Res640x480Quality,
      },
      deleteOrigin: false,
      includeAudio: true,
    );
    return encodedResult?.path;
  }

  /// Create a thumbnail image for the video
  Future<String?> createVideoThumbnail(String path, DestinationPreset preset) async {
    if (path.isVideoPath == false) return null;
    final thumbnailFile = await VideoCompress.getFileThumbnail(path, quality: 100);
    return encodeImage(thumbnailFile.path, preset);
  }

  /// Get the duration of the video
  Future<Duration> getVideoDuration(String path) async {
    final videoInfo = await VideoCompress.getMediaInfo(path);
    return Duration(milliseconds: videoInfo.duration?.toInt() ?? 0);
  }

  /// Get the duration of the audio
  Future<Duration> getAudioDuration(String path) async {
    final player = AudioPlayer();
    final duration = await player.setUrl(path);
    player.dispose();
    return duration ?? Duration.zero;
  }

  /// Check if the media is valid for pickup
  /// or if it is too big/long/short
  /// Returns a list of warnings for each file and the valid paths list
  /// The warnings are:
  /// - too big
  /// - too long
  /// - too short
  /// - not supported
  Future<PickResult> checkMediaForPickup(List<String> paths, DestinationPreset preset) async {
    List<PickWarning> warnings = [];
    List<String> validPaths = [];

    for (final path in paths) {
      if (path.isImagePath && !path.isGifImagePath) {
        // No need to check images because they'll be encoded same way
        // and the size will be reduced
        //
        // Except GIFs that will be checked as regular files in 'else' block
        validPaths.add(path);
      } else if (path.isVideoPath) {
        final duration = await getVideoDuration(path);
        if (duration > videoDurationLimit(preset)) {
          warnings.add((path, PickWarningType.tooLong));
        } else if (duration.inSeconds < 1) {
          warnings.add((path, PickWarningType.tooShort));
        } else {
          validPaths.add(path);
        }
      } else if (path.isAudioPath) {
        final duration = await getAudioDuration(path);
        if (duration > audioDurationLimit(preset)) {
          warnings.add((path, PickWarningType.tooLong));
        } else if (duration.inSeconds < 1) {
          warnings.add((path, PickWarningType.tooShort));
        } else {
          validPaths.add(path);
        }
      } else {
        final file = File(path);
        final stat = await file.stat();
        final size = stat.size;
        if (size > fileSizeLimit(preset)) {
          warnings.add((path, PickWarningType.tooBig));
        } else {
          validPaths.add(path);
        }
      }
    }

    return (validPaths, warnings);
  }

  /// Pick files from the file picker
  /// The files will be checked for validity and the warnings will be returned
  /// The valid paths will be returned as well
  Future<PickResult> pickFiles(PickerType type, DestinationPreset preset) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: switch (type) {
        PickerType.media => FileType.media,
        PickerType.audio => FileType.audio,
        PickerType.any => FileType.any,
      },
    );

    final pickedPaths = result?.paths.whereType<String>().toList() ?? [];

    final pickResult = await checkMediaForPickup(pickedPaths, preset);
    return pickResult;
  }

  /// Get the file size limit for the given preset in bytes
  int fileSizeLimit(DestinationPreset preset) {
    return switch (preset) {
      DestinationPreset.chat => 100 * 1024 * 1024, // 100MB
      DestinationPreset.mms => 2 * 1024 * 1024, // 2MB
    };
  }

  /// Get the video duration limit for the given preset
  Duration videoDurationLimit(DestinationPreset preset) {
    return switch (preset) {
      DestinationPreset.chat => const Duration(minutes: 10),
      DestinationPreset.mms => const Duration(minutes: 1),
    };
  }

  /// Get the audio duration limit for the given preset
  Duration audioDurationLimit(DestinationPreset preset) {
    return switch (preset) {
      DestinationPreset.chat => const Duration(minutes: 20),
      DestinationPreset.mms => const Duration(minutes: 5),
    };
  }
}

enum DestinationPreset { chat, mms }

enum PickWarningType { tooBig, tooLong, tooShort, notSupported }

typedef PickWarning = (String path, PickWarningType type);

typedef PickResult = (List<String> validPaths, List<PickWarning> warnings);

enum PickerType { media, audio, any }
