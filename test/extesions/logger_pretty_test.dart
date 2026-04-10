import 'package:flutter_test/flutter_test.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  late Logger logger;
  late List<LogRecord> emittedLogs;

  setUp(() {
    Logger.root.clearListeners();
    emittedLogs = [];
    logger = Logger('TestLogger');

    logger.onRecord.listen(emittedLogs.add);
  });

  group('LoggerPretty Extension Tests', () {
    test('Should format simple Map as pretty JSON', () {
      final data = {'id': 1, 'name': 'Test User'};

      logger.infoPretty(data);

      expect(emittedLogs.length, 1);
      final message = emittedLogs.first.message;

      expect(message, contains('[TestLogger]: {'));
      expect(message, contains('  "id": 1'));
      expect(message, contains('  "name": "Test User"'));
    });

    test('Should handle SDP strings correctly (formatting newlines)', () {
      const sdpInput = 'v=0\r\no=mozilla...ISMB 12345\r\ns=Session Name\r\nt=0 0';

      logger.infoPretty(sdpInput, tag: 'WebRTC');

      expect(emittedLogs.length, 1);
      final message = emittedLogs.first.message;

      expect(message, contains('[WebRTC]: v=0'));
      expect(message, contains('\n  o=mozilla'));
      expect(message, contains('\n  s=Session Name'));
    });

    test('Should truncate extremely large lists (Collection Safety)', () {
      final largeList = List.generate(100, (index) => 'Item $index');

      logger.logPretty(largeList, maxCollectionItems: 10);

      final message = emittedLogs.first.message;

      expect(message, contains('"Item 0"'));
      expect(message, contains('"Item 9"'));
      expect(message, isNot(contains('"Item 11"')));
      expect(message, contains('90 more items'));
    });

    test('Should truncate extremely large maps (Collection Safety)', () {
      final largeMap = {for (var i = 0; i < 100; i++) 'key_$i': 'value_$i'};

      logger.logPretty(largeMap, maxCollectionItems: 5);

      final message = emittedLogs.first.message;

      expect(message, contains('key_0'));
      expect(message, contains('key_4'));
      expect(message, isNot(contains('key_6')));
      expect(message, contains('95 more keys'));
    });

    test('Should split long messages into chunks', () {
      final longString = List.generate(10, (_) => '0123456789').join();

      logger.logPretty(longString, chunkSize: 40);

      expect(emittedLogs.length, 3);
      expect(emittedLogs[0].message, contains('(1/3)'));
      expect(emittedLogs[1].message, contains('(2/3)'));
      expect(emittedLogs[2].message, contains('(3/3)'));
    });

    test('Should strictly truncate log message when it exceeds maxLogLength', () {
      final buffer = StringBuffer();
      for (var i = 0; i < 50; i++) {
        buffer.write('Line $i: Lorem ipsum dolor sit amet, consectetur adipiscing elit. ');
      }
      final longGeneratedText = buffer.toString();

      logger.logPretty(longGeneratedText, maxLogLength: 150);

      final message = emittedLogs.first.message;

      expect(message, contains('[TestLogger]'));
      expect(message, contains('[Log Truncated: Too Large'));
      expect(message, contains('Line 0: Lorem ipsum'));
      expect(message, isNot(contains('Line 49')));
      expect(message.length, lessThan(longGeneratedText.length));
    });

    test('Should handle null data safely', () {
      logger.infoPretty(null);

      expect(emittedLogs.length, 1);
      final message = emittedLogs.first.message;

      expect(message, contains('[TestLogger]: null'));
    });
  });
}
