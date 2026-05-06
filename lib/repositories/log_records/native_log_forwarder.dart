import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/disposable.dart';

class NativeLogForwarder implements Disposable {
  NativeLogForwarder({required String nativeLogFilePath, required Logger logger})
    : _file = File(nativeLogFilePath),
      _logger = logger;

  final File _file;
  final Logger _logger;
  int _lastLineCount = 0;
  StreamSubscription<FileSystemEvent>? _watchSubscription;

  void start() {
    _watchSubscription = _file.parent.watch().where((e) => e.path == _file.absolute.path).listen(_onFileEvent);
  }

  void _onFileEvent(FileSystemEvent event) {
    if (event.type == FileSystemEvent.delete) {
      _lastLineCount = 0;
      return;
    }
    _forwardNewLines();
  }

  Future<void> _forwardNewLines() async {
    if (!_file.existsSync()) {
      _lastLineCount = 0;
      return;
    }
    try {
      final lines = await _file.readAsLines();
      if (lines.length < _lastLineCount) {
        _lastLineCount = 0;
      }
      for (var i = _lastLineCount; i < lines.length; i++) {
        final trimmed = lines[i].trim();
        if (trimmed.isEmpty) continue;
        _logger.log(_parseLevel(trimmed), trimmed);
      }
      _lastLineCount = lines.length;
    } catch (e, st) {
      _logger.warning('NativeLogForwarder: failed to read ${_file.path}', e, st);
    }
  }

  // Expects lines in the format written by Kotlin Log.kt:
  // "yyyy-MM-dd HH:mm:ss.SSS <level> <tag>: <message>"
  // parts[2] is the single-character level: D=FINE, I=INFO, W=WARNING, E=SEVERE, V=FINEST.
  Level _parseLevel(String line) {
    final parts = line.split(' ');
    if (parts.length < 3) return Level.INFO;
    return switch (parts[2]) {
      'D' => Level.FINE,
      'I' => Level.INFO,
      'W' => Level.WARNING,
      'E' => Level.SEVERE,
      'V' => Level.FINEST,
      _ => Level.INFO,
    };
  }

  @override
  Future<void> dispose() async {
    await _watchSubscription?.cancel();
    _watchSubscription = null;
  }
}
