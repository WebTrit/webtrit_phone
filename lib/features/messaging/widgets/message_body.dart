import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/utils/utils.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({
    required this.text,
    this.style,
    this.previewDecoration,
    super.key,
  });

  final String text;
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
    final previewDecoration = widget.previewDecoration ?? theme.quoteDecoration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (preview != null) ...[
          Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (preview!.imageUrl != null) ...[
                  Image.network(preview!.imageUrl!),
                  const SizedBox(height: 8),
                ],
                if (preview!.title != null) ...[
                  Text(preview?.title ?? '', style: style.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                ],
                if (preview!.description != null) ...[
                  Text(preview?.description ?? '', style: style),
                  const SizedBox(height: 8),
                ]
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
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
