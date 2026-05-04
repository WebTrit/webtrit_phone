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

    test('emits immediately on every callStatus change — no debounce', () {
      fakeAsync((async) {
        final callController = StreamController<CallState>(sync: true);

        final cubit = buildCubit(initialCallState: _cs(CallStatus.ready), callStream: callController.stream);

        callController.add(_cs(CallStatus.connectIssue));
        expect(cubit.state.status, _statusFor(CallStatus.connectIssue));

        callController.add(_cs(CallStatus.inProgress));
        expect(cubit.state.status, _statusFor(CallStatus.inProgress));

        callController.add(_cs(CallStatus.connectError));
        expect(cubit.state.status, _statusFor(CallStatus.connectError));

        callController.add(_cs(CallStatus.ready));
        expect(cubit.state.status, _statusFor(CallStatus.ready));

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
