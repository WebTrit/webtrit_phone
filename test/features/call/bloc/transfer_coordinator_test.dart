import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/features/call/models/models.dart';
import 'package:webtrit_phone/models/models.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeLinesState extends Fake implements LinesState {}

class _FakeCallkeepHandle extends Fake implements CallkeepHandle {}

final _fakeNewCall = (
  direction: CallDirection.incoming,
  number: '0',
  video: false,
  username: null,
  createdTime: DateTime.utc(2024),
  acceptedTime: null,
  hungUpTime: null,
);

// ---------------------------------------------------------------------------
// Transfer-specific callkeep mock
// ---------------------------------------------------------------------------

MockCallkeep _transferCallkeepMock() {
  final mock = MockCallkeep();
  when(() => mock.setDelegate(any())).thenReturn(null);
  when(
    () => mock.reportNewIncomingCall(
      any(),
      any(),
      displayName: any(named: 'displayName'),
      hasVideo: any(named: 'hasVideo'),
    ),
  ).thenAnswer((_) async => null);
  when(() => mock.reportEndCall(any(), any(), any())).thenAnswer((_) async {});
  when(() => mock.setHeld(any(), onHold: any(named: 'onHold'))).thenAnswer((_) async => null);
  when(() => mock.reportUpdateCall(any(), proximityEnabled: any(named: 'proximityEnabled'))).thenAnswer((_) async {});
  when(
    () => mock.startCall(
      any(),
      any(),
      displayNameOrContactIdentifier: any(named: 'displayNameOrContactIdentifier'),
      hasVideo: any(named: 'hasVideo'),
      proximityEnabled: any(named: 'proximityEnabled'),
    ),
  ).thenAnswer((_) async => null);
  return mock;
}

// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(_FakeLinesState());
    registerFallbackValue(CallkeepSignalingStatus.disconnect);
    registerFallbackValue(_FakeCallkeepHandle());
    registerFallbackValue(CallkeepEndCallReason.remoteEnded);
    registerFallbackValue(_fakeNewCall);
  });

  // -------------------------------------------------------------------------
  // Blind transfer
  // -------------------------------------------------------------------------

  group('blind transfer', () {
    test('blindTransferInitiated puts call on hold and marks BlindTransferInitiated', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.connected);

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        verify(() => mockCallkeep.setHeld('call-1', onHold: true)).called(1);

        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.transfer, isA<BlindTransferInitiated>());
        expect(bloc.state.minimized, isTrue);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('blindTransferSubmitted with a new number transitions transfer to BlindTransferTransferSubmitted', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '999'));
        async.flushMicrotasks();

        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.transfer, isA<BlindTransferTransferSubmitted>());
        expect(bloc.state.minimized, isFalse);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('blindTransferSubmitted transitions state even when signaling client is null', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        // Drop the signaling connection before submitting.
        factory.client!.simulateDisconnect();
        async.flushMicrotasks();

        // Submit blind transfer — signalingModule.signalingClient is null,
        // the execute() call is skipped but state should still transition.
        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '999'));
        async.flushMicrotasks();

        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.transfer, isA<BlindTransferTransferSubmitted>());

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('blindTransferSubmitted restores speaker when speakerOnBeforeMinimize is true', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        // Inject a speaker as the current audio device so speakerOnBeforeMinimize is captured.
        bloc.performAudioDevicesUpdate('call-1', [CallkeepAudioDevice(type: CallkeepAudioDeviceType.speaker)]);
        bloc.performAudioDeviceSet('call-1', CallkeepAudioDevice(type: CallkeepAudioDeviceType.speaker));
        async.flushMicrotasks();

        expect(bloc.state.audioDevice?.type, CallAudioDeviceType.speaker);

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        final callAfterInitiate = bloc.state.retrieveActiveCall('call-1');
        expect(callAfterInitiate?.speakerOnBeforeMinimize, isTrue);

        // After submit the speaker should be restored.
        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '999'));
        async.flushMicrotasks();

        expect(bloc.state.audioDevice?.type, CallAudioDeviceType.speaker);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('blindTransferSubmitted when target is already in active calls submits warning notification', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final notifications = <Notification>[];
        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          signalingClientFactory: factory.call,
          capturedNotifications: notifications,
        );

        bringOnlineWithHandshake(async, bloc, factory, linesCount: 2);

        // First call (caller number: '123')
        simulateIncoming(async, factory, callId: 'call-1', caller: '123');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        // Second call (caller number: '456')
        simulateIncoming(async, factory, callId: 'call-2', line: 1, caller: '456');
        factory.client!.simulateEvent(const AcceptedEvent(line: 1, callId: 'call-2'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(2));

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        // Attempt to transfer to a number already in active calls
        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '456'));
        async.flushMicrotasks();

        expect(notifications, contains(isA<ActiveLineBlindTransferWarningNotification>()));

        // Transfer state must remain unchanged (still BlindTransferInitiated)
        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.transfer, isA<BlindTransferInitiated>());

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Attended transfer
  // -------------------------------------------------------------------------

  group('attended transfer', () {
    test('attendedTransferInitiated puts call on hold and sets minimized to true', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.connected);

        bloc.add(CallControlEvent.attendedTransferInitiated('call-1'));
        async.flushMicrotasks();

        verify(() => mockCallkeep.setHeld('call-1', onHold: true)).called(1);
        expect(bloc.state.minimized, isTrue);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('attendedTransferSubmitted transitions transfer to AttendedTransferTransferSubmitted', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory, linesCount: 2);

        // First call — the referor
        simulateIncoming(async, factory, callId: 'call-1', caller: '100');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        // Second call — the replace target
        simulateIncoming(async, factory, callId: 'call-2', line: 1, caller: '200');
        factory.client!.simulateEvent(const AcceptedEvent(line: 1, callId: 'call-2'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(2));

        final referorCall = bloc.state.retrieveActiveCall('call-1')!;
        final replaceCall = bloc.state.retrieveActiveCall('call-2')!;

        bloc.add(CallControlEvent.attendedTransferSubmitted(referorCall: referorCall, replaceCall: replaceCall));
        async.flushMicrotasks();

        final updatedReferor = bloc.state.retrieveActiveCall('call-1');
        expect(updatedReferor?.transfer, isA<AttendedTransferTransferSubmitted>());

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('attendedRequestDeclined clears the transfer field on the call', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.attendedTransferInitiated('call-1'));
        async.flushMicrotasks();

        bloc.add(const CallControlEvent.attendedRequestDeclined(callId: 'call-1', referId: 'refer-abc'));
        async.flushMicrotasks();

        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.transfer, isNull);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // attendedRequestApproved
  // -------------------------------------------------------------------------

  group('attendedRequestApproved', () {
    test('when startCall succeeds a new outgoing ActiveCall is added to state', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(1));

        bloc.add(const CallControlEvent.attendedRequestApproved(referId: 'refer-xyz', referTo: '777'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(2));

        final newCall = bloc.state.activeCalls.firstWhere((c) => c.direction == CallDirection.outgoing);
        expect(newCall.handle.value, '777');
        expect(newCall.fromReferId, 'refer-xyz');

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('new outgoing ActiveCall has processingStatus outgoingCreatedFromRefer', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(const CallControlEvent.attendedRequestApproved(referId: 'refer-xyz', referTo: '777'));
        async.flushMicrotasks();

        final newCall = bloc.state.activeCalls.firstWhere((c) => c.direction == CallDirection.outgoing);
        expect(newCall.processingStatus, CallProcessingStatus.outgoingCreatedFromRefer);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Signaling request verification
  // -------------------------------------------------------------------------

  group('signaling requests', () {
    test('blindTransferSubmitted sends TransferRequest with correct number', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1', caller: '100');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        factory.client!.executedRequests.clear();

        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '999'));
        async.flushMicrotasks();

        final transferRequests = factory.client!.executedRequests.whereType<TransferRequest>().toList();
        expect(transferRequests, hasLength(1));
        expect(transferRequests.first.number, '999');

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('blindTransferSubmitted does not send TransferRequest when number is in activeCalls', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory, linesCount: 2);
        simulateIncoming(async, factory, callId: 'call-1', caller: '123');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        simulateIncoming(async, factory, callId: 'call-2', line: 1, caller: '456');
        factory.client!.simulateEvent(const AcceptedEvent(line: 1, callId: 'call-2'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.blindTransferInitiated('call-1'));
        async.flushMicrotasks();

        factory.client!.executedRequests.clear();

        bloc.add(const CallControlEvent.blindTransferSubmitted(number: '456'));
        async.flushMicrotasks();

        expect(factory.client!.executedRequests.whereType<TransferRequest>(), isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('attendedTransferSubmitted sends TransferRequest with replaceCallId', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory, linesCount: 2);
        simulateIncoming(async, factory, callId: 'call-1', caller: '100');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        simulateIncoming(async, factory, callId: 'call-2', line: 1, caller: '200');
        factory.client!.simulateEvent(const AcceptedEvent(line: 1, callId: 'call-2'));
        async.flushMicrotasks();

        final referorCall = bloc.state.retrieveActiveCall('call-1')!;
        final replaceCall = bloc.state.retrieveActiveCall('call-2')!;

        factory.client!.executedRequests.clear();

        bloc.add(CallControlEvent.attendedTransferSubmitted(referorCall: referorCall, replaceCall: replaceCall));
        async.flushMicrotasks();

        final transferRequests = factory.client!.executedRequests.whereType<TransferRequest>().toList();
        expect(transferRequests, hasLength(1));
        expect(transferRequests.first.replaceCallId, 'call-2');

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('attendedRequestDeclined sends DeclineRequest with correct referId', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _transferCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory, callId: 'call-1');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        bloc.add(CallControlEvent.attendedTransferInitiated('call-1'));
        async.flushMicrotasks();

        factory.client!.executedRequests.clear();

        bloc.add(const CallControlEvent.attendedRequestDeclined(callId: 'call-1', referId: 'refer-abc'));
        async.flushMicrotasks();

        final declineRequests = factory.client!.executedRequests.whereType<DeclineRequest>().toList();
        expect(declineRequests, hasLength(1));
        expect(declineRequests.first.referId, 'refer-abc');

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });
}
