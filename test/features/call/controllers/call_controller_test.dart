import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/notifications/models/notification.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/models/lines_state.dart';

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

class _MockNotificationsBloc extends MockBloc<NotificationsEvent, NotificationsState> implements NotificationsBloc {}

class _FakeCallRoutingState extends Fake implements CallRoutingState {
  _FakeCallRoutingState({required this.mainLinesState});

  @override
  final String? mainNumber = '111';

  @override
  final List<String> additionalNumbers = const [];

  @override
  final List<LineState> mainLinesState;

  @override
  final LineState? guestLineState = null;

  @override
  bool get hasIdleMainLine => mainLinesState.any((l) => l == LineState.idle);

  @override
  bool get hasIdleGuestLine => guestLineState == LineState.idle;

  @override
  late final allNumbers = <String>[?mainNumber, ...additionalNumbers];

  @override
  List<Object?> get props => [mainNumber, additionalNumbers, mainLinesState, guestLineState];
}

void main() {
  late _MockCallBloc callBloc;
  late _MockCallRoutingCubit callRoutingCubit;
  late _MockNotificationsBloc notificationsBloc;
  late CallController controller;

  setUpAll(() {
    registerFallbackValue(const CallControlEvent.started(video: false));
    registerFallbackValue(const NotificationsSubmitted(CallUndefinedLineNotification()));
  });

  setUp(() {
    callBloc = _MockCallBloc();
    callRoutingCubit = _MockCallRoutingCubit();
    notificationsBloc = _MockNotificationsBloc();
    controller = CallController(
      callBloc: callBloc,
      callRoutingCubit: callRoutingCubit,
      notificationsBloc: notificationsBloc,
    );
    when(() => callBloc.add(any())).thenReturn(null);
    when(() => notificationsBloc.add(any())).thenReturn(null);
  });

  group('CallController.createCall', () {
    group('routing state immediately available', () {
      test('dispatches CallControlEvent to callBloc when idle main line exists', () async {
        when(() => callRoutingCubit.state).thenReturn(_FakeCallRoutingState(mainLinesState: [LineState.idle]));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verify(() => callBloc.add(any(that: isA<CallControlEvent>()))).called(1);
        verifyNever(() => notificationsBloc.add(any()));
      });

      test('submits CallUndefinedLineNotification when all main lines are in use', () async {
        when(() => callRoutingCubit.state).thenReturn(_FakeCallRoutingState(mainLinesState: [LineState.inUse]));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        final captured = verify(() => notificationsBloc.add(captureAny())).captured.single;
        expect(captured, isA<NotificationsSubmitted>());
        expect((captured as NotificationsSubmitted).notification, isA<CallUndefinedLineNotification>());
        verifyNever(() => callBloc.add(any()));
      });

      test('does not dispatch call when no lines at all', () async {
        when(() => callRoutingCubit.state).thenReturn(_FakeCallRoutingState(mainLinesState: const []));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verifyNever(() => callBloc.add(any()));
      });
    });

    group('routing state initially null (app still initializing)', () {
      test('waits and dispatches call when routing state becomes available', () async {
        final routingState = _FakeCallRoutingState(mainLinesState: [LineState.idle]);
        when(() => callRoutingCubit.state).thenReturn(null);
        whenListen(callRoutingCubit, Stream.fromIterable([routingState]));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verify(() => callBloc.add(any(that: isA<CallControlEvent>()))).called(1);
      });

      test('skips null states and proceeds on first non-null routing state', () async {
        final routingState = _FakeCallRoutingState(mainLinesState: [LineState.idle]);
        when(() => callRoutingCubit.state).thenReturn(null);
        whenListen(callRoutingCubit, Stream.fromIterable([null, null, routingState]));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verify(() => callBloc.add(any(that: isA<CallControlEvent>()))).called(1);
      });

      test('silently drops call when cubit is disposed before routing state arrives', () async {
        when(() => callRoutingCubit.state).thenReturn(null);
        whenListen(callRoutingCubit, const Stream<CallRoutingState?>.empty());

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verifyNever(() => callBloc.add(any()));
        verifyNever(() => notificationsBloc.add(any()));
      });

      test('submits CallUndefinedLineNotification after wait if lines are all in use', () async {
        final routingState = _FakeCallRoutingState(mainLinesState: [LineState.inUse]);
        when(() => callRoutingCubit.state).thenReturn(null);
        whenListen(callRoutingCubit, Stream.fromIterable([routingState]));

        controller.createCall(destination: '222');
        await Future<void>.delayed(Duration.zero);

        verify(() => notificationsBloc.add(any(that: isA<NotificationsSubmitted>()))).called(1);
        verifyNever(() => callBloc.add(any()));
      });

      test('submits NoInternetConnectionNotification when routing state does not arrive before timeout', () {
        when(() => callRoutingCubit.state).thenReturn(null);
        whenListen(callRoutingCubit, StreamController<CallRoutingState?>().stream);

        fakeAsync((async) {
          controller.createCall(destination: '222');
          async.elapse(kCallRoutingStateTimeout);

          final captured = verify(() => notificationsBloc.add(captureAny())).captured.single;
          expect(captured, isA<NotificationsSubmitted>());
          expect((captured as NotificationsSubmitted).notification, isA<NoInternetConnectionNotification>());
          verifyNever(() => callBloc.add(any()));
        });
      });
    });
  });
}
