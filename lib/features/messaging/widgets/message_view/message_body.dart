import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiver/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';

import 'package:webtrit_phone/common/media_storage_service.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/message_attachment.dart';
import 'package:webtrit_phone/models/outbox_attachment.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'audio_view.dart';
import 'file_view.dart';
import 'media_stagger_wrap.dart';
import 'media_view_page.dart';
import 'multisource_image_view.dart';
import 'outbox_upload_progress_wrapper.dart';
import 'video_thumbnail_builder.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({
    required this.text,
    required this.isMine,
    this.attachments = const [],
    this.outgoingAttachments = const [],
    this.style,
    this.previewDecoration,
    super.key,
  });

  final String text;
  final bool isMine;
  final List<MessageAttachment> attachments;
  final List<OutboxAttachment> outgoingAttachments;

  final TextStyle? style;
  final BoxDecoration? previewDecoration;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  late final horizontalSpace = MediaQuery.of(context).size.width - (widget.isMine ? 82 : 82 + 48);

  List<AttachmentView> get attViews => mapAttachmentView(
        outgoing: widget.outgoingAttachments,
        remote: widget.attachments,
        remoteBase: context.read<AppBloc>().state.coreUrl!,
      );
  List<AttachmentView> get viewableAttachments => attViews.where((a) => a.isViewable).toList();
  List<AttachmentView> get audioAttachments => attViews.where((a) => a.isHearable).toList();
  List<AttachmentView> get otherAttachments => attViews.where((a) => !a.isViewable && !a.isHearable).toList();

  static final previewsCache = LruMap<String, OgPreview>(maximumSize: 100);
  OgPreview? preview;

  @override
  void initState() {
    super.initState();
    findLink(widget.text);
  }

  @override
  void didUpdateWidget(covariant MessageBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) findLink(widget.text);
  }

  findLink(String text) {
    final match = RegExp(linkRegex, caseSensitive: false).stringMatch(text);

    if (match != null) {
      if (previewsCache[match] != null) {
        preview = previewsCache[match];
        if (mounted) setState(() {});
      } else {
        OgPreview.get(match).then((value) {
          if (value != null) previewsCache[match] = value;
          if (mounted) setState(() => preview = value);
        });
      }
    } else {
      if (mounted) setState(() => preview = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final style = widget.style ?? theme.contentStyle;
    final previewDecoration = widget.previewDecoration ?? theme.quoteDecoration(widget.isMine);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        if (viewableAttachments.isNotEmpty) ...[
          MediaStaggerWrap(
            buildElement: (index, size) {
              final att = viewableAttachments[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MediaViewPage(
                        attachments: viewableAttachments.map((e) => (path: e.path, filename: e.fileNameExt)).toList(),
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: size,
                  width: size,
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)],
                    ),
                    child: OutboxUploadProgressWrapper(
                      uploadProgress: att.uploadProgress,
                      fill: true,
                      child: Builder(builder: (context) {
                        if (att.path.isImagePath) {
                          return MultisourceImageView(
                            att.path,
                            placeholder: Icon(Icons.image, color: colorScheme.secondary, size: 64),
                            error: Icon(Icons.error, color: colorScheme.secondary, size: 64),
                          );
                        }
                        if (att.path.isVideoPath) {
                          return VideoThumbnailBuilder(
                            att.path,
                            (File? file) {
                              return Stack(
                                children: [
                                  if (file != null)
                                    Positioned.fill(
                                      child: MultisourceImageView(
                                        file.path,
                                        fit: BoxFit.cover,
                                        placeholder: const SizedBox(),
                                        error: const SizedBox(),
                                      ),
                                    ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.play_arrow_outlined, color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      }),
                    ),
                  ),
                ),
              );
            },
            count: viewableAttachments.length,
            space: horizontalSpace,
          ),
        ],
        if (audioAttachments.isNotEmpty) ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: audioAttachments.map(
              (att) {
                return OutboxUploadProgressWrapper(
                  uploadProgress: att.uploadProgress,
                  child: AudioView(att.path, att.fileNameExt),
                );
              },
            ).toList(),
          ),
        ],
        if (otherAttachments.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: otherAttachments.map(
              (att) {
                return GestureDetector(
                  onTap: () async {
                    final file = att.path.isLocalPath ? File(att.path) : await MediaStorageService.getFile(att.path);
                    OpenFile.open(file.path);
                  },
                  onLongPress: () {
                    // TODO: download, share popupmenu
                  },
                  child: OutboxUploadProgressWrapper(
                    uploadProgress: att.uploadProgress,
                    child: FileView(att.fileNameExt),
                  ),
                );
              },
            ).toList(),
          ),
        ],
        if (preview != null)
          Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            child: Column(
              spacing: 8,
              children: [
                if (preview?.imageUrl != null) ...[
                  MultisourceImageView(preview!.imageUrl!),
                ],
                if ((preview?.title) != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          preview!.title!,
                          style: style.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.link_sharp, size: 16, color: Colors.grey.shade600),
                    ],
                  ),
                if (preview?.description != null) ...[
                  Text(
                    preview!.description!,
                    style: style,
                  ),
                ],
                if (preview?.imageUrl != null && preview?.title == null && preview?.description == null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          preview!.imageUrl!,
                          style: style.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.link_sharp, size: 16, color: Colors.grey.shade600),
                    ],
                  ),
              ],
            ),
          ),
        ParsedText(
          parse: [
            _mailToMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
            _urlMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
            _boldMatcher(style: style.copyWith(fontWeight: FontWeight.bold)),
            _italicMatcher(style: style.copyWith(fontStyle: FontStyle.italic)),
            _lineThroughMatcher(style: style.copyWith(decoration: TextDecoration.lineThrough)),
            _codeMatcher(style: style.copyWith(fontFamily: 'Courier')),
          ],
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          style: style.copyWith(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
          text: widget.text,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }
}

MatchText _mailToMatcher({final TextStyle? style}) {
  return MatchText(
    onTap: (mail) async {
      final url = Uri(scheme: 'mailto', path: mail);
      if (await canLaunchUrl(url)) await launchUrl(url);
    },
    pattern: emailRegex,
    style: style,
  );
}

MatchText _urlMatcher({final TextStyle? style, final Function(String url)? onLinkPressed}) {
  return MatchText(
    onTap: (urlText) async {
      final protocolIdentifierRegex = RegExp(
        r'^((http|ftp|https):\/\/)',
        caseSensitive: false,
      );
      if (!urlText.startsWith(protocolIdentifierRegex)) {
        urlText = 'https://$urlText';
      }
      if (onLinkPressed != null) {
        onLinkPressed(urlText);
      } else {
        final url = Uri.tryParse(urlText);
        if (url != null && await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }
      }
    },
    pattern: linkRegex,
    style: style,
  );
}

MatchText _boldMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'\*[^*]+\*',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('*', '')};
    },
  );
}

MatchText _italicMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'_[^_]+_',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('_', '')};
    },
  );
}

MatchText _lineThroughMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'~[^~]+~',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('~', '')};
    },
  );
}

MatchText _codeMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'`[^`]+`',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('`', '')};
    },
  );
}

typedef AttachmentView = ({
  String path,
  String fileNameExt,
  double? uploadProgress,
  bool isViewable,
  bool isHearable,
});

List<AttachmentView> mapAttachmentView({
  required List<OutboxAttachment> outgoing,
  required List<MessageAttachment> remote,
  required String remoteBase,
}) {
  List<AttachmentView> attachments = [];

  for (final att in outgoing) {
    attachments.add(
      (
        fileNameExt: att.pickedPath.fileNameWithExtension,
        path: att.pickedPath,
        uploadProgress: att.progress,
        isViewable: att.pickedPath.isImagePath || att.pickedPath.isVideoPath,
        isHearable: att.pickedPath.isAudioPath,
      ),
    );
  }

  for (final att in remote) {
    final fullPath = '$remoteBase/${att.filePath}';
    attachments.add(
      (
        fileNameExt: att.fileName,
        path: fullPath,
        uploadProgress: null,
        isViewable: fullPath.isImagePath || fullPath.isVideoPath,
        isHearable: fullPath.isAudioPath,
      ),
    );
  }

  return attachments;
}
