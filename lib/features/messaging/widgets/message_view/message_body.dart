import 'dart:io';

import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/common/media_storage_service.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/outbox_attachment.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'audio_view.dart';
import 'file_view.dart';
import 'media_stagger_wrap.dart';
import 'media_view_page.dart';
import 'multisource_image_view.dart';
import 'video_thumbnail_builder.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({
    required this.text,
    required this.isMine,
    this.outgoingAttachments = const [],
    this.style,
    this.previewDecoration,
    super.key,
  });

  final String text;
  final bool isMine;
  final List<OutboxAttachment> outgoingAttachments;
  final TextStyle? style;
  final BoxDecoration? previewDecoration;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  late final horizontalSpace = MediaQuery.of(context).size.width - (widget.isMine ? 82 : 82 + 48);

  late final attachments = widget.outgoingAttachments.map((e) => e.pickedPath);
  // late final attachments = <String>[
  //   'https://prx3-cogent.ukrtelcdn.net/s__green/6677346d73fc23e3a17f06e1b9a171e8:2025040410:a200RnowN20xU1EwNTZFTVo3bTAyOThLWjMrT09UZjF4V0FTVWVrTnAyQm9TcEVUSnpwNXZzQ2k5b3RWcUw5emR3WjBYRTdtUU9Sd0ZaTWd2TzBYNFE9PQ==/1/2/4/9/9/5/1/vh2e9.mp4',
  //   'https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68',
  //   'https://fastly.picsum.photos/id/14/2500/1667.jpg?hmac=ssQyTcZRRumHXVbQAVlXTx-MGBxm6NHWD3SryQ48G-o',
  //   'https://miyzvuk.net/uploads/public_files/2023-12/haddaway-what-is-love.mp3',
  //   'https://miyzvuk.net/uploads/public_files/2025-03/atlxs-mxzi-feat_-itamar-mc-montagem-ladrao-slowed.mp3',
  //   'https://prx-cogent.ukrtelcdn.net/s__ozzy/1a45473d7dc05bc308adf47232e28f7a:2025040411:a200RnowN20xU1EwNTZFTVo3bTAyOThLWjMrT09UZjF4V0FTVWVrTnAyQm9TcEVUSnpwNXZzQ2k5b3RWcUw5emp4OVRxQkxNOVFiSVJacjloVm9SWmc9PQ==/7/5/9/5/4/ulbzk.mp4'
  // ];

  late final viewableAttachments = attachments.where((a) => a.isImagePath || a.isVideoPath).toList();
  late final audioAttachments = attachments.where((a) => a.isAudioPath).toList();
  late final otherAttachments = attachments.where((a) => !a.isImagePath && !a.isVideoPath && !a.isAudioPath).toList();

  OutboxAttachment? outgoingAttachment(String path) {
    return widget.outgoingAttachments.firstWhereOrNull((e) => e.pickedPath == path);
  }

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
              final outgoingAtt = outgoingAttachment(att);

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MediaViewPage(attachments: viewableAttachments, initialIndex: index),
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
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Positioned.fill(
                          child: Builder(builder: (context) {
                            if (att.isImagePath) {
                              return MultisourceImageView(
                                att,
                                placeholder: Icon(Icons.image, color: colorScheme.secondary, size: 64),
                                error: Icon(Icons.error, color: colorScheme.secondary, size: 64),
                              );
                            }
                            if (att.isVideoPath) {
                              return VideoThumbnailBuilder(
                                att,
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
                                        )),
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
                        if (outgoingAtt != null)
                          LinearProgressIndicator(
                            value: outgoingAtt.progress,
                            color: colorScheme.primary,
                            backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
                          ),
                      ],
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
              (path) {
                final outgoingAtt = outgoingAttachment(path);
                return Stack(
                  children: [
                    AudioView(path),
                    if (outgoingAtt != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: LinearProgressIndicator(
                          value: outgoingAtt.progress,
                          color: theme.colorScheme.primary,
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                        ),
                      ),
                  ],
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
              (attachment) {
                final outgoingAtt = outgoingAttachment(attachment);
                return GestureDetector(
                  onTap: () async {
                    final file =
                        attachment.isLocalPath ? File(attachment) : await MediaStorageService.getFile(attachment);
                    OpenFile.open(file.path);
                  },
                  onLongPress: () {
                    // TODO: download, share popupmenu
                  },
                  child: Stack(
                    children: [
                      FileView(attachment),
                      if (outgoingAtt != null)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            value: outgoingAtt.progress,
                            color: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
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
