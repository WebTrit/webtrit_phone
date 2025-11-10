import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/utils/utils.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({required this.text, required this.isMine, this.style, this.previewDecoration, super.key});

  final String text;
  final bool isMine;
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

  void findLink(String text) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 600),
          sizeCurve: Curves.elasticOut,
          firstCurve: Curves.easeInExpo,
          alignment: Alignment.center,
          firstChild: Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (preview?.imageUrl != null) ...[Image.network(preview!.imageUrl!), const SizedBox(height: 8)],
                if (preview?.title != null) ...[
                  Text(preview?.title ?? '', style: style.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                ],
                if (preview?.description != null) ...[
                  Text(preview?.description ?? '', style: style),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
          secondChild: const SizedBox(),
          crossFadeState: preview != null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        ParsedText(
          parse: TextMatchers.matchers(style),
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          style: style.copyWith(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
          text: widget.text,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }
}
