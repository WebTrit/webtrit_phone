import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

const int _maxSamples = 1200;
const int _blackLumaThreshold = 16;
const double _blackFrameRatioThreshold = 0.98;

bool _analyzeFrameInIsolate(Uint8List frameBytes) {
  if (frameBytes.isEmpty) return true;

  final decoded = img.decodeImage(frameBytes);
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
        mainSendPort.send(_analyzeFrameInIsolate(message));
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
  Isolate? _isolate;
  ReceivePort? _receivePort;
  SendPort? _sendPort;
  Completer<bool>? _pendingAnalysis;
  late final Future<void> _ready;

  void start() {
    _ready = _init();
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
  Future<bool> analyzeFrame(Uint8List frameBytes) async {
    await _ready;
    final completer = Completer<bool>();
    _pendingAnalysis = completer;
    _sendPort!.send(frameBytes);
    return completer.future;
  }
}
