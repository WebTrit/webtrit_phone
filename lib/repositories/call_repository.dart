import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class CallRepository {
  static int _createCounter = 0;

  final Logger _logger;

  WebtritSignalingClient? _signalingClient;

  StreamController<IncomingCallEvent>? _incomingCallStreamController;
  StreamController<AnsweredEvent>? _acceptedStreamController;
  StreamController<HangupEvent>? _hangupStreamController;

  bool get isAttached => _signalingClient != null;

  CallRepository() : _logger = Logger('CallRepository-$_createCounter') {
    _createCounter++;
  }

  Future<void> attach() async {
    _incomingCallStreamController = StreamController.broadcast();
    _acceptedStreamController = StreamController.broadcast();
    _hangupStreamController = StreamController.broadcast();

    final token = await SecureStorage().readToken();
    if (token == null) {
      throw Exception('incorrect token');
    } else {
      _signalingClient = await WebtritSignalingClient.connect(EnvironmentConfig.WEBTRIT_SIGNALING_URL, token);

      _signalingClient!.listen(
        (event) {
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
        onDone: _onDoneCallback,
      );
    }
  }

  Future<void> detach() async {
    await _signalingClient!.close();
    _signalingClient = null;

    await _incomingCallStreamController!.close();
    _incomingCallStreamController = null;
    await _acceptedStreamController!.close();
    _acceptedStreamController = null;
    await _hangupStreamController!.close();
    _hangupStreamController = null;
  }

  Stream<IncomingCallEvent> get onIncomingCall => _incomingCallStreamController!.stream;

  Stream<AnsweredEvent> get onAccepted => _acceptedStreamController!.stream;

  Stream<HangupEvent> get onHangup => _hangupStreamController!.stream;

  Future<void> sendTrickle(Map<String, dynamic>? candidate) async {
    await _signalingClient!.send(TrickleCommand(candidate));
  }

  Future<List<String>> list() async {
    return []; // TODO remove
  }

  Future<void> register() async {
    await _signalingClient!.send(RegisterCommand());
  }

  Future<void> call(String? username, Map<String, dynamic> jsepData) async { // TODO rename username to number
    await _signalingClient!.send(CallCommand(number: username!, jsep: jsepData));
  }

  Future<void> accept(Map<String, dynamic> jsepData) async {
    await _signalingClient!.send(AcceptCommand(jsep: jsepData));
  }

  Future<void> hangup() {
    return _signalingClient!.send(HangupCommand());
  }

  void _onErrorCallback(error, [StackTrace? stackTrace]) {
    // TODO: add necessary logic
    _logger.severe('_onErrorCallback { error: $error, stackTrace: $stackTrace } / not implemented');
  }

  void _onDoneCallback() {
    // TODO: add necessary logic
    _logger.warning('_onDoneCallback / not implemented');
  }
}
