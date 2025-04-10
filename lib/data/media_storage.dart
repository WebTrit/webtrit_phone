import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http_cache_stream/http_cache_stream.dart';
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

  Future<String?> encodeImage(String path, EncodePreset preset) async {
    if (path.isImagePath == false) return null;

    final fileName = path.fileName;
    final encodedDir = Directory('${_directory.path}/$_encodedImagePath');
    if (!encodedDir.existsSync()) encodedDir.createSync(recursive: true);
    final targetPath = '${encodedDir.path}/$fileName.jpg';

    final encodedResult = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      minWidth: switch (preset) { EncodePreset.chat => 2000, EncodePreset.mms => 500 },
      minHeight: switch (preset) { EncodePreset.chat => 2000, EncodePreset.mms => 500 },
      quality: switch (preset) { EncodePreset.chat => 90, EncodePreset.mms => 70 },
      format: CompressFormat.jpeg,
      keepExif: false,
    );

    return encodedResult?.path;
  }

  Future<String?> encodeVideo(String path, EncodePreset preset) async {
    if (path.isVideoPath == false) return null;

    final encodedResult = await VideoCompress.compressVideo(
      path,
      quality: switch (preset) {
        EncodePreset.chat => VideoQuality.Res1280x720Quality,
        EncodePreset.mms => VideoQuality.Res640x480Quality,
      },
      deleteOrigin: false,
      includeAudio: true,
      duration: const Duration(minutes: 10).inSeconds,
    );
    return encodedResult?.path;
  }

  Future<String?> createVideoThumbnail(String path, EncodePreset preset) async {
    if (path.isVideoPath == false) return null;
    final thumbnailFile = await VideoCompress.getFileThumbnail(path, quality: 100);
    return encodeImage(thumbnailFile.path, preset);
  }
}

enum EncodePreset { chat, mms }
