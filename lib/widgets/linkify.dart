import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:linkify/linkify.dart';

import 'package:webtrit_phone/theme/style/linkify_style.dart';
import 'package:webtrit_phone/theme/extension/linkify_styles.dart';

export 'package:webtrit_phone/theme/style/linkify_style.dart';

export 'package:linkify/linkify.dart'
    show
        LinkifyElement,
        LinkifyOptions,
        LinkableElement,
        TextElement,
        Linkifier,
        UrlElement,
        UrlLinkifier,
        EmailElement,
        EmailLinkifier;

typedef LinkCallback = void Function(LinkableElement link);

/// Turns URLs into links
class Linkify extends StatefulWidget {
  const Linkify({
    super.key,
    required this.text,
    this.linkifiers = const [...defaultLinkifiers, TelLinkifier()],
    this.onOpen,
    this.enableLinkableElement = true,
    this.options = const LinkifyOptions(),
    this.style,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.strutStyle,
  });

  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// Enable linkable element
  final bool enableLinkableElement;

  /// linkify's options.
  final LinkifyOptions options;

  // Style
  final LinkifyStyle? style;

  // Text.rich
  final int? maxLines;
  final TextOverflow overflow;
  final StrutStyle? strutStyle;

  @override
  State<Linkify> createState() => _LinkifyState();
}

class _LinkifyState extends State<Linkify> {
  late final List<LinkifyElement> _elements;
  late final Map<LinkableElement, GestureRecognizer> _recognizers;

  @override
  void initState() {
    super.initState();

    _elements = linkify(
      widget.text,
      options: widget.options,
      linkifiers: widget.linkifiers,
    );

    final onOpen = widget.onOpen;
    if (onOpen != null) {
      _recognizers = Map.fromEntries(
        _elements
            .whereType<LinkableElement>()
            .map((element) => MapEntry(element, (TapGestureRecognizer()..onTap = () => onOpen(element)))),
      );
    } else {
      _recognizers = {};
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final recognizer in _recognizers.values) {
      recognizer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = LinkifyStyle.merge(widget.style, Theme.of(context).extension<LinkifyStyles>()?.primary);

    return Text.rich(
      TextSpan(
        children: _elements.map((element) {
          if (element is LinkableElement) {
            return TextSpan(
              text: element.text,
              style: style.linkStyle?.copyWith(
                color: widget.enableLinkableElement ? style.linkStyle?.color : style.style?.color,
              ),
              recognizer: _recognizers[element],
            );
          } else {
            return TextSpan(
              text: element.text,
              style: style.style,
            );
          }
        }).toList(),
      ),
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      strutStyle: widget.strutStyle,
    );
  }
}

final _telRegex = RegExp(
  r'^(.*?)((tel:)[A-Z0-9._%+-]+)',
  caseSensitive: false,
  dotAll: true,
);

class TelLinkifier extends Linkifier {
  const TelLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        final match = _telRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0)!, '');

          if (match.group(1)?.isNotEmpty == true) {
            list.add(TextElement(match.group(1)!));
          }

          if (match.group(2)?.isNotEmpty == true) {
            // Always humanize tels
            list.add(TelElement(
              match.group(2)!.replaceFirst(RegExp(r'tel:'), ''),
            ));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}

/// Represents an element containing an email address
class TelElement extends LinkableElement {
  final String tel;

  TelElement(this.tel) : super(tel, 'tel:$tel');

  @override
  String toString() {
    return "TelElement: '$tel' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  int get hashCode => super.hashCode + tel.hashCode;

  @override
  bool equals(other) => other is TelElement && super.equals(other) && other.tel == tel;
}

final _urlRegex = RegExp(
  r'^(.*?)((?:https?:\/\/|www\.)[^\s/$.?#].[^\s]*)',
  caseSensitive: false,
  dotAll: true,
);

class UrlReplaceLinkifier extends Linkifier {
  const UrlReplaceLinkifier(this.replaceText);

  final String replaceText;

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        var match = _urlRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0)!, '');

          if (match.group(1)?.isNotEmpty == true) {
            list.add(TextElement(match.group(1)!));
          }

          if (match.group(2)?.isNotEmpty == true) {
            var originalUrl = match.group(2)!;
            var originText = originalUrl;

            list.add(UrlElement(originalUrl, replaceText, originText));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([TextElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    }

    return list;
  }
}
