import 'dart:async';
import 'dart:io';

import 'package:flutter/painting.dart';

import 'package:blurhash_ffi/blurhash.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http_cache_stream/http_cache_stream.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';

class MediaStorageService {
  // Upload temps directories
  static const filePickerPath = 'file_picker';
  static const encodedVideoPath = 'video_compress';
  static const encodedImagePath = 'encoded_images';

  // Media cache directories
  static const mediaCachePath = 'media_cache';
  static const audioPlaybackCachePath = 'just_audio_cache';
  static const videoPlaybackCachePath = 'http_cache_stream';

  static late final CacheManager _cacheManager;

  static Future init() async {
    _cacheManager = CacheManager(
      Config(
        mediaCachePath,
        stalePeriod: const Duration(days: 1337), // coz we'll use our cleanup logic
        maxNrOfCacheObjects: 1337, // coz we'll use our cleanup logic
        repo: JsonCacheInfoRepository(databaseName: mediaCachePath),
        fileSystem: IOFileSystem(mediaCachePath),
        fileService: HttpFileService(),
      ),
    );

    await HttpCacheManager.init();
    HttpCacheManager.instance.config.rangeRequestSplitThreshold = 5 * 1024 * 1024;

    Timer.periodic(const Duration(minutes: 5), (timer) async {
      // TODO: auto-delete date from settings
      cleanStaleMediaCache(DateTime.now().subtract(const Duration(days: 7)));

      // Use anough time to not delete temp files that are in use
      // One week probably should be enough
      cleanStaleUploadTemps(DateTime.now().subtract(const Duration(days: 7)));
    });
  }

  /// Get file from cache if it exists
  /// If the file is not in the cache, it will be downloaded and saved to the cache
  static Future<File> getFile(String url) async {
    return _cacheManager.getSingleFile(url);
  }

  /// Get thumbnail for video by remote or local path
  /// If the thumbnail is not in the cache, it will be generated and saved to the cache
  static Future<File> getVideoThumbnail(String url) async {
    final exitst = await _cacheManager.getFileFromCache('${url}thumb');
    if (exitst != null) return exitst.file;

    final data = await VideoThumbnail.thumbnailData(video: url, imageFormat: ImageFormat.JPEG, maxHeight: 1080);
    return await _cacheManager.putFile('${url}thumb', data, fileExtension: 'jpg');
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
  static Future<Map<FileKind, double>> enumerateMediaCache() async {
    final directory = await getTemporaryDirectory();

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

    await enumerateDir(Directory('${directory.path}/$mediaCachePath'));
    await enumerateDir(Directory('${directory.path}/$audioPlaybackCachePath'));
    await enumerateDir(Directory('${directory.path}/$videoPlaybackCachePath'));

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
  static Future cleanStaleMediaCache(DateTime date) async {
    final directory = await getTemporaryDirectory();

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

    await enumerateDir(Directory('${directory.path}/$mediaCachePath'));
    await enumerateDir(Directory('${directory.path}/$audioPlaybackCachePath'));
    await enumerateDir(Directory('${directory.path}/$videoPlaybackCachePath'));
  }

  /// Clean upload temps by removing files that were last accessed before the given date
  /// The method will enumerate the directories and delete the files that were last accessed before the given date
  static Future cleanStaleUploadTemps(DateTime date) async {
    final directory = await getTemporaryDirectory();

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

    await enumerateDir(Directory('${directory.path}/$filePickerPath'));
    await enumerateDir(Directory('${directory.path}/$encodedVideoPath'));
    await enumerateDir(Directory('${directory.path}/$encodedImagePath'));
  }

  static Future clearMediaCache() async {
    final directory = await getTemporaryDirectory();
    final cacheDir = Directory('${directory.path}/$mediaCachePath');
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
    final audioPlaybackDir = Directory('${directory.path}/$audioPlaybackCachePath');
    if (await audioPlaybackDir.exists()) {
      await audioPlaybackDir.delete(recursive: true);
    }
    final videoPlaybackDir = Directory('${directory.path}/$videoPlaybackCachePath');
    if (await videoPlaybackDir.exists()) {
      await videoPlaybackDir.delete(recursive: true);
    }
  }

  /// Make sure to use this method when all uploads are done
  static Future clearUploadTemps() async {
    final directory = await getTemporaryDirectory();
    final filePickerDir = Directory('${directory.path}/$filePickerPath');
    if (await filePickerDir.exists()) {
      await filePickerDir.delete(recursive: true);
    }
    final encodedVideoDir = Directory('${directory.path}/$encodedVideoPath');
    if (await encodedVideoDir.exists()) {
      await encodedVideoDir.delete(recursive: true);
    }
    final encodedImageDir = Directory('${directory.path}/$encodedImagePath');
    if (await encodedImageDir.exists()) {
      await encodedImageDir.delete(recursive: true);
    }
  }

  static Future<String?> encodeImage(String path, EncodePreset preset) async {
    if (path.isImagePath == false) return null;

    final fileName = path.fileName;
    final dir = await getTemporaryDirectory();
    final encodedDir = Directory('${dir.path}/$encodedImagePath');
    if (!encodedDir.existsSync()) encodedDir.createSync(recursive: true);
    final targetPath = '${encodedDir.path}/$fileName.jpg';

    final encodedResult = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      minWidth: switch (preset) { EncodePreset.chat => 2000, EncodePreset.mms => 500 },
      minHeight: switch (preset) { EncodePreset.chat => 2000, EncodePreset.mms => 500 },
      quality: switch (preset) { EncodePreset.chat => 80, EncodePreset.mms => 50 },
      format: CompressFormat.jpeg,
      keepExif: false,
    );

    return encodedResult?.path;
  }

  static Future<String?> encodeVideo(String path, EncodePreset preset) async {
    if (path.isVideoPath == false) return null;

    final encodedResult = await VideoCompress.compressVideo(
      path,
      quality: switch (preset) {
        EncodePreset.chat => VideoQuality.Res1280x720Quality,
        EncodePreset.mms => VideoQuality.Res640x480Quality,
      },
      deleteOrigin: false,
      includeAudio: true,
    );
    return encodedResult?.path;
  }

  static Future<String?> createVideoThumbnail(String path, EncodePreset preset) async {
    if (path.isVideoPath == false) return null;
    final thumbnailFile = await VideoCompress.getFileThumbnail(path, quality: 100);
    return encodeImage(thumbnailFile.path, preset);
  }

  static Future<String?> createBlurHash(String path) async {
    if (path.isImagePath == false) return null;

    // Prepare 64x64 image for blur hash
    final sized = await FlutterImageCompress.compressWithFile(path, minWidth: 64, minHeight: 64);

    // Generate blur hash from image
    if (sized != null) {
      final image = MemoryImage(sized);
      return await BlurhashFFI.encode(image, componentX: 8, componentY: 8);
    }
    return null;
  }
}

enum EncodePreset { chat, mms }

enum FileKind { image, video, audio, document, other }
