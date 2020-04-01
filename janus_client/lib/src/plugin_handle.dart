part of '../janus_client.dart';

class PluginHandle {
  final String pluginName;
  final Session _session;
  final void Function(Map<String, dynamic> data, Map<String, dynamic> jsep) _onEvent;
  final void Function(Map<String, dynamic> candidate) _onTrickle;
  final void Function() _onWebrtcup;
  final void Function(String type, bool receiving, int seconds) _onMedia;
  final void Function(String media, bool uplink, int lost) _onSlowlink;
  final void Function(String reason) _onHangup;
  final void Function() _onDetached;

  int _id;

  bool _detachedReceived = false;

  get id => _id;

  PluginHandle(
    this.pluginName,
    this._session,
    this._onEvent,
    this._onTrickle,
    this._onWebrtcup,
    this._onMedia,
    this._onSlowlink,
    this._onHangup,
    this._onDetached,
  );

  Future<void> attach() async {
    final requestMessage = <String, dynamic>{
      'janus': 'attach',
      'plugin': pluginName,
    };

    final responseMessage = await _session._executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'success') {
      _id = responseMessage['data']['id'];
      _session._attach(this);
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> detach() async {
    if (_detachedReceived) {
      return;
    }

    final requestMessage = <String, dynamic>{
      'janus': 'detach',
      'handle_id': _id,
    };

    final responseMessage = await _session._executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'success') {
      // NOTE: detach from session and nulling _id occur on "detached" event processing, which executing:
      //   _session._detach(this);
      //   _id = null;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> sendTrickle(Map<String, dynamic> candidate) async {
    final requestMessage = <String, dynamic>{
      'janus': 'trickle',
      'handle_id': _id,
      if (candidate != null)
        'candidate': candidate
      else
        'candidate': {
          'completed': true,
        },
    };

    final responseMessage = await _session._executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'ack') {
      return;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<void> hangup() async {
    final requestData = <String, dynamic>{
      'janus': 'hangup',
      'handle_id': _id,
    };

    final responseMessage = await _session._executeTransaction(requestData, true);

    if (responseMessage['janus'] == 'success') {
      return;
    } else {
      throw JanusPluginHandleException();
    }
  }

  Future<Map<String, dynamic>> executeMessage(
    Map<String, dynamic> body,
    Map<String, dynamic> jsep,
    bool synchronous,
  ) async {
    final requestMessage = <String, dynamic>{
      'janus': 'message',
      'handle_id': _id,
      'body': body,
      if (jsep != null) 'jsep': jsep,
    };

    final responseMessage = await _session._executeTransaction(requestMessage, synchronous);

    if (responseMessage['sender'] == _id) {
      final Map<String, dynamic> pluginData = responseMessage['plugindata']['data'];
      if (pluginData.containsKey('error_code') || pluginData.containsKey('error')) {
        throw JanusPluginHandleErrorException(pluginData['error_code'], pluginData['error']);
      } else {
        return pluginData;
      }
    }
    throw JanusPluginHandleException();
  }

  _handleEvent(Map<String, dynamic> eventMessage) {
    if (eventMessage['janus'] == 'event') {
      final Map<String, dynamic> pluginData = eventMessage['plugindata']['data'];
      final Map<String, dynamic> jsep = eventMessage['jsep'];

      if (_onEvent != null) {
        _onEvent(pluginData, jsep);
      } else {
        _session._gateway._onError('Handle event callback unawalibale', StackTrace.current); // TODO refactoring
      }
    } else if (eventMessage['janus'] == 'trickle') {
      final Map<String, dynamic> eventCandidate = eventMessage['candidate'];
      final isCompleted = eventCandidate['completed'] != null && eventCandidate['completed'] == true;
      if (isCompleted) {
        _onTrickle(null);
      } else {
        _onTrickle(eventCandidate);
      }
    } else if (eventMessage['janus'] == 'webrtcup') {
      _onWebrtcup();
    } else if (eventMessage['janus'] == 'media') {
      _onMedia(eventMessage['type'], eventMessage['receiving'], eventMessage['seconds']);
    } else if (eventMessage['janus'] == 'slowlink') {
      _onSlowlink(eventMessage['media'], eventMessage['uplink'], eventMessage['lost']);
    } else if (eventMessage['janus'] == 'hangup') {
      _onHangup(eventMessage['reason']);
    } else if (eventMessage['janus'] == 'detached') {
      _detachedReceived = true;

      _session._detach(this);
      _id = null;

      _onDetached();
    } else {
      throw JanusPluginHandleException();
    }
  }
}
