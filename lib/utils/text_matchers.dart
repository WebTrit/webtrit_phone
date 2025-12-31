import 'package:flutter/material.dart';

import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/utils/regexes.dart';

class TextMatchers {
  static List<MatchText> matchers(TextStyle style, BoxDecoration? quoteDecoration) {
    return [
      TextMatchers.quoteMatcher(style: style, quoteDecoration: quoteDecoration),
      TextMatchers.mailToMatcher(
        style: style.copyWith(decoration: TextDecoration.underline, color: style.color?.withAlpha(100)),
      ),
      TextMatchers.urlMatcher(
        style: style.copyWith(decoration: TextDecoration.underline, color: style.color?.withAlpha(100)),
      ),
      TextMatchers.boldMatcher(style: style.copyWith(fontWeight: FontWeight.bold)),
      TextMatchers.italicMatcher(style: style.copyWith(fontStyle: FontStyle.italic)),
      TextMatchers.lineThroughMatcher(style: style.copyWith(decoration: TextDecoration.lineThrough)),
      TextMatchers.underlineMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
      TextMatchers.codeMatcher(style: style.copyWith(fontFamily: 'Courier')),
    ];
  }

  static MatchText boldMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'\*[^*]+\*',
      style: style,
      onTap: (_) {},
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('*', '')};
      },
    );
  }

  static MatchText italicMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'_[^_]+_',
      style: style,
      onTap: (_) {},
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('_', '')};
      },
    );
  }

  static MatchText lineThroughMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'~[^~]+~',
      style: style,
      onTap: (_) {},
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('~', '')};
      },
    );
  }

  static MatchText underlineMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'\+[^+]+\+',
      style: style,
      onTap: (_) {},
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('+', '')};
      },
    );
  }

  static MatchText codeMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'`[^`]+`',
      style: style,
      onTap: (_) {},
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('`', '')};
      },
    );
  }

  static MatchText quoteMatcher({final TextStyle? style, final BoxDecoration? quoteDecoration}) {
    return MatchText(
      pattern: r'>[^\n]+',
      style: style,
      onTap: (_) {},
      renderWidget: ({required pattern, required text}) {
        return Container(
          decoration: quoteDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: Text(text.replaceFirst('>', '').trim(), style: style),
        );
      },
    );
  }

  static MatchText mailToMatcher({final TextStyle? style, final bool tapEnabled = true}) {
    return MatchText(
      onTap: tapEnabled
          ? (mail) async {
              final url = Uri(scheme: 'mailto', path: mail);
              if (await canLaunchUrl(url)) await launchUrl(url);
            }
          : null,
      pattern: emailRegex,
      style: style,
    );
  }

  static MatchText urlMatcher({final TextStyle? style, final bool tapEnabled = true}) {
    return MatchText(
      onTap: tapEnabled
          ? (urlText) async {
              final protocolIdentifierRegex = RegExp(r'^((http|ftp|https):\/\/)', caseSensitive: false);
              if (!urlText.startsWith(protocolIdentifierRegex)) {
                urlText = 'https://$urlText';
              }

              final url = Uri.tryParse(urlText);
              if (url != null && await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            }
          : null,
      pattern: linkRegex,
      style: style,
    );
  }
}
