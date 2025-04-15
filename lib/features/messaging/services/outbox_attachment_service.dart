import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import 'package:webtrit_phone/data/media_storage.dart';
import 'package:webtrit_phone/features/messaging/extensions/string_path_utils.dart';
import 'package:webtrit_phone/models/messaging/messaging.dart';

final _logger = Logger('OutboxAttachmentService');

class OutboxAttachmentService {
  /// Prepares the attachments for the given outbox message entry.
  ///
  /// This method processes the attachments of the message, encoding images and videos
  /// if necessary, and uploading them to the server.
  static Stream<List<OutboxAttachment>> prepareAttachments(
    List<OutboxAttachment> attachments,
    DestinationPreset eestinationPreset,
  ) async* {
    for (final att in attachments) {
      final pickedPath = att.pickedPath;
      String? encodedPath = att.encodedPath;
      String? uploadedPath = att.uploadedPath;

      _logger.info('Started processing $pickedPath');

      if (pickedPath.isImagePath && !pickedPath.isGifImagePath && encodedPath == null) {
        try {
          _logger.info('Encoding image: $pickedPath');

          encodedPath = await MediaStorage().encodeImage(pickedPath, eestinationPreset);
          if (encodedPath == null) throw Exception('Failed to encode image: $pickedPath');

          attachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(encodedPath: encodedPath);
          }).toList();

          yield attachments;

          _logger.info('Encoded image: $encodedPath');
        } catch (e, s) {
          _logger.severe('Failed to encode image: $pickedPath', e, s);
          throw EncodeException('Failed to encode image: $pickedPath');
        }
      }
      if (pickedPath.isVideoPath && encodedPath == null) {
        try {
          _logger.info('Encoding video: $pickedPath');

          encodedPath = await MediaStorage().encodeVideo(pickedPath, eestinationPreset);
          if (encodedPath == null) throw Exception('Failed to encode video: $pickedPath');

          attachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(encodedPath: encodedPath);
          }).toList();

          yield attachments;

          _logger.info('Encoded video: $encodedPath');
        } catch (e, s) {
          _logger.severe('Failed to encode video: $pickedPath', e, s);
          throw EncodeException('Failed to encode video: $pickedPath');
        }
      }

      if (uploadedPath == null) {
        try {
          final fileName = (encodedPath ?? pickedPath).fileName;
          final fileExtension = (encodedPath ?? pickedPath).fileExtension;
          _logger.info('Starting upload $fileName.$fileExtension');
          await Future.delayed(const Duration(seconds: 1));
          uploadedPath = const Uuid().v4();

          attachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(uploadedPath: uploadedPath);
          }).toList();

          yield attachments;

          _logger.info('Uploaded file path: $uploadedPath');
        } catch (e, s) {
          _logger.severe('Failed to upload file: $pickedPath', e, s);
          throw UploadException('Failed to upload file: $pickedPath');
        }
      }

      _logger.info('Finished processing $pickedPath');
    }
  }
}

class EncodeException implements Exception {
  final String message;
  EncodeException(this.message);

  @override
  String toString() => 'EncodeException: $message';
}

class UploadException implements Exception {
  final String message;
  UploadException(this.message);

  @override
  String toString() => 'UploadException: $message';
}
