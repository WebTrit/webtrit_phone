import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/call.dart';

/// Thin dispatcher for outgoing-call intent.
///
/// Does two things:
///   - debounce rapid taps (kDebounceDuration);
///   - dispatch [CallControlEvent.started] / [CallControlEvent.blindTransferSubmitted]
///     to [CallBloc].
///
/// All gating (registration, signaling readiness, line availability,
/// fromNumber resolution, offline detection) lives in CallBloc, which owns
/// the wait + reconnect + line-allocation machinery.
class CallController {
  CallController({required this.callBloc, Logger? logger}) : _logger = logger ?? Logger('CallController');

  final CallBloc callBloc;
  final Logger _logger;
  DateTime? _createCallDebounceReleaseTime;

  /// Dispatches an outgoing call. The call screen opens immediately; CallBloc
  /// parks the call as `outgoingConnectingToSignaling` while waiting for
  /// signaling/handshake/registration/lines, then sends the INVITE (or fails
  /// with the proper notification after the timeout).
  void createCall({required String destination, String? displayName, bool video = false, String? fromNumber}) {
    if (_isCreateCallDebounceActive) return;
    _createCallDebounceReleaseTime = DateTime.now().add(kDebounceDuration);

    callBloc.add(
      CallControlEvent.started(number: destination, video: video, displayName: displayName, fromNumber: fromNumber),
    );
  }

  /// Returns true if the create-call debounce is active, preventing new calls.
  bool get _isCreateCallDebounceActive {
    if (_createCallDebounceReleaseTime == null) return false;
    return DateTime.now().isBefore(_createCallDebounceReleaseTime!);
  }

  /// Submits a blind transfer for the given destination.
  void submitTransfer(String destination) {
    _logger.info('Submitting blind transfer to $destination');
    callBloc.add(CallControlEvent.blindTransferSubmitted(number: destination));
  }

  void dispose() {}
}
