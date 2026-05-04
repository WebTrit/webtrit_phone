import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart' as ws;

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/push_tokens/bloc/push_tokens_bloc.dart';
import 'package:webtrit_phone/features/session_status/bloc/session_status_cubit.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockPushTokensBloc extends MockBloc<PushTokensEvent, PushTokensState> implements PushTokensBloc {}

CallState _cs(CallStatus target) => switch (target) {
  CallStatus.ready => CallState(
    callServiceState: CallServiceState(
      signalingClientStatus: SignalingClientStatus.connect,
      registration: const ws.Registration(status: ws.RegistrationStatus.registered),
    ),
  ),
  CallStatus.inProgress => CallState(),
  CallStatus.connectIssue => CallState(callServiceState: const CallServiceState(lastSignalingDisconnectCode: 1006)),
  CallStatus.connectError => CallState(
    callServiceState: const CallServiceState(lastSignalingClientConnectError: 'err'),
  ),
  CallStatus.connectivityNone => CallState(callServiceState: const CallServiceState(networkStatus: NetworkStatus.none)),
  CallStatus.appUnregistered => CallState(
    callServiceState: CallServiceState(registration: const ws.Registration(status: ws.RegistrationStatus.unregistered)),
  ),
};

void main() {
  group('SessionStatusCubit', () {
    late _MockCallBloc callBloc;
    late _MockPushTokensBloc pushTokensBloc;

    setUp(() {
      callBloc = _MockCallBloc();
      pushTokensBloc = _MockPushTokensBloc();
    });

    SessionStatusCubit buildCubit({
      required CallState initialCallState,
      required Stream<CallState> callStream,
      PushTokensState initialPushState = const PushTokensState(),
      Stream<PushTokensState>? pushStream,
    }) {
      when(() => callBloc.state).thenReturn(initialCallState);
      when(() => callBloc.stream).thenAnswer((_) => callStream);
      when(() => pushTokensBloc.state).thenReturn(initialPushState);
      when(() => pushTokensBloc.stream).thenAnswer((_) => pushStream ?? const Stream.empty());
      return SessionStatusCubit(pushTokensBloc: pushTokensBloc, callBloc: callBloc);
    }

    test('ready → connectIssue emits immediately without debounce', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        expect(cubit.state.status, SessionStatus.ready);

        // connectIssue is transient, ready is not — crosses non-transient boundary, immediate
        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, SessionStatus.connectIssue);

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('connectIssue → inProgress → connectError suppressed until debounce fires', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        // Cross into transient zone immediately (ready is non-transient)
        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, SessionStatus.connectIssue);

        // Both subsequent statuses are transient — debounce suppresses them
        callController.add(_cs(CallStatus.inProgress));
        callController.add(_cs(CallStatus.connectError));

        async.elapse(const Duration(seconds: 1));
        expect(cubit.state.status, SessionStatus.connectIssue);

        // Advance past the 3.5-second debounce window
        async.elapse(const Duration(seconds: 3));
        expect(cubit.state.status, SessionStatus.connectError);

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('inProgress → ready cancels debounce and emits ready immediately', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue)); // immediate
        callController.add(_cs(CallStatus.inProgress)); // debounced

        expect(cubit.state.status, SessionStatus.connectIssue);

        // ready is non-transient — cancels debounce and emits immediately
        callController.add(_cs(CallStatus.ready));
        expect(cubit.state.status, SessionStatus.ready);

        // No deferred emission after the debounce window
        async.elapse(const Duration(seconds: 4));
        expect(cubit.state.status, SessionStatus.ready);

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('connectivityNone bypasses debounce from within transient zone', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue)); // immediate
        callController.add(_cs(CallStatus.inProgress)); // debounced

        expect(cubit.state.status, SessionStatus.connectIssue);

        // connectivityNone is non-transient — immediate even from within transient zone
        callController.add(_cs(CallStatus.connectivityNone));
        expect(cubit.state.status, SessionStatus.connectivityNone);

        async.elapse(const Duration(seconds: 4));
        expect(cubit.state.status, SessionStatus.connectivityNone);

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('appUnregistered bypasses debounce from within transient zone', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue)); // immediate
        callController.add(_cs(CallStatus.inProgress)); // debounced

        expect(cubit.state.status, SessionStatus.connectIssue);

        // appUnregistered is non-transient — immediate even from within transient zone
        callController.add(_cs(CallStatus.appUnregistered));
        expect(cubit.state.status, SessionStatus.appUnregistered);

        async.elapse(const Duration(seconds: 4));
        expect(cubit.state.status, SessionStatus.appUnregistered);

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('close() while debounce pending does not emit', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue)); // immediate
        callController.add(_cs(CallStatus.inProgress)); // debounced

        expect(cubit.state.status, SessionStatus.connectIssue);

        // close() disposes the debounce timer, so the pending emission is dropped
        unawaited(cubit.close());
        async.flushMicrotasks();

        async.elapse(const Duration(seconds: 4));
        expect(cubit.state.status, SessionStatus.connectIssue);

        callController.close();
      });
    });
  });
}
