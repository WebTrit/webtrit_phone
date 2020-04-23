import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_webrtc/media_stream.dart';
import 'package:flutter_webrtc/utils.dart';
import 'package:flutter_webrtc/enums.dart';

@immutable
class RTCVideoValue {
  static const RTCVideoValue empty = RTCVideoValue();

  final double width;
  final double height;
  final int rotation;

  const RTCVideoValue({
    this.width = 0.0,
    this.height = 0.0,
    this.rotation = 0,
  });

  bool get isEmpty => width == 0.0 || height == 0.0;

  double get aspectRatio {
    if (width == 0.0 || height == 0.0) {
      return 1.0;
    } else {
      return (rotation == 90 || rotation == 270) ? height / width : width / height;
    }
  }

  RTCVideoValue copyWith({
    double width,
    double height,
    int rotation,
  }) {
    return RTCVideoValue(
      width: width ?? this.width,
      height: height ?? this.height,
      rotation: rotation ?? this.rotation,
    );
  }

  @override
  String toString() => '$runtimeType(width: $width, height: $height, rotation: $rotation)';
}

class RTCVideoRendererExt extends ValueNotifier<RTCVideoValue> {
  MethodChannel _channel = WebRTC.methodChannel();
  int _textureId;
  MediaStream _srcObject;
  StreamSubscription<dynamic> _eventSubscription;

  RTCVideoRendererExt() : super(RTCVideoValue.empty);

  Future<void> initialize() async {
    _textureId = await _createVideoRenderer();
    _eventSubscription = _eventsFor(_textureId).listen(_eventListener, onError: _errorListener);
  }

  int get textureId => _textureId;

  set srcObject(MediaStream stream) {
    if (stream == null) {
      value = RTCVideoValue.empty;
    }
    _srcObject = stream;
    _videoRendererSetSrcObject(stream);
  }

  @override
  Future<void> dispose() async {
    await _eventSubscription?.cancel();
    await _videoRendererDispose();

    super.dispose();
  }

  Future<int> _createVideoRenderer() async {
    final Map<String, dynamic> response = await _channel.invokeMapMethod<String, dynamic>(
      'createVideoRenderer',
    );
    return response['textureId'];
  }

  Future<void> _videoRendererDispose() async {
    await _channel.invokeMethod<void>(
      'videoRendererDispose',
      <String, dynamic>{
        'textureId': _textureId,
      },
    );
  }

  Future<void> _videoRendererSetSrcObject(MediaStream stream) async {
    await _channel.invokeMethod<void>(
      'videoRendererSetSrcObject',
      <String, dynamic>{
        'textureId': _textureId,
        'streamId': stream?.id ?? '',
        'ownerTag': stream?.ownerTag ?? '',
      },
    );
  }

  Stream<dynamic> _eventsFor(int textureId) {
    return EventChannel('FlutterWebRTC/Texture$textureId').receiveBroadcastStream();
  }

  void _eventListener(dynamic event) {
    final Map<dynamic, dynamic> map = event;
    switch (map['event']) {
      case 'didTextureChangeRotation':
        value = value.copyWith(rotation: map['rotation']);
        break;
      case 'didTextureChangeVideoSize':
        value = value.copyWith(width: 0.0 + map['width'], height: 0.0 + map['height']);
        break;
      case 'didFirstFrameRendered':
        notifyListeners();
        break;
    }
  }

  void _errorListener(Object obj) {
    final PlatformException e = obj;
    throw e;
  }
}

class RTCVideoViewExt extends StatelessWidget {
  final RTCVideoRendererExt _renderer;

  final RTCVideoViewObjectFit objectFit;
  final bool mirror;

  RTCVideoViewExt(
    this._renderer, {
    Key key,
    this.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
    this.mirror = false,
  })  : assert(objectFit != null),
        assert(mirror != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool renderVideo = _renderer._textureId != null && _renderer._srcObject != null;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: renderVideo ? _buildVideoView(constraints) : Container(),
        );
      },
    );
  }

  Widget _buildVideoView(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: FittedBox(
        fit: objectFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain ? BoxFit.contain : BoxFit.cover,
        child: Center(
          child: ValueListenableBuilder<RTCVideoValue>(
            valueListenable: _renderer,
            builder: (BuildContext context, RTCVideoValue value, Widget child) {
              return SizedBox(
                width: constraints.maxHeight * value.aspectRatio,
                height: constraints.maxHeight,
                child: child,
              );
            },
            child: Transform(
              transform: Matrix4.identity()..rotateY(mirror ? -pi : 0.0),
              alignment: FractionalOffset.center,
              child: Texture(textureId: _renderer._textureId),
            ),
          ),
        ),
      ),
    );
  }
}
