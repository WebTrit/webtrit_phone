import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

const int _maxSamples = 1200;
const int _blackLumaThreshold = 16;
const double _blackFrameRatioThreshold = 0.98;

@visibleForTesting
bool analyzeFrameInIsolate(Uint8List frameBytes) {
  if (frameBytes.isEmpty) return true;

  final img.Image? decoded;
  try {
    decoded = img.decodeImage(frameBytes);
  } catch (_) {
    return true;
  }
  if (decoded == null) return true;

  final totalPixels = decoded.width * decoded.height;
  if (totalPixels == 0) return true;

  final step = math.max(1, totalPixels ~/ _maxSamples);
  var sampledPixels = 0;
  var opaquePixels = 0;
  var blackPixels = 0;

  for (var i = 0; i < totalPixels; i += step) {
    final pixel = decoded.getPixel(i % decoded.width, i ~/ decoded.width);
    sampledPixels++;
    if (pixel.a == 0) continue;
    opaquePixels++;
    final luma = (pixel.r * 299 + pixel.g * 587 + pixel.b * 114) ~/ 1000;
    if (luma <= _blackLumaThreshold) blackPixels++;
  }

  if (sampledPixels == 0 || opaquePixels == 0) return true;
  return blackPixels / opaquePixels >= _blackFrameRatioThreshold;
}

void _isolateEntry(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    if (message is Uint8List) {
      try {
        mainSendPort.send(analyzeFrameInIsolate(message));
      } catch (_) {
        mainSendPort.send(false); // optimistically renderable on analysis error
      }
    } else {
      receivePort.close();
    }
  });
}

/// Long-lived isolate worker that analyses video frames off the main thread.
///
/// Call [start] once, [analyzeFrame] for each probe, [dispose] on teardown.
/// Sequential use only — one outstanding [analyzeFrame] call at a time.
class FrameAnalysisWorker {
  /// Whether frames can be analysed on this platform.
  ///
  /// Web has no isolates, and decoding a full-resolution frame per probe on the
  /// UI thread would stall rendering, so frames are not analysed there.
  static const bool isSupported = !kIsWeb;

  Isolate? _isolate;
  ReceivePort? _receivePort;
  SendPort? _sendPort;
  Completer<bool>? _pendingAnalysis;
  late final Future<void> _ready;

  void start() {
    _ready = isSupported ? _init() : Future<void>.value();
  }

  Future<void> _init() async {
    final receivePort = ReceivePort();
    _receivePort = receivePort;
    final handshake = Completer<SendPort>();
    receivePort.listen((message) {
      if (!handshake.isCompleted) {
        handshake.complete(message as SendPort);
      } else if (message is bool) {
        _pendingAnalysis?.complete(message);
        _pendingAnalysis = null;
      }
    });
    _isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort, debugName: 'FrameAnalysisWorker');
    _sendPort = await handshake.future;
  }

  void dispose() {
    _pendingAnalysis?.completeError(StateError('disposed'));
    _pendingAnalysis = null;
    _sendPort?.send(null);
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort?.close();
    _isolate = null;
    _sendPort = null;
    _receivePort = null;
  }

  /// Returns `true` when the frame is black or empty, `false` when it has
  /// visible content. Awaits isolate startup if [start] hasn't finished yet.
  ///
  /// Always returns `false` where [isSupported] is `false`: nothing is analysed,
  /// so the frame is reported as renderable.
  Future<bool> analyzeFrame(Uint8List frameBytes) async {
    if (!isSupported) return false;

    await _ready;
    final completer = Completer<bool>();
    _pendingAnalysis = completer;
    _sendPort!.send(frameBytes);
    return completer.future;
  }
}
