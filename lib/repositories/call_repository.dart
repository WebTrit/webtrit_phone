import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:janus_client/janus_client.dart';
import 'package:janus_client/janus_videocall_plugin.dart';

class CallRepository {
  static int _createCounter = 0;

  final Logger _logger;

  Gateway _gateway;
  Session _session;
  VideoCallPlugin _videoCallPlugin;

  String _registeredUsername;

  StreamController<IncomingCallEvent> _incomingCallStreamController;
  StreamController<AcceptedEvent> _acceptedStreamController;
  StreamController<HangupEvent> _hangupStreamController;

  bool get isAttached => _videoCallPlugin != null;

  CallRepository() : _logger = Logger('CallRepository-$_createCounter') {
    _createCounter++;
  }

  Future<void> attach() async {
    _incomingCallStreamController = StreamController.broadcast();
    _acceptedStreamController = StreamController.broadcast();
    _hangupStreamController = StreamController.broadcast();

    _gateway = await Gateway.connect('wss://demo.webtrit.com:8989/', _onErrorCallback, _onDoneCallback);
    _gateway.listen();

    _session = Session(_gateway, _onSessionTimeoutCallback);
    await _session.create();

    _videoCallPlugin = VideoCallPlugin(_session);
    await _videoCallPlugin.attach(
      _onIncomingCallCallback,
      _onAcceptedCallCallback,
      _onHangupCallback,
    );
  }

  Future<void> detach() async {
    await _videoCallPlugin.detach();
    _videoCallPlugin = null;

    await _session.destroy();
    _session = null;

    await _gateway.close();
    _gateway = null;

    await _incomingCallStreamController.close();
    _incomingCallStreamController = null;
    await _acceptedStreamController.close();
    _acceptedStreamController = null;
    await _hangupStreamController.close();
    _hangupStreamController = null;

    _registeredUsername = null;
  }

  Stream<IncomingCallEvent> get onIncomingCall => _incomingCallStreamController.stream;

  Stream<AcceptedEvent> get onAccepted => _acceptedStreamController.stream;

  Stream<HangupEvent> get onHangup => _hangupStreamController.stream;

  Future<void> sendTrickle(Map<String, dynamic> candidate) async {
    await _videoCallPlugin.sendTrickle(candidate);
  }

  Future<List<String>> list() async {
    return (await _videoCallPlugin.list())..remove(_registeredUsername);
  }

  Future<void> register(String username) async {
    await _videoCallPlugin.register(username);
    _registeredUsername = username;
  }

  Future<void> call(String username, Map<String, dynamic> jsepData) async {
    await _videoCallPlugin.call(username, jsepData);
  }

  Future<void> accept(Map<String, dynamic> jsepData) async {
    await _videoCallPlugin.accept(jsepData);
  }

  Future<void> set({
    bool audio,
    bool video,
    int bitrate,
    bool record,
    String filename,
    int substream,
    int temporal,
  }) async {
    await _videoCallPlugin.set(
      audio: audio,
      video: video,
      bitrate: bitrate,
      record: record,
      filename: filename,
      substream: substream,
      temporal: temporal,
    );
  }

  Future<String> hangup() {
    return _videoCallPlugin.hangup();
  }

  void _onErrorCallback(error, [StackTrace stackTrace]) {
    // TODO: add necessary logic
    _logger.severe('_onErrorCallback { error: $error, stackTrace: $stackTrace } / not implemented');
  }

  void _onDoneCallback() {
    // TODO: add necessary logic
    _logger.warning('_onDoneCallback / not implemented');
  }

  void _onSessionTimeoutCallback() {
    // TODO: add necessary logic
    _logger.warning('_onSessionTimeoutCallback / not implemented');
  }

  void _onIncomingCallCallback(String username, Map<String, dynamic> jsepData) {
    _incomingCallStreamController.add(IncomingCallEvent(username, jsepData));
  }

  void _onAcceptedCallCallback(String username, Map<String, dynamic> jsepData) {
    _acceptedStreamController.add(AcceptedEvent(username, jsepData));
  }

  void _onHangupCallback(String username, String reason) {
    _hangupStreamController.add(HangupEvent(username, reason));
  }
}

@immutable
class IncomingCallEvent {
  final String username;
  final Map<String, dynamic> jsepData;

  IncomingCallEvent(this.username, this.jsepData);
}

@immutable
class AcceptedEvent {
  final String username;
  final Map<String, dynamic> jsepData;

  AcceptedEvent(this.username, this.jsepData);
}

@immutable
class HangupEvent {
  final String username;
  final String reason;

  HangupEvent(this.username, this.reason);
}
