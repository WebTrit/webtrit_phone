part of '../janus_client.dart';

class Session {
  static const keepalivePeriodicDuration = Duration(milliseconds: 50000);

  final _handles = <int, PluginHandle>{};

  final Gateway _gateway;
  final Function _onError;

  int? _id;
  late Timer _keepalivePeriodicTimer;

  int? get id => _id;

  Session(this._gateway, this._onError);

  Future<void> create() async {
    final requestMessage = <String, dynamic>{
      'janus': 'create',
    };

    final responseMessage = await _gateway._executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'success') {
      _id = responseMessage['data']['id'];

      _gateway._create(this);

      _keepalivePeriodicTimer = Timer.periodic(
        keepalivePeriodicDuration,
        _keepalivePeriodicCallback,
      );
    } else {
      throw JanusGatewayException();
    }
  }

  Future<void> destroy() async {
    final requestMessage = <String, dynamic>{
      'janus': 'destroy',
    };

    final responseMessage = await _executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'success') {
      _keepalivePeriodicTimer.cancel();

      _gateway._destroy(this);

      _id = null;
    } else {
      throw JanusSessionException();
    }
  }

  void _attach(PluginHandle handle) {
    _handles[handle.id] = handle;
  }

  void _detach(PluginHandle handle) {
    _handles.remove(handle.id);
  }

  Future<Map<String, dynamic>> _executeTransaction(Map<String, dynamic> requestMessage, bool synchronous) async {
    requestMessage['session_id'] = id;

    final responseMessage = await _gateway._executeTransaction(requestMessage, synchronous);

    if (responseMessage['session_id'] == id) {
      return responseMessage;
    } else {
      throw JanusSessionException();
    }
  }

  _handleEvent(Map<String, dynamic> eventMessage) {
    if (eventMessage.containsKey('sender')) {
      final int? handleId = eventMessage['sender'];
      final handle = _handles[handleId];

      if (handle != null) {
        handle._handleEvent(eventMessage);
      } else {
        _onError(JanusSessionHandleUnavailableException(handleId!));
      }
    } else if (eventMessage['janus'] == 'timeout') {
      _onError(JanusSessionTimeoutException());
    } else {
      throw JanusSessionException();
    }
  }

  _keepalivePeriodicCallback(Timer timer) async {
    final Map<String, dynamic> requestMessage = {
      'janus': 'keepalive',
    };

    final responseMessage = await _executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'ack') {
      return;
    } else {
      throw JanusSessionException();
    }
  }
}
