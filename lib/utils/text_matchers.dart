import 'package:flutter/material.dart';

import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/utils/regexes.dart';

class TextMatchers {
  static List<MatchText> matchers(TextStyle style) {
    return [
      mailToMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
      urlMatcher(style: style.copyWith(decoration: TextDecoration.underline)),
      boldMatcher(style: style.copyWith(fontWeight: FontWeight.bold)),
      italicMatcher(style: style.copyWith(fontStyle: FontStyle.italic)),
      lineThroughMatcher(style: style.copyWith(decoration: TextDecoration.lineThrough)),
      codeMatcher(style: style.copyWith(fontFamily: 'Courier')),
    ];
  }

  static MatchText boldMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'\*[^*]+\*',
      style: style,
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('*', '')};
      },
    );
  }

  static MatchText italicMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'_[^_]+_',
      style: style,
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('_', '')};
      },
    );
  }

  static MatchText lineThroughMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'~[^~]+~',
      style: style,
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('~', '')};
      },
    );
  }

  static MatchText codeMatcher({final TextStyle? style}) {
    return MatchText(
      pattern: r'`[^`]+`',
      style: style,
      renderText: ({required String str, required String pattern}) {
        return {'display': str.replaceAll('`', '')};
      },
    );
  }

  static MatchText mailToMatcher({final TextStyle? style}) {
    return MatchText(
      onTap: (mail) async {
        final url = Uri(scheme: 'mailto', path: mail);
        if (await canLaunchUrl(url)) await launchUrl(url);
      },
      pattern: emailRegex,
      style: style,
    );
  }

  static MatchText urlMatcher({final TextStyle? style, final Function(String url)? onLinkPressed}) {
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
}
