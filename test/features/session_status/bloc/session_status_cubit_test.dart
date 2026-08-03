import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart' as ws;

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/push_tokens/bloc/push_tokens_bloc.dart';
import 'package:webtrit_phone/features/session_status/bloc/session_status_cubit.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockPushTokensBloc extends MockBloc<PushTokensEvent, PushTokensState> implements PushTokensBloc {}

SessionStatus _statusFor(CallStatus s, {String? pushTokenError}) =>
    SessionStatus(signalingStatus: s, pushTokenError: pushTokenError);

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

    test('emits initial status from constructor state', () {
      fakeAsync((async) {
        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: const Stream.empty());

        expect(cubit.state.status, _statusFor(CallStatus.ready));
        unawaited(cubit.close());
      });
    });

    test('the first combined state bypasses the smoothing even when transient', () {
      fakeAsync((async) {
        final cubit = buildCubit(initialCallState: _cs(CallStatus.connectError), callStream: const Stream.empty());

        expect(
          cubit.state.status,
          _statusFor(CallStatus.connectError),
          reason: 'the default state was never on screen, so there is nothing to hold',
        );
        unawaited(cubit.close());
      });
    });

    test('debounces changes between transient states and shows ready immediately', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.inProgress), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, _statusFor(CallStatus.inProgress), reason: 'transient flips are held back');

        async.elapse(kSignalingStatusDebounce);
        expect(cubit.state.status, _statusFor(CallStatus.connectIssue));

        callController.add(_cs(CallStatus.ready));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('recovering the network shows connecting at once, never the stale connect error', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.connectivityNone), callStream: callController.stream);

        // The network is back, but the derived state still carries the connect
        // error recorded during the outage (DNS failure on the last attempt).
        callController.add(_cs(CallStatus.connectError));
        expect(
          cubit.state.status,
          _statusFor(CallStatus.inProgress),
          reason: 'the stale error must be shown as connecting, not flashed',
        );

        callController.add(_cs(CallStatus.inProgress));
        callController.add(_cs(CallStatus.ready));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

        async.elapse(kSignalingStatusDebounce * 2);
        expect(cubit.state.status, _statusFor(CallStatus.ready), reason: 'nothing pending may fire later');

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('a connect error that persists past the window does surface', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.connectivityNone), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectError));
        expect(cubit.state.status, _statusFor(CallStatus.inProgress));

        async.elapse(kSignalingStatusDebounce);
        expect(cubit.state.status, _statusFor(CallStatus.connectError));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('drops a downgrade blip that returns to ready within the debounce window', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        // The re-register blip after a reconnect: ready -> inProgress -> ready.
        callController.add(_cs(CallStatus.inProgress));
        expect(cubit.state.status, _statusFor(CallStatus.ready), reason: 'the downgrade must be held back');

        async.elapse(kSignalingStatusDebounce ~/ 2);
        callController.add(_cs(CallStatus.ready));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

        async.elapse(kSignalingStatusDebounce * 2);
        expect(cubit.state.status, _statusFor(CallStatus.ready), reason: 'the dropped blip must not fire later');

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('shows a downgrade that outlives the debounce window', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

        async.elapse(kSignalingStatusDebounce);
        expect(cubit.state.status, _statusFor(CallStatus.connectIssue));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('shows the latest downgrade when several arrive within one window', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.inProgress));
        callController.add(_cs(CallStatus.connectError));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

        async.elapse(kSignalingStatusDebounce);
        expect(cubit.state.status, _statusFor(CallStatus.connectError));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('a signaling hiccup while unregistered is held back, not amplified', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.appUnregistered), callStream: callController.stream);

        // A sub-second blip: connectIssue and back. Nothing may reach the UI.
        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, _statusFor(CallStatus.appUnregistered));

        callController.add(_cs(CallStatus.appUnregistered));
        expect(cubit.state.status, _statusFor(CallStatus.appUnregistered));

        async.elapse(kSignalingStatusDebounce * 2);
        expect(cubit.state.status, _statusFor(CallStatus.appUnregistered));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('a push token error rides through immediately while a transient is held', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);
        final pushController = StreamController<PushTokensState>(sync: true);

        final cubit = buildCubit(
          initialCallState: _cs(CallStatus.ready),
          callStream: callController.stream,
          pushStream: pushController.stream,
        );

        callController.add(_cs(CallStatus.inProgress));
        expect(cubit.state.status, _statusFor(CallStatus.ready), reason: 'the downgrade itself is held');

        pushController.add(const PushTokensState(errorMessage: 'token failed'));
        expect(cubit.state.status.hasPushTokenError, isTrue, reason: 'orthogonal fields must not wait for the window');
        expect(cubit.state.status.signalingStatus, CallStatus.ready);

        callController.close();
        pushController.close();
        unawaited(cubit.close());
      });
    });

    test('shows losing the network immediately, without the debounce', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectivityNone));
        expect(cubit.state.status, _statusFor(CallStatus.connectivityNone));

        callController.close();
        unawaited(cubit.close());
      });
    });

    test('emits pushTokenError when push token is missing', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);
        final pushController = StreamController<PushTokensState>(sync: true);

        final cubit = buildCubit(
          initialCallState: _cs(CallStatus.ready),
          callStream: callController.stream,
          pushStream: pushController.stream,
        );

        expect(cubit.state.status, _statusFor(CallStatus.ready));

        pushController.add(const PushTokensState(errorMessage: 'token failed'));
        expect(cubit.state.status.hasPushTokenError, isTrue);
        expect(cubit.state.status.signalingStatus, CallStatus.ready);

        callController.close();
        pushController.close();
        unawaited(cubit.close());
      });
    });

    test('clears pushTokenError when push token is restored', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);
        final pushController = StreamController<PushTokensState>(sync: true);

        final cubit = buildCubit(
          initialCallState: _cs(CallStatus.ready),
          callStream: callController.stream,
          initialPushState: const PushTokensState(errorMessage: 'token failed'),
          pushStream: pushController.stream,
        );

        expect(cubit.state.status.hasPushTokenError, isTrue);

        pushController.add(const PushTokensState(pushToken: 'abc'));
        expect(cubit.state.status.hasPushTokenError, isFalse);
        expect(cubit.state.status.signalingStatus, CallStatus.ready);

        callController.close();
        pushController.close();
        unawaited(cubit.close());
      });
    });
  });
}
