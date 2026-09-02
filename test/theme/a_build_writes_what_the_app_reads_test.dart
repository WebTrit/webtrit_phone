import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/theme/models/models.dart';

/// The files a white-label build writes, read the way the app reads them.
///
/// A build fetches a brand's configuration and writes eight files into this
/// checkout; the app parses those files at startup. Nothing stood between the
/// two: every test on either side used a document it made up itself, so a
/// change in the shape one writes and the other reads would have been found by
/// a person starting the app, not by a check.
///
/// What is on disk here is the stock WebTrit theme - the same eight files a
/// build replaces, in the same places - so parsing them is parsing what a
/// build produces.
void main() {
  Map<String, dynamic> objectAt(String path) {
    final file = File(path);
    expect(file.existsSync(), isTrue, reason: '$path is what a build writes; the app reads it at startup');
    return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  }

  List<dynamic> listAt(String path) {
    final file = File(path);
    expect(file.existsSync(), isTrue, reason: '$path is what a build writes; the app reads it at startup');
    return jsonDecode(file.readAsStringSync()) as List<dynamic>;
  }

  group('the appearance files', () {
    test('a colour scheme parses, for both appearances', () {
      for (final appearance in ['light', 'dark']) {
        final config = ColorSchemeConfig.fromJson(
          objectAt('assets/themes/original.color_scheme.$appearance.config.json'),
        );

        expect(config.seedColor, startsWith('#'), reason: 'the seed of the $appearance appearance');
      }
    });

    test('a page configuration parses, for both appearances', () {
      for (final appearance in ['light', 'dark']) {
        expect(
          () => ThemePageConfig.fromJson(objectAt('assets/themes/original.page.$appearance.config.json')),
          returnsNormally,
          reason: 'the $appearance pages',
        );
      }
    });

    test('a widget configuration parses, for both appearances', () {
      for (final appearance in ['light', 'dark']) {
        expect(
          () => ThemeWidgetConfig.fromJson(objectAt('assets/themes/original.widget.$appearance.config.json')),
          returnsNormally,
          reason: 'the $appearance widgets',
        );
      }
    });
  });

  group('the application files', () {
    test('what the app is allowed to do parses', () {
      final config = AppConfig.fromJson(objectAt('assets/themes/app.config.json'));

      expect(
        config.supported,
        isNotEmpty,
        reason: 'a build that names no capabilities leaves an app that does nothing',
      );
    });

    test('the embedded resources parse, each one of them', () {
      final embeds = listAt('assets/themes/app.embedded.config.json');

      for (final embed in embeds) {
        expect(
          () => EmbeddedResource.fromJson(Map<String, dynamic>.from(embed as Map)),
          returnsNormally,
          reason: 'an embed a build wrote that the app cannot read leaves a screen missing',
        );
      }
    });
  });

  group('what a picture reference has to carry', () {
    // A build rewrites every picture reference to the file it downloaded, and
    // the app resolves that address at startup. A reference left pointing at
    // the service - or at nothing - is a blank screen with no error anywhere.
    test('every reference names a local file, and that file is on disk', () {
      final unresolved = <String>[];
      final missing = <String>[];

      void walk(Object? node, String path) {
        if (node is Map) {
          if (node[r'$ref'] == 'asset') {
            final uri = node['uri'];
            if (uri is! String || !uri.startsWith('asset://')) {
              unresolved.add(path);
            } else {
              final onDisk = File(uri.replaceFirst('asset://', ''));
              if (!onDisk.existsSync()) missing.add(uri);
            }
            return;
          }
          node.forEach((key, value) => walk(value, '$path.$key'));
        } else if (node is List) {
          for (var i = 0; i < node.length; i++) {
            walk(node[i], '$path[$i]');
          }
        }
      }

      for (final file in Directory('assets/themes').listSync().whereType<File>()) {
        if (!file.path.endsWith('.json')) continue;
        walk(jsonDecode(file.readAsStringSync()), file.path);
      }

      expect(unresolved, isEmpty, reason: 'these references have no local address, so nothing will be drawn');
      expect(missing, isEmpty, reason: 'these references name a file that is not here');
    });
  });
}
