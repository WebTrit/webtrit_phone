import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';

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
  String? link;
  dynamic linkPreview;
  static final previewsCache = LruMap<String, dynamic>(maximumSize: 100);

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
    final regex = RegExp(regexLink, caseSensitive: false);
    final match = regex.stringMatch(text);
    linkPreview = previewsCache[match];
    if (mounted) setState(() => link = match);
  }

  setLinkPreview(data) {
    if (link != null) previewsCache[link!] = data;
    if (mounted) setState(() => linkPreview = data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = widget.style ?? theme.contentStyle;
    final previewDecoration = widget.previewDecoration ?? theme.quoteDecoration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (link != null) ...[
          Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            child: LinkPreview(
              textStyle: widget.style,
              linkStyle: widget.style,
              headerStyle: widget.style,
              metadataTextStyle: widget.style,
              metadataTitleStyle: widget.style,
              enableAnimation: true,
              onPreviewDataFetched: setLinkPreview,
              previewData: linkPreview,
              text: link!,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(0),
            ),
          ),
          const SizedBox(height: 8),
        ],
        ParsedText(
          parse: [
            mailToMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
            urlMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
            boldMatcher(style: style.copyWith(fontWeight: FontWeight.bold)),
            italicMatcher(style: style.copyWith(fontStyle: FontStyle.italic)),
            lineThroughMatcher(style: style.copyWith(decoration: TextDecoration.lineThrough)),
            codeMatcher(style: style.copyWith(fontFamily: 'Courier')),
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

MatchText mailToMatcher({final TextStyle? style}) {
  return MatchText(
    onTap: (mail) async {
      final url = Uri(scheme: 'mailto', path: mail);
      if (await canLaunchUrl(url)) await launchUrl(url);
    },
    pattern: regexEmail,
    style: style,
  );
}

MatchText urlMatcher({final TextStyle? style, final Function(String url)? onLinkPressed}) {
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
    pattern: regexLink,
    style: style,
  );
}

MatchText boldMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'\*[^*]+\*',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('*', '')};
    },
  );
}

MatchText italicMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'_[^_]+_',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('_', '')};
    },
  );
}

MatchText lineThroughMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'~[^~]+~',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('~', '')};
    },
  );
}

MatchText codeMatcher({final TextStyle? style}) {
  return MatchText(
    pattern: r'`[^`]+`',
    style: style,
    renderText: ({required String str, required String pattern}) {
      return {'display': str.replaceAll('`', '')};
    },
  );
}
