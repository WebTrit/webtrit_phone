import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/extensions/string.dart';

import 'package:webtrit_phone/features/messaging/extensions/string_path_utils.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_thumbnail_builder.dart';

class ExchangeBar extends StatelessWidget {
  const ExchangeBar({
    super.key,
    required this.text,
    required this.icon,
    this.onCancel,
    this.onConfirm,
  });

  final String text;
  final IconData icon;
  final Function()? onCancel;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: theme.primaryColor.withAlpha(200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
              if (onConfirm != null) ...[
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.check), onPressed: onConfirm, color: Colors.white),
              ],
              if (onCancel != null) ...[
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class AttachmentsExchangeBar extends StatelessWidget {
  const AttachmentsExchangeBar({
    super.key,
    required this.attachments,
    this.icon = Icons.attach_file,
    this.onCancel,
  });

  final List<String> attachments;
  final IconData icon;
  final Function()? onCancel;

  List<String> get viewableAttachments {
    return attachments.where((attachment) {
      return attachment.isImagePath || attachment.isVideoPath;
    }).toList();
  }

  List<String> get nonViewableAttachments {
    return attachments.where((attachment) {
      return !attachment.isImagePath && !attachment.isVideoPath;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: theme.primaryColor.withAlpha(200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, color: Colors.white),
                  if (attachments.isNotEmpty)
                    Positioned(
                      right: -2,
                      bottom: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: colorScheme.tertiary, shape: BoxShape.circle),
                        child: Text(
                          attachments.length.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(child: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4,
                  children: [
                    if (viewableAttachments.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: viewableAttachments.map((attachment) {
                          if (attachment.isImagePath) return imagePreview(attachment);
                          if (attachment.isVideoPath) return videoPreview(attachment);
                          return const SizedBox();
                        }).toList(),
                      ),
                    if (nonViewableAttachments.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: nonViewableAttachments.map((attachment) {
                          if (attachment.isAudioPath) return audioPreview(attachment);
                          if (attachment.isDocumentPath) return docPreview(attachment);
                          return filePreview(attachment);
                        }).toList(),
                      ),
                  ],
                );
              })),
              if (onCancel != null) ...[
                IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget filePreview(String path) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            path.fileName.limit(20),
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '.${path.fileExtension}',
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.attach_file_rounded, color: Colors.black, size: 12),
        ],
      ),
    );
  }

  Widget audioPreview(String path) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            path.fileName.limit(20),
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '.${path.fileExtension}',
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.audiotrack_rounded, color: Colors.black, size: 12),
        ],
      ),
    );
  }

  Widget docPreview(String path) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            path.fileName.limit(20),
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '.${path.fileExtension}',
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.description_rounded, color: Colors.black, size: 12),
        ],
      ),
    );
  }

  Widget imagePreview(String path) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 32),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.image_rounded,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget videoPreview(String path) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: VideoThumbnailBuilder(
        path,
        (File? file) {
          return Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.black)),
              if (file != null)
                Positioned.fill(
                  child: Image.file(file, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.videocam_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
