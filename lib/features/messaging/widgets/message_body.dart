import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:quiver/collection.dart';
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
            boldMatcher(style: style.merge(PatternStyle.bold.textStyle)),
            italicMatcher(style: style.merge(PatternStyle.italic.textStyle)),
            lineThroughMatcher(style: style.merge(PatternStyle.lineThrough.textStyle)),
            codeMatcher(style: style.merge(PatternStyle.code.textStyle)),
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
