import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class DoneEvent {}

class CallRepository {
  static int _createCounter = 0;

  final Logger _logger;

  WebtritSignalingClient? _signalingClient;

  StreamController<IncomingCallEvent>? _incomingCallStreamController;
  StreamController<AnsweredEvent>? _acceptedStreamController;
  StreamController<HangupEvent>? _hangupStreamController;
  StreamController<DoneEvent>? _doneStreamController;

  bool get isAttached => _signalingClient != null;

  CallRepository() : _logger = Logger('CallRepository-$_createCounter') {
    _createCounter++;
  }

  String generateCallId() => WebtritSignalingClient.generateCallId();

  Future<void> attach() async {
    _incomingCallStreamController = StreamController.broadcast();
    _acceptedStreamController = StreamController.broadcast();
    _hangupStreamController = StreamController.broadcast();
    _doneStreamController = StreamController.broadcast();

    final token = await SecureStorage().readToken();
    if (token == null) {
      throw Exception('incorrect token');
    } else {
      final signalingClient = WebtritSignalingClient(
        EnvironmentConfig.SIGNALING_URL,
        token,
        onEvent: (event) {
          if (event is IncomingCallEvent) {
            _incomingCallStreamController!.add(event);
          } else if (event is AnsweredEvent) {
            _acceptedStreamController!.add(event);
          } else if (event is HangupEvent) {
            _hangupStreamController!.add(event);
          } else {
            _logger.warning('unhandled signaling event $event');
          }
        },
        onError: _onErrorCallback,
        onDisconnect: _onDisconnectCallback,
      );
      await signalingClient.connect(true);
      _signalingClient = signalingClient;
    }
  }

  Future<void> detach() async {
    await _signalingClient!.disconnect();
    _signalingClient = null;

    await _incomingCallStreamController!.close();
    _incomingCallStreamController = null;
    await _acceptedStreamController!.close();
    _acceptedStreamController = null;
    await _hangupStreamController!.close();
    _hangupStreamController = null;
    await _doneStreamController!.close();
    _doneStreamController = null;
  }

  Stream<IncomingCallEvent> get onIncomingCall => _incomingCallStreamController!.stream;

  Stream<AnsweredEvent> get onAccepted => _acceptedStreamController!.stream;

  Stream<HangupEvent> get onHangup => _hangupStreamController!.stream;

  Stream<DoneEvent> get onDone => _doneStreamController!.stream;

  Future<void> sendTrickle(String callId, Map<String, dynamic>? candidate) async {
    await _signalingClient!.execute(TrickleRequest(callId: callId, candidate: candidate));
  }

  Future<void> call(String callId, String? username, Map<String, dynamic> jsepData) async {
    // TODO rename username to number
    await _signalingClient!.execute(OutgoingCallRequest(callId: callId, number: username!, jsep: jsepData));
  }

  Future<void> decline(String callId) async {
    await _signalingClient!.execute(DeclineRequest(callId: callId));
  }

  Future<void> accept(String callId, Map<String, dynamic> jsepData) async {
    await _signalingClient!.execute(AcceptRequest(callId: callId, jsep: jsepData));
  }

  Future<void> hangup(String callId) {
    return _signalingClient!.execute(HangupRequest(callId: callId));
  }

  void _onErrorCallback(error, [StackTrace? stackTrace]) {
    // TODO: add necessary logic
    _logger.severe('_onErrorCallback { error: $error, stackTrace: $stackTrace } / not implemented');
  }

  void _onDisconnectCallback(int? code, String? reason) {
    _doneStreamController?.add(DoneEvent());
  }
}
