import 'dart:io';

import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:webtrit_phone/extensions/string.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
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

  List<String> get attachments {
    return widget.attachments;
  }

  List<String> get mediaAttachments {
    return attachments.where((attachment) => attachment.isImagePath).toList();
  }

  List<String> get fileAttachments {
    return attachments.where((attachment) => !attachment.isImagePath).toList();
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
      children: [
        if (mediaAttachments.isNotEmpty) ...[
          MediaStaggerWrap(
            buildElement: (index, size) => imagePreview(mediaAttachments[index], size: size),
            count: mediaAttachments.length,
            space: MediaQuery.of(context).size.width - (widget.isMine ? 82 : 82 + 48),
          ),
          const SizedBox(height: 8),
        ],
        if (fileAttachments.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: fileAttachments.map((attachment) {
              return filePreview(attachment.split('/').last);
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 600),
          sizeCurve: Curves.elasticOut,
          firstCurve: Curves.easeInExpo,
          alignment: Alignment.center,
          firstChild: Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              spacing: 8,
              children: [
                if (preview?.imageUrl != null) ...[
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.network(preview!.imageUrl!),
                  ),
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
          secondChild: const SizedBox(),
          crossFadeState: preview != null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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

  Widget imagePreview(String path, {double size = 64}) {
    Widget frameBuilder(_, Widget child, frame, wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) return child;

      return SizedBox(
        height: size,
        width: size,
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
          firstChild: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            color: Colors.blueGrey.shade600,
            child: Icon(
              Icons.image,
              size: size / 2,
              color: Colors.white,
            ),
          ),
          secondChild: child,
          crossFadeState: frame == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      );
    }

    Widget errorBuilder(_, __, ___) {
      return Icon(Icons.error, size: size);
    }

    return SizedBox(
      height: size,
      width: size,
      child: Container(
        margin: const EdgeInsets.all(2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: path.isLocalPath
            ? Image.file(
                File(path),
                height: size,
                width: size,
                fit: BoxFit.cover,
                errorBuilder: errorBuilder,
                frameBuilder: frameBuilder,
              )
            : Image.network(
                path,
                height: size,
                width: size,
                fit: BoxFit.cover,
                errorBuilder: errorBuilder,
                frameBuilder: frameBuilder,
                // loadingBuilder: loadingBuilder,
              ),
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
