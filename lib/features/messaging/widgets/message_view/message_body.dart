import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:quiver/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/extensions/string.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/media_view_page.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/multisource_image_view.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_thumbnail_builder.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'media_stagger_wrap.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({
    required this.text,
    required this.isMine,
    this.attachments = const [],
    this.style,
    this.previewDecoration,
    super.key,
  });

  final String text;
  final bool isMine;
  final List<String> attachments;
  final TextStyle? style;
  final BoxDecoration? previewDecoration;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  late final horizontalSpace = MediaQuery.of(context).size.width - (widget.isMine ? 82 : 82 + 48);

  late final attachments = widget.attachments;
  late final mediaAttachments =
      attachments.where((attachment) => attachment.isImagePath || attachment.isVideoPath).toList();
  late final fileAttachments =
      attachments.where((attachment) => !attachment.isImagePath && !attachment.isVideoPath).toList();

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

    final style = widget.style ?? theme.contentStyle;
    final previewDecoration = widget.previewDecoration ?? theme.quoteDecoration(widget.isMine);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        if (mediaAttachments.isNotEmpty) ...[
          MediaStaggerWrap(
            buildElement: (index, size) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MediaViewPage(attachments: mediaAttachments, initialIndex: index),
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
                    color: Colors.blueGrey.shade600,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)],
                  ),
                  child: Builder(builder: (context) {
                    final att = mediaAttachments[index];
                    if (att.isImagePath) {
                      return MultisourceImageView(att);
                    }
                    if (att.isVideoPath) {
                      return VideoThumbnailBuilder(
                        att,
                        (File? file) {
                          return Stack(
                            children: [
                              if (file != null)
                                Positioned.fill(child: MultisourceImageView(file.path, fit: BoxFit.cover)),
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
            count: mediaAttachments.length,
            space: horizontalSpace,
          ),
        ],
        if (fileAttachments.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: fileAttachments.map(
              (attachment) {
                return GestureDetector(
                  onTap: () async {
                    final file = attachment.isLocalPath
                        ? File(attachment)
                        : await DefaultCacheManager().getSingleFile(attachment);
                    OpenFile.open(file.path);
                  },
                  onLongPress: () {
                    // TODO: download, share popupmenu
                  },
                  child: filePreview(attachment.split('/').last),
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

  Widget filePreview(String path) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
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
        ],
      ),
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
