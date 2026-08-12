import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/regexes.dart';
import 'package:webtrit_phone/utils/text_matchers.dart';

/// Every call site matches case-insensitively, because the TLD list in [linkRegex] is lowercase.
String? matchLink(String text) => RegExp(linkRegex, caseSensitive: false).stringMatch(text);

/// The pattern `ParsedText` builds internally: all matcher patterns joined into one alternation,
/// applied over the whole message on every build.
String buildParsedTextPattern() {
  final patterns = TextMatchers.matchers(const TextStyle(), null).map((matcher) => matcher.pattern!);
  return '(${patterns.join('|')})';
}

void main() {
  group('linkRegex leaves ordinary text alone (WT-1168)', () {
    const notLinks = {
      'python attribute access': 'string.ascii_letters + string.digits',
      'method call': 'random.choice',
      'dotted module path': 'use os.path.join here',
      'nonsense pair': 'asd.zxc',
      'document file name': 'report.pdf attached',
      'source file name': 'main.dart',
      'config file name': 'config.yaml',
      'markup file name': 'index.html',
      'missing space after a full stop': 'the sentence ends here.Then the next one starts',
      'abbreviated name': 'Mr.Smith',
      'semantic version': 'version 1.2.3',
      'decimal number': 'that costs 3.14 dollars',
      'plain prose': 'no link here at all',
    };

    notLinks.forEach((description, text) {
      test(description, () => expect(matchLink(text), isNull, reason: '"$text" must not be linkified'));
    });
  });

  group('linkRegex still recognises real links', () {
    const links = {
      'bare host': ('portaone.com', 'portaone.com'),
      'host with path': ('webtrit.com/pricing', 'webtrit.com/pricing'),
      'www prefix': ('www.example.com', 'www.example.com'),
      'https with path, query and fragment': (
        'https://sub.domain.co.uk/path?a=b#frag here',
        'https://sub.domain.co.uk/path?a=b#frag',
      ),
      'ftp scheme': ('ftp://files.example.net/x.txt', 'ftp://files.example.net/x.txt'),
      'long tld': ('shop.example.online', 'shop.example.online'),
      'country code tld': ('my.site.io', 'my.site.io'),
      // A bare IP is not a host by itself, but behind a scheme it is - PBX admin panels use these.
      'ip address behind a scheme': ('http://192.168.1.1:8080/admin', 'http://192.168.1.1:8080/admin'),
    };

    links.forEach((description, sample) {
      final (text, expected) = sample;
      test(description, () => expect(matchLink(text), expected));
    });

    test('drops a full stop that ends the sentence', () {
      expect(matchLink('go to example.com.'), 'example.com');
    });

    test('finds every link in a message', () {
      final matches = RegExp(linkRegex, caseSensitive: false).allMatches('see example.com and www.other.org today');

      expect(matches.map((m) => m[0]), ['example.com', 'www.other.org']);
    });
  });

  group('linkRegex is case-insensitive', () {
    // The TLD list is lowercase, so an uppercase host only matches when the call site passes
    // `caseSensitive: false` - `RegexOptions` defaults it to true.
    const samples = {
      'EXAMPLE.COM': 'EXAMPLE.COM',
      'Example.Com': 'Example.Com',
      'HTTPS://WEBTRIT.COM': 'HTTPS://WEBTRIT.COM',
    };

    samples.forEach((text, expected) {
      test(text, () => expect(matchLink(text), expected));
    });
  });

  group('linkRegex leaves email addresses to emailRegex', () {
    test('does not scrape a dotted local part', () => expect(matchLink('mail me at a.b@example.org'), isNull));

    test('does not scrape the host of an address', () => expect(matchLink('user@host.com'), isNull));
  });

  group('linkRegex stays fast on pathological input (WT-1812)', () {
    // One unbroken run of word characters with no space and no dot. The unanchored regex this
    // replaced re-scanned the host part from every offset, costing O(n^2) - about 7 s here, which
    // is an ANR on Android and a watchdog kill on iOS, repeated on every rebuild.
    final unbrokenToken = 'ConversationsScreenPageRoute' * 700;
    final dotHeavy = 'ab.' * 6000;

    // Generous enough to absorb a slow CI machine while still failing a quadratic regression,
    // which costs seconds rather than milliseconds.
    const budget = Duration(seconds: 1);

    test('link detection over a 19k unbroken token', () {
      expect(unbrokenToken.length, greaterThan(19000));

      final stopwatch = Stopwatch()..start();
      matchLink(unbrokenToken);
      stopwatch.stop();

      expect(stopwatch.elapsed, lessThan(budget));
    });

    test('link detection over an 18k dot-heavy token', () {
      final stopwatch = Stopwatch()..start();
      matchLink(dotHeavy);
      stopwatch.stop();

      expect(stopwatch.elapsed, lessThan(budget));
    });

    test('the full matcher alternation over a 19k unbroken token', () {
      final pattern = RegExp(buildParsedTextPattern(), multiLine: true, dotAll: true, caseSensitive: false);

      final stopwatch = Stopwatch()..start();
      unbrokenToken.splitMapJoin(pattern, onMatch: (_) => '', onNonMatch: (_) => '');
      stopwatch.stop();

      expect(stopwatch.elapsed, lessThan(budget));
    });
  });
}
