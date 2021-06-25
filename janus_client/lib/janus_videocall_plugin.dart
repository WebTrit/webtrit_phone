import 'dart:async';

import 'package:logging/logging.dart';

import 'janus_client.dart';

class VideoCallPlugin {
  static const package = 'janus.plugin.videocall';
  static int _createCounter = 0;

  final Session _session;
  final Logger _logger;

  late PluginHandle _handle;
  late void Function(String username, Map<String, dynamic>? jsepData) _onIncomingCall;
  late void Function(String username, Map<String, dynamic>? jsepData) _onAccepted;
  late void Function(String username, String? reason) _onHangup;

  VideoCallPlugin(this._session)
      : _logger = Logger('VideoCallPlugin-$_createCounter') {
    _createCounter++;
  }

  Future<void> attach(
    void Function(String username, Map<String, dynamic>? jsepData) onIncomingCall,
    void Function(String username, Map<String, dynamic>? jsepData) onAccepted,
    void Function(String username, String? reason) onHangup,
  ) async {
    _onIncomingCall = onIncomingCall;
    _onAccepted = onAccepted;
    _onHangup = onHangup;

    _handle = PluginHandle(
      package,
      _session,
      _onEventCallback,
      _onTrickle,
      _onWebrtcupCallback,
      _onMediaCallback,
      _onSlowlinkCallback,
      _onHangupCallback,
      _onDetachedCallback,
    );
    await _handle.attach();
  }

  Future<void> detach() {
    return _handle.detach();
  }

  Future<void> sendTrickle(Map<String, dynamic>? candidate) {
    return _handle.sendTrickle(candidate);
  }

  Future<List<String>> list() async {
    final bodyData = <String, dynamic>{
      'request': 'list',
    };

    final pluginData = await _handle.executeMessage(bodyData, null, false);

    return List<String>.from(pluginData['result']['list']);
  }

  Future<void> register(String username) async {
    final bodyData = <String, dynamic>{
      'request': 'register',
      'username': username,
    };

    final pluginData = await _handle.executeMessage(bodyData, null, false);

    if (pluginData['result']['event'] == 'registered' && pluginData['result']['username'] == username) {
      return;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> call(String? username, Map<String, dynamic> jsepData) async {
    final bodyData = <String, dynamic>{
      'request': 'call',
      'username': username,
    };

    final pluginData = await _handle.executeMessage(bodyData, jsepData, false);

    if (pluginData['result']['event'] == 'calling') {
      return;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> accept(Map<String, dynamic> jsepData) async {
    final bodyData = <String, dynamic>{
      'request': 'accept',
    };

    final pluginData = await _handle.executeMessage(bodyData, jsepData, false);

    if (pluginData['result']['event'] == 'accepted') {
      return;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<String?> hangup([String? reason]) async {
    final bodyData = <String, dynamic>{
      'request': 'hangup',
      if (reason != null) 'reason': reason,
    };

    final pluginData = await _handle.executeMessage(bodyData, null, false);

    if (pluginData['result']['event'] == 'hangup') {
      return pluginData['result']['reason'];
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> set({
    bool? audio,
    bool? video,
    int? bitrate,
    bool? record,
    String? filename,
    int? substream,
    int? temporal,
  }) async {
    final bodyData = <String, dynamic>{
      'request': 'set',
      if (audio != null) 'audio': audio,
      if (video != null) 'video': video,
      if (bitrate != null) 'bitrate': bitrate,
      if (record != null) 'record': record,
      if (filename != null) 'filename': filename,
      if (substream != null) 'substream': substream,
      if (temporal != null) 'temporal': temporal,
    };

    final pluginData = await _handle.executeMessage(bodyData, null, false);

    if (pluginData['result']['event'] == 'set') {
      return pluginData['result']['reason'];
    } else {
      throw JanusPluginHandleException();
    }
  }

  void _onEventCallback(Map<String, dynamic> pluginData, Map<String, dynamic>? jsepData) {
    switch (pluginData['result']['event']) {
      case 'hangup':
        _onHangup(pluginData['result']['username'], pluginData['result']['reason']);
        break;
      case 'accepted':
        _onAccepted(pluginData['result']['username'], jsepData);
        break;
      case 'incomingcall':
        _onIncomingCall(pluginData['result']['username'], jsepData);
        break;
    }
  }

  void _onTrickle(Map<String, dynamic>? candidate) {
    // TODO: add necessary logic
    _logger.warning('_onTrickle { candidate: $candidate } / not implemented');
  }

  void _onWebrtcupCallback() {
    // TODO: add necessary logic
    _logger.warning('_onWebrtcupCallback / not implemented');
  }

  void _onMediaCallback(String type, bool receiving, int seconds) {
    // TODO: add necessary logic
    _logger.warning('_onMediaCallback { type: $type, receiving: $receiving, seconds: $seconds } / not implemented');
  }

  void _onSlowlinkCallback(String media, bool uplink, int lost) {
    // TODO: add necessary logic
    _logger.warning('_onSlowlinkCallback { media: $media, uplink: $uplink, lost: $lost } / not implemented');
  }

  void _onHangupCallback(String reason) {
    // TODO: add necessary logic
    _logger.warning('_onHangupCallback { reason: $reason } / not implemented');
  }

  void _onDetachedCallback() {
    // TODO: add necessary logic
    _logger.warning('_onDetachedCallback / not implemented');
  }
}
