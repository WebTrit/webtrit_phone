import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/theme/models/resource_loader.dart';

void main() {
  ResourceLoader build(String uri) => ResourceLoader.fromUri(uri);

  group('inline content', () {
    test('is decoded when it follows a single colon', () async {
      final loader = build('memory:${base64Encode(utf8.encode('Hello world'))}');

      expect(loader, isA<MemoryResourceLoader>());
      expect(utf8.decode(base64Decode(await loader.loadContent())), 'Hello world');
    });

    test('keeps its capitals, which is what the single colon buys', () async {
      const content = 'MiXeD CaSe';
      final loader = build('memory:${base64Encode(utf8.encode(content))}');

      expect(utf8.decode(base64Decode(await loader.loadContent())), content);
    });

    test('is refused when written after slashes, instead of decoding to nonsense', () {
      expect(() => build('memory://${base64Encode(utf8.encode('Hello world'))}'), throwsArgumentError);
    });
  });

  group('bundled content', () {
    test('is addressed without its scheme, written with slashes', () {
      expect(build('asset://assets/themes/app.config.json').resourceUri.toString(), 'assets/themes/app.config.json');
    });

    test('is addressed without its scheme, written with a single colon', () {
      expect(build('asset:assets/themes/app.config.json').resourceUri.toString(), 'assets/themes/app.config.json');
    });
  });

  test('a remote address is kept whole', () {
    expect(build('https://webtrit.com/legal/x').resourceUri.toString(), 'https://webtrit.com/legal/x');
  });

  test('an unknown scheme is refused', () {
    expect(() => build('mailto:support@webtrit.com'), throwsArgumentError);
  });
}
