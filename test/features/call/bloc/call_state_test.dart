import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/models/models.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _kHandle = CallkeepHandle.number('+380991234567');

ActiveCall _makeCall({
  String callId = 'call-1',
  CallDirection direction = CallDirection.incoming,
  int? line = 0,
  bool video = false,
  CallProcessingStatus processingStatus = CallProcessingStatus.connected,
  bool held = false,
  bool muted = false,
  DateTime? acceptedTime,
  DateTime? hungUpTime,
  Transfer? transfer,
  CallkeepHandle handle = _kHandle,
  String? displayName,
}) {
  return ActiveCall(
    callId: callId,
    direction: direction,
    line: line,
    handle: handle,
    createdTime: DateTime(2024),
    video: video,
    processingStatus: processingStatus,
    held: held,
    muted: muted,
    acceptedTime: acceptedTime,
    hungUpTime: hungUpTime,
    transfer: transfer,
    displayName: displayName,
  );
}

// ---------------------------------------------------------------------------
// ActiveCall — direction
// ---------------------------------------------------------------------------

void main() {
  group('ActiveCall.isIncoming / isOutgoing', () {
    test('isIncoming is true for incoming direction', () {
      final call = _makeCall(direction: CallDirection.incoming);
      expect(call.isIncoming, isTrue);
      expect(call.isOutgoing, isFalse);
    });

    test('isOutgoing is true for outgoing direction', () {
      final call = _makeCall(direction: CallDirection.outgoing);
      expect(call.isOutgoing, isTrue);
      expect(call.isIncoming, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCall — acceptance / hangup state
  // ---------------------------------------------------------------------------

  group('ActiveCall.wasAccepted / wasHungUp', () {
    test('wasAccepted is false before answer', () {
      final call = _makeCall(acceptedTime: null);
      expect(call.wasAccepted, isFalse);
    });

    test('wasAccepted is true after answer', () {
      final call = _makeCall(acceptedTime: DateTime(2024));
      expect(call.wasAccepted, isTrue);
    });

    test('wasHungUp is false while call is active', () {
      final call = _makeCall(hungUpTime: null);
      expect(call.wasHungUp, isFalse);
    });

    test('wasHungUp is true after hangup', () {
      final call = _makeCall(hungUpTime: DateTime(2024));
      expect(call.wasHungUp, isTrue);
    });

    test('a new incoming call has neither accepted nor hung-up timestamps', () {
      final call = _makeCall(processingStatus: CallProcessingStatus.incomingFromOffer);
      expect(call.wasAccepted, isFalse);
      expect(call.wasHungUp, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCall — video / camera state
  // ---------------------------------------------------------------------------

  group('ActiveCall.isCameraActive', () {
    test('is false for voice call (video = false, no stream)', () {
      final call = _makeCall(video: false);
      expect(call.isCameraActive, isFalse);
    });

    test('is false for video call without a local video track', () {
      // localStream is null — hasLocalVideoTrack returns false
      final call = _makeCall(video: true);
      expect(call.hasLocalVideoTrack, isFalse);
      expect(call.isCameraActive, isFalse);
    });
  });

  group('ActiveCall.remoteVideo', () {
    test('falls back to the video flag when remoteStream is null', () {
      final voiceCall = _makeCall(video: false);
      expect(voiceCall.remoteVideo, isFalse);

      final videoCall = _makeCall(video: true);
      expect(videoCall.remoteVideo, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCall — mute / hold flags
  // ---------------------------------------------------------------------------

  group('ActiveCall.muted / held', () {
    test('fresh call is not muted and not held', () {
      final call = _makeCall();
      expect(call.muted, isFalse);
      expect(call.held, isFalse);
    });

    test('muted call is reflected in the flag', () {
      final call = _makeCall(muted: true);
      expect(call.muted, isTrue);
    });

    test('held call is reflected in the flag', () {
      final call = _makeCall(held: true);
      expect(call.held, isTrue);
    });

    test('muted and held can be true simultaneously', () {
      final call = _makeCall(muted: true, held: true);
      expect(call.muted, isTrue);
      expect(call.held, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCall — processing status lifecycle: incoming flow
  // ---------------------------------------------------------------------------

  group('ActiveCall incoming lifecycle statuses', () {
    final incomingStates = [
      CallProcessingStatus.incomingFromPush,
      CallProcessingStatus.incomingFromOffer,
      CallProcessingStatus.incomingSubmittedAnswer,
      CallProcessingStatus.incomingPerformingStarted,
      CallProcessingStatus.incomingInitializingMedia,
      CallProcessingStatus.incomingAnswering,
    ];

    for (final status in incomingStates) {
      test('status $status is considered pre-connected (not connected)', () {
        final call = _makeCall(processingStatus: status);
        expect(call.processingStatus, equals(status));
        expect(call.processingStatus == CallProcessingStatus.connected, isFalse);
      });
    }

    test('connected status is set after answer exchange', () {
      final call = _makeCall(processingStatus: CallProcessingStatus.connected);
      expect(call.processingStatus, CallProcessingStatus.connected);
    });

    test('disconnecting status signals teardown phase', () {
      final call = _makeCall(processingStatus: CallProcessingStatus.disconnecting);
      expect(call.processingStatus, CallProcessingStatus.disconnecting);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCall — processing status lifecycle: outgoing flow
  // ---------------------------------------------------------------------------

  group('ActiveCall outgoing lifecycle statuses', () {
    final outgoingStates = [
      CallProcessingStatus.outgoingCreated,
      CallProcessingStatus.outgoingCreatedFromRefer,
      CallProcessingStatus.outgoingConnectingToSignaling,
      CallProcessingStatus.outgoingInitializingMedia,
      CallProcessingStatus.outgoingOfferPreparing,
      CallProcessingStatus.outgoingOfferSent,
      CallProcessingStatus.outgoingRinging,
    ];

    for (final status in outgoingStates) {
      test('status $status is considered pre-connected (not connected)', () {
        final call = _makeCall(direction: CallDirection.outgoing, processingStatus: status);
        expect(call.processingStatus, equals(status));
        expect(call.processingStatus == CallProcessingStatus.connected, isFalse);
      });
    }
  });

  // ---------------------------------------------------------------------------
  // Transfer state machine
  // ---------------------------------------------------------------------------

  group('Transfer state machine', () {
    test('BlindTransferInitiated marks the intent to transfer', () {
      final call = _makeCall(transfer: const Transfer.blindTransferInitiated());
      expect(call.transfer, isA<BlindTransferInitiated>());
    });

    test('BlindTransferTransferSubmitted holds the target number', () {
      final call = _makeCall(transfer: const Transfer.blindTransferTransferSubmitted(toNumber: '+1234567890'));
      final transfer = call.transfer as BlindTransferTransferSubmitted;
      expect(transfer.toNumber, '+1234567890');
    });

    test('AttendedTransferTransferSubmitted holds the replace call id', () {
      final call = _makeCall(transfer: const Transfer.attendedTransferTransferSubmitted(replaceCallId: 'replace-1'));
      final transfer = call.transfer as AttendedTransferTransferSubmitted;
      expect(transfer.replaceCallId, 'replace-1');
    });

    test('Transfering distinguishes blind vs attended origin', () {
      final blind = _makeCall(
        transfer: const Transfer.transfering(fromAttendedTransfer: false, fromBlindTransfer: true),
      );
      final attended = _makeCall(
        transfer: const Transfer.transfering(fromAttendedTransfer: true, fromBlindTransfer: false),
      );

      expect((blind.transfer as Transfering).fromBlindTransfer, isTrue);
      expect((attended.transfer as Transfering).fromAttendedTransfer, isTrue);
    });

    test('AttendedTransferConfirmationRequested carries refer metadata', () {
      const transfer = Transfer.attendedTransferConfirmationRequested(
        referId: 'ref-1',
        referTo: '+380991111111',
        referredBy: '+380992222222',
      );
      final call = _makeCall(transfer: transfer);
      final t = call.transfer as AttendedTransferConfirmationRequested;
      expect(t.referId, 'ref-1');
      expect(t.referTo, '+380991111111');
      expect(t.referredBy, '+380992222222');
    });

    test('InviteToAttendedTransfer carries replace and referredBy info', () {
      const transfer = Transfer.inviteToAttendedTransfer(replaceCallId: 'replace-1', referredBy: '+380993333333');
      final call = _makeCall(transfer: transfer);
      final t = call.transfer as InviteToAttendedTransfer;
      expect(t.replaceCallId, 'replace-1');
      expect(t.referredBy, '+380993333333');
    });

    test('call without transfer has null transfer field', () {
      final call = _makeCall();
      expect(call.transfer, isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCallIterableExtension — current
  // ---------------------------------------------------------------------------

  group('ActiveCallIterableExtension.current', () {
    test('returns the only call when one call exists', () {
      final call = _makeCall(callId: 'c1');
      expect([call].current, same(call));
    });

    test('returns the last non-held call when multiple calls exist', () {
      final held = _makeCall(callId: 'c1', held: true);
      final active = _makeCall(callId: 'c2', held: false);
      expect([held, active].current, same(active));
    });

    test('returns the last call when all calls are held', () {
      final hold1 = _makeCall(callId: 'c1', held: true);
      final hold2 = _makeCall(callId: 'c2', held: true);
      expect([hold1, hold2].current, same(hold2));
    });

    test('ignores earlier active calls and returns last non-held', () {
      final active1 = _makeCall(callId: 'c1', held: false);
      final active2 = _makeCall(callId: 'c2', held: false);
      // last non-held is active2
      expect([active1, active2].current, same(active2));
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCallIterableExtension — nonCurrent
  // ---------------------------------------------------------------------------

  group('ActiveCallIterableExtension.nonCurrent', () {
    test('returns empty list for a single call', () {
      final call = _makeCall(callId: 'c1');
      expect([call].nonCurrent, isEmpty);
    });

    test('returns all calls except current', () {
      final held = _makeCall(callId: 'c1', held: true);
      final active = _makeCall(callId: 'c2', held: false);
      expect([held, active].nonCurrent, equals([held]));
    });
  });

  // ---------------------------------------------------------------------------
  // ActiveCallIterableExtension — blindTransferInitiated
  // ---------------------------------------------------------------------------

  group('ActiveCallIterableExtension.blindTransferInitiated', () {
    test('returns null when no call has BlindTransferInitiated', () {
      final calls = [_makeCall(callId: 'c1'), _makeCall(callId: 'c2')];
      expect(calls.blindTransferInitiated, isNull);
    });

    test('returns the call with BlindTransferInitiated transfer', () {
      final regular = _makeCall(callId: 'c1');
      final withTransfer = _makeCall(callId: 'c2', transfer: const Transfer.blindTransferInitiated());
      final calls = [regular, withTransfer];
      expect(calls.blindTransferInitiated, same(withTransfer));
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — display
  // ---------------------------------------------------------------------------

  group('CallState.display', () {
    test('none — no active calls and minimized is null', () {
      const state = CallState();
      expect(state.display, CallDisplay.none);
    });

    test('noneScreen — no active calls and minimized is false (call screen visible but empty)', () {
      const state = CallState(minimized: false);
      expect(state.display, CallDisplay.noneScreen);
    });

    test('screen — active calls and minimized is not true', () {
      final call = _makeCall();
      final state = CallState(activeCalls: [call]);
      expect(state.display, CallDisplay.screen);
    });

    test('overlay — active calls and minimized is true', () {
      final call = _makeCall();
      final state = CallState(activeCalls: [call], minimized: true);
      expect(state.display, CallDisplay.overlay);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — isActive
  // ---------------------------------------------------------------------------

  group('CallState.isActive', () {
    test('false when no calls', () {
      const state = CallState();
      expect(state.isActive, isFalse);
    });

    test('true when at least one call is present', () {
      final state = CallState(activeCalls: [_makeCall()]);
      expect(state.isActive, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — isVoiceChat
  // ---------------------------------------------------------------------------

  group('CallState.isVoiceChat', () {
    test('true when current call is audio-only', () {
      final state = CallState(activeCalls: [_makeCall(video: false)]);
      expect(state.isVoiceChat, isTrue);
    });

    test('false when current call is a video call', () {
      final state = CallState(activeCalls: [_makeCall(video: true)]);
      expect(state.isVoiceChat, isFalse);
    });

    test('true when active call is held (voice) and the non-held current is voice', () {
      final held = _makeCall(callId: 'c1', video: false, held: true);
      final active = _makeCall(callId: 'c2', video: false, held: false);
      final state = CallState(activeCalls: [held, active]);
      expect(state.isVoiceChat, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — shouldListenToProximity
  // ---------------------------------------------------------------------------

  group('CallState.shouldListenToProximity', () {
    test('true when active voice call and not minimized', () {
      final state = CallState(activeCalls: [_makeCall(video: false)]);
      expect(state.shouldListenToProximity, isTrue);
    });

    test('false when no active calls', () {
      const state = CallState();
      expect(state.shouldListenToProximity, isFalse);
    });

    test('false when call is a video call', () {
      final state = CallState(activeCalls: [_makeCall(video: true)]);
      expect(state.shouldListenToProximity, isFalse);
    });

    test('false when call screen is minimized (overlay)', () {
      final state = CallState(activeCalls: [_makeCall(video: false)], minimized: true);
      expect(state.shouldListenToProximity, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — isBlingTransferInitiated
  // ---------------------------------------------------------------------------

  group('CallState.isBlingTransferInitiated', () {
    test('false when no call has a blind transfer initiated', () {
      final state = CallState(activeCalls: [_makeCall()]);
      expect(state.isBlingTransferInitiated, isFalse);
    });

    test('true when at least one call has BlindTransferInitiated', () {
      final call = _makeCall(transfer: const Transfer.blindTransferInitiated());
      final state = CallState(activeCalls: [call]);
      expect(state.isBlingTransferInitiated, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — retrieveIdleLine
  // ---------------------------------------------------------------------------

  group('CallState.retrieveIdleLine', () {
    test('returns null when linesCount is 0', () {
      const state = CallState(linesCount: 0);
      expect(state.retrieveIdleLine(), isNull);
    });

    test('returns line 0 when two lines configured and none busy', () {
      const state = CallState(linesCount: 2);
      expect(state.retrieveIdleLine(), 0);
    });

    test('returns line 1 when line 0 is occupied', () {
      final call = _makeCall(line: 0);
      final state = CallState(linesCount: 2, activeCalls: [call]);
      expect(state.retrieveIdleLine(), 1);
    });

    test('returns null when all lines are occupied', () {
      final call0 = _makeCall(callId: 'c0', line: 0);
      final call1 = _makeCall(callId: 'c1', line: 1);
      final state = CallState(linesCount: 2, activeCalls: [call0, call1]);
      expect(state.retrieveIdleLine(), isNull);
    });

    test('ignores null-line calls (guest calls) when computing idle lines', () {
      // Guest calls use null line — they should not block numbered lines.
      final guest = _makeCall(callId: 'guest', line: null);
      final state = CallState(linesCount: 1, activeCalls: [guest]);
      expect(state.retrieveIdleLine(), 0);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — retrieveActiveCall
  // ---------------------------------------------------------------------------

  group('CallState.retrieveActiveCall', () {
    test('returns null for an unknown callId', () {
      const state = CallState();
      expect(state.retrieveActiveCall('nonexistent'), isNull);
    });

    test('returns the matching call', () {
      final call = _makeCall(callId: 'target');
      final state = CallState(
        activeCalls: [
          _makeCall(callId: 'other'),
          call,
        ],
      );
      expect(state.retrieveActiveCall('target'), same(call));
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — copyWithPushActiveCall
  // ---------------------------------------------------------------------------

  group('CallState.copyWithPushActiveCall', () {
    test('appends the call to an empty list', () {
      const state = CallState();
      final call = _makeCall();
      final next = state.copyWithPushActiveCall(call);
      expect(next.activeCalls, [call]);
    });

    test('appends to an existing list without mutating the original', () {
      final existing = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [existing]);
      final incoming = _makeCall(callId: 'c2');
      final next = state.copyWithPushActiveCall(incoming);

      expect(next.activeCalls.length, 2);
      expect(state.activeCalls.length, 1); // original unchanged
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — copyWithPopActiveCall
  // ---------------------------------------------------------------------------

  group('CallState.copyWithPopActiveCall', () {
    test('removes the call with the given id', () {
      final call = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [call]);
      final next = state.copyWithPopActiveCall('c1');
      expect(next.activeCalls, isEmpty);
    });

    test('resets minimized to null when last call is removed', () {
      final call = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [call], minimized: false);
      final next = state.copyWithPopActiveCall('c1');
      expect(next.minimized, isNull);
    });

    test('preserves minimized when other calls still remain', () {
      final c1 = _makeCall(callId: 'c1');
      final c2 = _makeCall(callId: 'c2');
      final state = CallState(activeCalls: [c1, c2], minimized: false);
      final next = state.copyWithPopActiveCall('c1');
      expect(next.activeCalls, [c2]);
      expect(next.minimized, false);
    });

    test('does nothing when callId does not match any call', () {
      final call = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [call]);
      final next = state.copyWithPopActiveCall('ghost');
      expect(next.activeCalls, [call]);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — copyWithMappedActiveCall
  // ---------------------------------------------------------------------------

  group('CallState.copyWithMappedActiveCall', () {
    test('applies the mapper to the matching call only', () {
      final c1 = _makeCall(callId: 'c1', muted: false);
      final c2 = _makeCall(callId: 'c2', muted: false);
      final state = CallState(activeCalls: [c1, c2]);

      final next = state.copyWithMappedActiveCall('c1', (c) => c.copyWith(muted: true));

      final updated = next.activeCalls.firstWhere((c) => c.callId == 'c1');
      final untouched = next.activeCalls.firstWhere((c) => c.callId == 'c2');

      expect(updated.muted, isTrue);
      expect(untouched.muted, isFalse);
    });

    test('does not change the list when callId is not found', () {
      final c1 = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [c1]);
      final next = state.copyWithMappedActiveCall('ghost', (c) => c.copyWith(muted: true));
      expect(next.activeCalls.first.muted, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — copyWithMappedActiveCalls
  // ---------------------------------------------------------------------------

  group('CallState.copyWithMappedActiveCalls', () {
    test('applies the mapper to every call', () {
      final c1 = _makeCall(callId: 'c1', muted: false);
      final c2 = _makeCall(callId: 'c2', muted: false);
      final state = CallState(activeCalls: [c1, c2]);

      final next = state.copyWithMappedActiveCalls((c) => c.copyWith(muted: true));

      expect(next.activeCalls.every((c) => c.muted), isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState — performOnActiveCall
  // ---------------------------------------------------------------------------

  group('CallState.performOnActiveCall', () {
    test('returns null when callId is not found', () {
      const state = CallState();
      final result = state.performOnActiveCall<String>('missing', (c) => c.callId);
      expect(result, isNull);
    });

    test('invokes the callback with the matching call and returns its result', () {
      final call = _makeCall(callId: 'c1', displayName: 'Alice');
      final state = CallState(activeCalls: [call]);
      final result = state.performOnActiveCall<String>('c1', (c) => c.displayName!);
      expect(result, 'Alice');
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: incoming call full lifecycle
  // ---------------------------------------------------------------------------

  group('Scenario: incoming call lifecycle', () {
    test('push notification creates a call in incomingFromPush status', () {
      final call = _makeCall(
        direction: CallDirection.incoming,
        processingStatus: CallProcessingStatus.incomingFromPush,
      );
      final state = CallState(activeCalls: [call]);

      expect(state.isActive, isTrue);
      expect(state.activeCalls.first.processingStatus, CallProcessingStatus.incomingFromPush);
      expect(state.activeCalls.first.wasAccepted, isFalse);
    });

    test('signaling offer updates call to incomingFromOffer', () {
      final call = _makeCall(
        direction: CallDirection.incoming,
        processingStatus: CallProcessingStatus.incomingFromOffer,
      );
      final state = CallState(activeCalls: [call]);
      expect(state.activeCalls.first.processingStatus, CallProcessingStatus.incomingFromOffer);
    });

    test('user answers — call moves through answer phases to connected', () {
      const phases = [
        CallProcessingStatus.incomingSubmittedAnswer,
        CallProcessingStatus.incomingPerformingStarted,
        CallProcessingStatus.incomingInitializingMedia,
        CallProcessingStatus.incomingAnswering,
        CallProcessingStatus.connected,
      ];
      for (final phase in phases) {
        final call = _makeCall(processingStatus: phase);
        final state = CallState(activeCalls: [call]);
        expect(state.activeCalls.first.processingStatus, phase);
      }
    });

    test('connected incoming call has acceptedTime set', () {
      final call = _makeCall(processingStatus: CallProcessingStatus.connected, acceptedTime: DateTime(2024));
      expect(call.wasAccepted, isTrue);
    });

    test('call removed after hangup', () {
      final call = _makeCall(callId: 'inc-1');
      final state = CallState(activeCalls: [call]);
      final after = state.copyWithPopActiveCall('inc-1');
      expect(after.isActive, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: outgoing call full lifecycle
  // ---------------------------------------------------------------------------

  group('Scenario: outgoing call lifecycle', () {
    test('outgoing call starts in outgoingCreated', () {
      final call = _makeCall(
        callId: 'out-1',
        direction: CallDirection.outgoing,
        processingStatus: CallProcessingStatus.outgoingCreated,
      );
      final state = CallState(activeCalls: [call]);
      expect(state.isActive, isTrue);
      expect(state.activeCalls.first.processingStatus, CallProcessingStatus.outgoingCreated);
    });

    test('ringing phase is reached after offer is sent', () {
      final call = _makeCall(direction: CallDirection.outgoing, processingStatus: CallProcessingStatus.outgoingRinging);
      expect(call.processingStatus, CallProcessingStatus.outgoingRinging);
    });

    test('call reaches connected when remote accepts', () {
      final call = _makeCall(
        direction: CallDirection.outgoing,
        processingStatus: CallProcessingStatus.connected,
        acceptedTime: DateTime(2024),
      );
      expect(call.processingStatus, CallProcessingStatus.connected);
      expect(call.wasAccepted, isTrue);
    });

    test('outgoing call removed from state after hangup', () {
      final call = _makeCall(callId: 'out-1', direction: CallDirection.outgoing);
      final state = CallState(activeCalls: [call]);
      final after = state.copyWithPopActiveCall('out-1');
      expect(after.isActive, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: declined / unanswered call
  // ---------------------------------------------------------------------------

  group('Scenario: declined / unanswered call', () {
    test('unanswered call has no acceptedTime but has hungUpTime', () {
      final call = _makeCall(
        processingStatus: CallProcessingStatus.disconnecting,
        acceptedTime: null,
        hungUpTime: DateTime(2024),
      );
      expect(call.wasAccepted, isFalse);
      expect(call.wasHungUp, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: call on hold
  // ---------------------------------------------------------------------------

  group('Scenario: call hold / unhold', () {
    test('hold sets held flag on the call', () {
      final call = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [call]);
      final afterHold = state.copyWithMappedActiveCall('c1', (c) => c.copyWith(held: true));

      expect(afterHold.activeCalls.first.held, isTrue);
    });

    test('unhold clears held flag', () {
      final call = _makeCall(callId: 'c1', held: true);
      final state = CallState(activeCalls: [call]);
      final afterUnhold = state.copyWithMappedActiveCall('c1', (c) => c.copyWith(held: false));

      expect(afterUnhold.activeCalls.first.held, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: mute / unmute
  // ---------------------------------------------------------------------------

  group('Scenario: mute / unmute', () {
    test('mute sets the muted flag', () {
      final call = _makeCall(callId: 'c1', muted: false);
      final state = CallState(activeCalls: [call]);
      final muted = state.copyWithMappedActiveCall('c1', (c) => c.copyWith(muted: true));
      expect(muted.activeCalls.first.muted, isTrue);
    });

    test('unmute clears the muted flag', () {
      final call = _makeCall(callId: 'c1', muted: true);
      final state = CallState(activeCalls: [call]);
      final unmuted = state.copyWithMappedActiveCall('c1', (c) => c.copyWith(muted: false));
      expect(unmuted.activeCalls.first.muted, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: two simultaneous calls (one held, one active)
  // ---------------------------------------------------------------------------

  group('Scenario: two simultaneous calls', () {
    test('current returns the non-held call', () {
      final held = _makeCall(callId: 'held', held: true);
      final active = _makeCall(callId: 'active', held: false);
      final state = CallState(activeCalls: [held, active]);

      expect(state.activeCalls.current.callId, 'active');
      expect(state.activeCalls.nonCurrent.single.callId, 'held');
    });

    test('both calls are reflected in the state', () {
      final c1 = _makeCall(callId: 'c1');
      final c2 = _makeCall(callId: 'c2');
      final state = CallState(activeCalls: [c1, c2]);
      expect(state.activeCalls.length, 2);
      expect(state.isActive, isTrue);
    });

    test('removing one call leaves the other active', () {
      final c1 = _makeCall(callId: 'c1');
      final c2 = _makeCall(callId: 'c2');
      final state = CallState(activeCalls: [c1, c2]);
      final next = state.copyWithPopActiveCall('c1');

      expect(next.activeCalls.length, 1);
      expect(next.activeCalls.first.callId, 'c2');
      expect(next.isActive, isTrue);
    });

    test('proximity sensor is off when call is minimized', () {
      final call = _makeCall(video: false);
      final minimized = CallState(activeCalls: [call], minimized: true);
      expect(minimized.shouldListenToProximity, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: blind transfer flow in state
  // ---------------------------------------------------------------------------

  group('Scenario: blind transfer flow', () {
    test('step 1 — BlindTransferInitiated marks intent', () {
      final call = _makeCall(callId: 'c1', transfer: const Transfer.blindTransferInitiated());
      final state = CallState(activeCalls: [call]);
      expect(state.isBlingTransferInitiated, isTrue);
      expect(state.activeCalls.blindTransferInitiated?.callId, 'c1');
    });

    test('step 2 — BlindTransferTransferSubmitted records target number', () {
      final call = _makeCall(
        callId: 'c1',
        transfer: const Transfer.blindTransferTransferSubmitted(toNumber: '+1234567890'),
      );
      final state = CallState(activeCalls: [call]);
      expect(state.isBlingTransferInitiated, isFalse);
      final t = state.activeCalls.first.transfer as BlindTransferTransferSubmitted;
      expect(t.toNumber, '+1234567890');
    });

    test('step 3 — Transfering (blind) shows transfer in progress', () {
      final call = _makeCall(
        callId: 'c1',
        transfer: const Transfer.transfering(fromAttendedTransfer: false, fromBlindTransfer: true),
      );
      final state = CallState(activeCalls: [call]);
      final t = state.activeCalls.first.transfer as Transfering;
      expect(t.fromBlindTransfer, isTrue);
      expect(t.fromAttendedTransfer, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: attended transfer flow in state
  // ---------------------------------------------------------------------------

  group('Scenario: attended transfer flow', () {
    test('AttendedTransferTransferSubmitted contains replaceCallId', () {
      final call = _makeCall(
        callId: 'c1',
        transfer: const Transfer.attendedTransferTransferSubmitted(replaceCallId: 'replace-1'),
      );
      final t = call.transfer as AttendedTransferTransferSubmitted;
      expect(t.replaceCallId, 'replace-1');
    });

    test('AttendedTransferConfirmationRequested prompts user for decision', () {
      final call = _makeCall(
        callId: 'c1',
        transfer: const Transfer.attendedTransferConfirmationRequested(
          referId: 'ref-1',
          referTo: '+380991111111',
          referredBy: '+380992222222',
        ),
      );
      expect(call.transfer, isA<AttendedTransferConfirmationRequested>());
    });

    test('InviteToAttendedTransfer represents an incoming transfer invitation', () {
      final call = _makeCall(
        callId: 'c2',
        transfer: const Transfer.inviteToAttendedTransfer(replaceCallId: 'c1', referredBy: 'transferor'),
      );
      final t = call.transfer as InviteToAttendedTransfer;
      expect(t.replaceCallId, 'c1');
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: video call — camera toggle
  // ---------------------------------------------------------------------------

  group('Scenario: video call camera toggle', () {
    test('video flag false means audio-only call', () {
      final call = _makeCall(video: false);
      expect(call.isCameraActive, isFalse);
    });

    test('video flag true but no stream — camera not yet active', () {
      final call = _makeCall(video: true);
      // localStream is null -> hasLocalVideoTrack == false -> isCameraActive == false
      expect(call.hasLocalVideoTrack, isFalse);
      expect(call.isCameraActive, isFalse);
    });

    test('toggling video flag from false to true via copyWith', () {
      final call = _makeCall(video: false);
      final upgraded = call.copyWith(video: true);
      expect(upgraded.video, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: audio device state
  // ---------------------------------------------------------------------------

  group('CallState audio devices', () {
    test('audioDevice is null by default', () {
      const state = CallState();
      expect(state.audioDevice, isNull);
    });

    test('earpiece device is reflected in state', () {
      final earpiece = CallAudioDevice(type: CallAudioDeviceType.earpiece);
      final state = CallState(audioDevice: earpiece);
      expect(state.audioDevice?.type, CallAudioDeviceType.earpiece);
    });

    test('speaker device is reflected in state', () {
      final speaker = CallAudioDevice(type: CallAudioDeviceType.speaker);
      final state = CallState(audioDevice: speaker);
      expect(state.audioDevice?.type, CallAudioDeviceType.speaker);
    });

    test('availableAudioDevices onlyBuiltIn when only earpiece and speaker present', () {
      final List<CallAudioDevice> devices = [
        CallAudioDevice(type: CallAudioDeviceType.earpiece),
        CallAudioDevice(type: CallAudioDeviceType.speaker),
      ];
      expect(devices.onlyBuiltIn, isTrue);
    });

    test('availableAudioDevices onlyBuiltIn is false when bluetooth present', () {
      final List<CallAudioDevice> devices = [
        CallAudioDevice(type: CallAudioDeviceType.earpiece),
        CallAudioDevice(type: CallAudioDeviceType.bluetooth),
      ];
      expect(devices.onlyBuiltIn, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: app lifecycle changes — minimized state
  // ---------------------------------------------------------------------------

  group('CallState minimized / display transitions', () {
    test('minimized null + no calls = display none', () {
      const state = CallState(minimized: null);
      expect(state.display, CallDisplay.none);
    });

    test('screen opened (minimized = false) + no calls = noneScreen', () {
      const state = CallState(minimized: false);
      expect(state.display, CallDisplay.noneScreen);
    });

    test('call arrives while screen is open = display screen', () {
      final state = CallState(activeCalls: [_makeCall()], minimized: null);
      expect(state.display, CallDisplay.screen);
    });

    test('user minimizes active call = display overlay', () {
      final state = CallState(activeCalls: [_makeCall()], minimized: true);
      expect(state.display, CallDisplay.overlay);
    });

    test('last call ends while minimized — minimized resets to null', () {
      final call = _makeCall(callId: 'c1');
      final state = CallState(activeCalls: [call], minimized: true);
      final after = state.copyWithPopActiveCall('c1');
      expect(after.activeCalls, isEmpty);
      expect(after.minimized, isNull);
      expect(after.display, CallDisplay.none);
    });
  });

  // ---------------------------------------------------------------------------
  // CallServiceState — status derivation
  // ---------------------------------------------------------------------------

  group('CallServiceState.status', () {
    test('connectivityNone when network is unavailable', () {
      const s = CallServiceState(networkStatus: NetworkStatus.none);
      expect(s.status, CallStatus.connectivityNone);
    });

    test('connectError when last connect attempt failed', () {
      const s = CallServiceState(lastSignalingClientConnectError: 'timeout');
      expect(s.status, CallStatus.connectError);
    });

    test('inProgress when still connecting without errors', () {
      const s = CallServiceState(signalingClientStatus: SignalingClientStatus.connecting);
      expect(s.status, CallStatus.inProgress);
    });

    test('default CallServiceState results in inProgress status', () {
      const s = CallServiceState();
      expect(s.status, CallStatus.inProgress);
    });
  });

  // ---------------------------------------------------------------------------
  // Transfer — blind transfer Transfering state detection
  //
  // Mirrors the pattern-match logic in CallBloc.__onCallPerformEventEnded that
  // decides whether to skip the hangup request when a blind transfer is in the
  // Transfering state (server started to process it).
  // ---------------------------------------------------------------------------

  group('Transfer — isBlindTransferInTransferingState detection', () {
    // Replicates the exact switch used in __onCallPerformEventEnded.
    bool isBlindTransferInTransferingState(Transfer? transfer) {
      return switch (transfer) {
        Transfering(:final fromBlindTransfer) => fromBlindTransfer,
        _ => false,
      };
    }

    test('Transfering(fromBlindTransfer: true) is detected as blind transfer in Transfering state', () {
      const transfer = Transfer.transfering(fromBlindTransfer: true, fromAttendedTransfer: false);
      expect(isBlindTransferInTransferingState(transfer), isTrue);
    });

    test('Transfering(fromBlindTransfer: false) is not detected as blind transfer in Transfering state', () {
      const transfer = Transfer.transfering(fromBlindTransfer: false, fromAttendedTransfer: true);
      expect(isBlindTransferInTransferingState(transfer), isFalse);
    });

    test('BlindTransferTransferSubmitted is not yet in Transfering state', () {
      const transfer = Transfer.blindTransferTransferSubmitted(toNumber: '+1234567890');
      expect(isBlindTransferInTransferingState(transfer), isFalse);
    });

    test('BlindTransferInitiated is not in Transfering state', () {
      const transfer = Transfer.blindTransferInitiated();
      expect(isBlindTransferInTransferingState(transfer), isFalse);
    });

    test('null (no transfer in progress) is not in Transfering state', () {
      expect(isBlindTransferInTransferingState(null), isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // JsepValue — SDP media detection
  // ---------------------------------------------------------------------------

  group('JsepValue SDP parsing', () {
    const audioSdp = 'm=audio 9 UDP/TLS/RTP/SAVPF 111\r\n';
    const videoSdp = 'm=video 9 UDP/TLS/RTP/SAVPF 96\r\n';
    const disabledAudioSdp = 'm=audio 0 RTP/AVP 0\r\n';

    JsepValue makeJsep(String? sdp) => JsepValue({'type': 'offer', 'sdp': sdp});

    test('hasAudio returns true when SDP contains active audio section', () {
      expect(makeJsep(audioSdp).hasAudio, isTrue);
    });

    test('hasAudio returns false when audio section is disabled (port 0)', () {
      expect(makeJsep(disabledAudioSdp).hasAudio, isFalse);
    });

    test('hasVideo returns true when SDP contains video section', () {
      expect(makeJsep(videoSdp).hasVideo, isTrue);
    });

    test('hasVideo returns false when no video section', () {
      expect(makeJsep(audioSdp).hasVideo, isFalse);
    });

    test('hasAudio and hasVideo both true for combined SDP', () {
      final jsep = makeJsep('$audioSdp$videoSdp');
      expect(jsep.hasAudio, isTrue);
      expect(jsep.hasVideo, isTrue);
    });

    test('hasAudio and hasVideo false when SDP is null', () {
      expect(makeJsep(null).hasAudio, isFalse);
      expect(makeJsep(null).hasVideo, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // CallState.toLinesState
  // ---------------------------------------------------------------------------

  const kRegistered = CallServiceState(registration: Registration(status: RegistrationStatus.registered));

  group('CallState.toLinesState — pre-handshake', () {
    test('returns blank when linesCount is 0 and handshake not established', () {
      final state = CallState(linesCount: 0);
      expect(state.isHandshakeEstablished, isFalse);
      expect(state.toLinesState(), LinesState.blank());
      expect(state.toLinesState().isBlank, isTrue);
    });

    test('returns blank regardless of activeCalls before handshake', () {
      final state = CallState(linesCount: 0, activeCalls: [_makeCall(line: null)]);
      expect(state.toLinesState(), LinesState.blank());
    });
  });

  group('CallState.toLinesState — post-handshake with 0 main lines', () {
    test('returns non-blank with idle guest line when no calls', () {
      final state = CallState(linesCount: 0, callServiceState: kRegistered);
      final result = state.toLinesState();
      expect(result.isBlank, isFalse);
      expect(result.mainLines, isEmpty);
      expect(result.guestLine, LineState.idle());
    });

    test('returns guest line inUse when guest call is active (line == null)', () {
      final state = CallState(linesCount: 0, callServiceState: kRegistered, activeCalls: [_makeCall(line: null)]);
      final result = state.toLinesState();
      expect(result.mainLines, isEmpty);
      expect(result.guestLine, LineState.inUse(callId: 'call-1'));
    });
  });

  group('CallState.toLinesState — post-handshake with main lines', () {
    test('all lines idle when no active calls', () {
      final state = CallState(linesCount: 2, callServiceState: kRegistered);
      final result = state.toLinesState();
      expect(result.mainLines, [LineState.idle(), LineState.idle()]);
      expect(result.guestLine, LineState.idle());
    });

    test('line 0 inUse when call on line 0', () {
      final state = CallState(
        linesCount: 2,
        callServiceState: kRegistered,
        activeCalls: [_makeCall(callId: 'c1', line: 0)],
      );
      final result = state.toLinesState();
      expect(result.mainLines[0], LineState.inUse(callId: 'c1'));
      expect(result.mainLines[1], LineState.idle());
    });

    test('line 1 inUse when call on line 1', () {
      final state = CallState(
        linesCount: 2,
        callServiceState: kRegistered,
        activeCalls: [_makeCall(callId: 'c1', line: 1)],
      );
      final result = state.toLinesState();
      expect(result.mainLines[0], LineState.idle());
      expect(result.mainLines[1], LineState.inUse(callId: 'c1'));
    });

    test('all lines inUse when calls on every line', () {
      final state = CallState(
        linesCount: 2,
        callServiceState: kRegistered,
        activeCalls: [
          _makeCall(callId: 'c1', line: 0),
          _makeCall(callId: 'c2', line: 1),
        ],
      );
      final result = state.toLinesState();
      expect(result.mainLines, [LineState.inUse(callId: 'c1'), LineState.inUse(callId: 'c2')]);
    });

    test('guest line inUse when guest call present alongside main calls', () {
      final state = CallState(
        linesCount: 2,
        callServiceState: kRegistered,
        activeCalls: [
          _makeCall(callId: 'c1', line: 0),
          _makeCall(callId: 'c2', line: null),
        ],
      );
      final result = state.toLinesState();
      expect(result.mainLines[0], LineState.inUse(callId: 'c1'));
      expect(result.mainLines[1], LineState.idle());
      expect(result.guestLine, LineState.inUse(callId: 'c2'));
    });

    test('guest line idle when no guest call', () {
      final state = CallState(
        linesCount: 1,
        callServiceState: kRegistered,
        activeCalls: [_makeCall(callId: 'c1', line: 0)],
      );
      expect(state.toLinesState().guestLine, LineState.idle());
    });
  });

  // ---------------------------------------------------------------------------
  // Scenario: push → signaling line handoff (WT-1091)
  //
  // When an incoming call arrives via FCM push, CallBloc registers it with
  // line -1 (kUndefinedLine) as a placeholder. When the signaling WebSocket
  // later delivers the same call ID with a real line, the "call to myself"
  // guard must NOT fire — it should only fire when an already-lined call gets
  // a different real line (genuine call-to-myself or transfer-to-myself case).
  // ---------------------------------------------------------------------------

  group('Scenario: push → signaling line handoff (WT-1091)', () {
    const kUndefinedLine = -1;

    test('push-registered call has undefined line (-1)', () {
      final call = _makeCall(
        callId: 'push-call',
        line: kUndefinedLine,
        processingStatus: CallProcessingStatus.incomingFromPush,
      );
      expect(call.line, kUndefinedLine);
    });

    test('line-mismatch guard does NOT fire for push placeholder vs real line', () {
      // Simulates the condition in __onCallSignalingEventIncoming after the fix.
      // Push-registered call has line -1; signaling delivers line 0.
      final pushCall = _makeCall(callId: 'c1', line: kUndefinedLine);
      const signalingLine = 0;

      // Fixed condition: exclude kUndefinedLine from the mismatch check.
      final shouldDecline = pushCall.line != kUndefinedLine && pushCall.line != signalingLine;
      expect(shouldDecline, isFalse);
    });

    test('line-mismatch guard DOES fire when both lines are real and different', () {
      // Call already has a real line (0); signaling brings a new real line (1)
      // → this is the genuine "call to myself" scenario.
      final existingCall = _makeCall(callId: 'c1', line: 0);
      const signalingLine = 1;

      final shouldDecline = existingCall.line != kUndefinedLine && existingCall.line != signalingLine;
      expect(shouldDecline, isTrue);
    });

    test('line-mismatch guard does not fire when lines match', () {
      final existingCall = _makeCall(callId: 'c1', line: 0);
      const signalingLine = 0;

      final shouldDecline = existingCall.line != kUndefinedLine && existingCall.line != signalingLine;
      expect(shouldDecline, isFalse);
    });

    test('copyWith updates push-placeholder line to real line from signaling', () {
      final pushCall = _makeCall(
        callId: 'c1',
        line: kUndefinedLine,
        processingStatus: CallProcessingStatus.incomingFromPush,
      );
      final state = CallState(activeCalls: [pushCall]);

      // Signaling arrives with real line 0 — CallBloc calls copyWith.
      final updated = state.copyWithMappedActiveCall(
        'c1',
        (c) => c.copyWith(line: 0, processingStatus: CallProcessingStatus.incomingFromOffer),
      );

      final call = updated.activeCalls.first;
      expect(call.line, 0);
      expect(call.processingStatus, CallProcessingStatus.incomingFromOffer);
    });
  });
  // ---------------------------------------------------------------------------
  // CallState.callsToTerminate — handshake reconciliation (WT-1083)
  // ---------------------------------------------------------------------------

  group('CallState.callsToTerminate', () {
    test('terminates call absent from handshake lines', () {
      final call = _makeCall(callId: 'c1', processingStatus: CallProcessingStatus.connected);
      final state = CallState(activeCalls: [call]);
      expect(state.callsToTerminate({}), ['c1']);
    });

    test('keeps call that is present in handshake lines', () {
      final call = _makeCall(callId: 'c1', processingStatus: CallProcessingStatus.connected);
      final state = CallState(activeCalls: [call]);
      expect(state.callsToTerminate({'c1'}), isEmpty);
    });

    test('keeps outgoing call with isPreOfferSent status absent from handshake', () {
      for (final status in [
        CallProcessingStatus.outgoingCreated,
        CallProcessingStatus.outgoingCreatedFromRefer,
        CallProcessingStatus.outgoingConnectingToSignaling,
        CallProcessingStatus.outgoingInitializingMedia,
        CallProcessingStatus.outgoingOfferPreparing,
      ]) {
        final call = _makeCall(callId: 'c1', direction: CallDirection.outgoing, processingStatus: status);
        final state = CallState(activeCalls: [call]);
        expect(state.callsToTerminate({}), isEmpty, reason: 'should skip $status');
      }
    });

    test('terminates outgoing call at outgoingOfferSent absent from handshake', () {
      final call = _makeCall(
        callId: 'c1',
        direction: CallDirection.outgoing,
        processingStatus: CallProcessingStatus.outgoingOfferSent,
      );
      final state = CallState(activeCalls: [call]);
      expect(state.callsToTerminate({}), ['c1']);
    });

    test('terminates outgoing call at outgoingRinging absent from handshake', () {
      final call = _makeCall(
        callId: 'c1',
        direction: CallDirection.outgoing,
        processingStatus: CallProcessingStatus.outgoingRinging,
      );
      final state = CallState(activeCalls: [call]);
      expect(state.callsToTerminate({}), ['c1']);
    });

    test('keeps outgoing isPreOfferSent call even if other calls are terminated', () {
      final inFlight = _makeCall(
        callId: 'in-flight',
        direction: CallDirection.outgoing,
        processingStatus: CallProcessingStatus.outgoingOfferPreparing,
      );
      final dead = _makeCall(callId: 'dead', processingStatus: CallProcessingStatus.connected);
      final state = CallState(activeCalls: [inFlight, dead]);
      expect(state.callsToTerminate({}), ['dead']);
    });

    test('returns empty when all calls are in handshake lines', () {
      final calls = [_makeCall(callId: 'c1'), _makeCall(callId: 'c2')];
      final state = CallState(activeCalls: calls);
      expect(state.callsToTerminate({'c1', 'c2'}), isEmpty);
    });
  });
}
