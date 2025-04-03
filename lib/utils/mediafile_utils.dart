import 'dart:io';

import 'package:flutter/painting.dart';

import 'package:blurhash_ffi/blurhash.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/mediafile_metadata.dart';

Future<MediaFileMetadata> createMediaFileMetadata({required String path}) async {
  final fileName = path.fileName;
  final extension = path.fileExtension;

  final file = File(path);
  final size = await file.length();
  Duration? duration;
  String? blurHash;

  if (path.isAudioPath) {
    // Get audio duration
    final player = AudioPlayer();
    duration = await player.setUrl(path);
    player.dispose();
  }

  if (path.isVideoPath) {
    // Get video duration
    final mediaInfo = await VideoCompress.getMediaInfo(path);
    if (mediaInfo.duration != null) duration = Duration(milliseconds: mediaInfo.duration!.toInt());

    // Get video thumbnail
    final thumbnailFile = await VideoCompress.getFileThumbnail(path, quality: 10);

    // Prepare 64x64 image for blur hash
    final sized = await FlutterImageCompress.compressWithFile(thumbnailFile.path, minWidth: 64, minHeight: 64);

    // Generate blur hash
    if (sized != null) {
      final image = MemoryImage(sized);
      blurHash = await BlurhashFFI.encode(image, componentX: 8, componentY: 8);
    }
  }

  if (path.isImagePath) {
    // Prepare 64x64 image for blur hash
    final sized = await FlutterImageCompress.compressWithFile(path, minWidth: 64, minHeight: 64);

    // Generate blur hash from image
    if (sized != null) {
      final image = MemoryImage(sized);
      blurHash = await BlurhashFFI.encode(image, componentX: 8, componentY: 8);
    }
  }

  return MediaFileMetadata(
    fileName: fileName,
    extension: extension,
    size: size,
    blurHash: blurHash,
    duration: duration,
  );
}

Future<String?> encodeImage(String path, EncodePreset preset) async {
  if (path.isImagePath == false) return null;

  final fileName = path.fileName;
  final dir = await getTemporaryDirectory();
  final encodedDir = Directory('${dir.path}/encodedImages');
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
  );
  return encodedResult?.path;
}

Future<String?> createVideoThumbnail(String path, EncodePreset preset) async {
  if (path.isVideoPath == false) return null;
  final thumbnailFile = await VideoCompress.getFileThumbnail(path, quality: 100);
  return encodeImage(thumbnailFile.path, preset);
}

enum EncodePreset { chat, mms }
