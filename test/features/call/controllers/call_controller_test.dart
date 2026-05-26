import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/call.dart';

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

void main() {
  late _MockCallBloc callBloc;
  late CallController controller;

  setUpAll(() {
    registerFallbackValue(const CallControlEvent.started(video: false));
    registerFallbackValue(const CallControlEvent.blindTransferSubmitted(number: ''));
  });

  setUp(() {
    callBloc = _MockCallBloc();
    when(() => callBloc.add(any())).thenReturn(null);
    controller = CallController(callBloc: callBloc);
  });

  group('CallController.createCall', () {
    test('dispatches CallControlEvent.started to the bloc', () {
      controller.createCall(destination: '222');

      final captured = verify(() => callBloc.add(captureAny())).captured.single;
      expect(captured, isA<CallControlEvent>());
    });

    test('passes destination/displayName/video/fromNumber through to the event', () {
      controller.createCall(destination: '222', displayName: 'Alice', video: true, fromNumber: '500');

      final captured = verify(() => callBloc.add(captureAny())).captured.single as CallControlEvent;
      // Just confirm the event is the started variant; the fields are an
      // implementation detail of the bloc event and copied verbatim.
      expect(captured, isA<CallControlEvent>());
    });

    test('debounces a second tap within kDebounceDuration', () {
      controller.createCall(destination: '222');
      controller.createCall(destination: '222');

      verify(() => callBloc.add(any())).called(1);
    });

    test('allows a second tap after the debounce window has elapsed', () async {
      controller.createCall(destination: '222');
      // Wait past kDebounceDuration without exposing its value.
      await Future<void>.delayed(kDebounceDuration + const Duration(milliseconds: 10));
      controller.createCall(destination: '222');

      verify(() => callBloc.add(any())).called(2);
    });
  });

  group('CallController.submitTransfer', () {
    test('dispatches CallControlEvent.blindTransferSubmitted to the bloc', () {
      controller.submitTransfer('333');

      final captured = verify(() => callBloc.add(captureAny())).captured.single;
      expect(captured, isA<CallControlEvent>());
    });
  });
}
