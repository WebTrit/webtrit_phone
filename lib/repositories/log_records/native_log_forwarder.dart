import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/disposable.dart';

class NativeLogForwarder implements Disposable {
  NativeLogForwarder({
    required String nativeLogFilePath,
    required Logger logger,
    Level Function(String line)? levelParser,
  }) : _file = File(nativeLogFilePath),
       _logger = logger,
       _levelParser = levelParser ?? _callkeepLevelParser;

  final File _file;
  final Logger _logger;
  final Level Function(String line) _levelParser;
  int _readOffset = 0;
  String _remainder = '';
  StreamSubscription<FileSystemEvent>? _watchSubscription;
  Future<void>? _pendingForward;

  void start() {
    _watchSubscription?.cancel();
    final absolutePath = _file.absolute.path;
    _watchSubscription = _file.parent
        .watch()
        .where((e) => File(e.path).absolute.path == absolutePath)
        .listen(_onFileEvent);
  }

  void _onFileEvent(FileSystemEvent event) {
    if (event.type == FileSystemEvent.delete) {
      _readOffset = 0;
      _remainder = '';
      return;
    }
    _pendingForward = (_pendingForward ?? Future.value()).then((_) => _forwardNewBytes());
  }

  Future<void> _forwardNewBytes() async {
    if (!_file.existsSync()) {
      _readOffset = 0;
      _remainder = '';
      return;
    }
    RandomAccessFile? raf;
    try {
      raf = await _file.open();
      final length = await raf.length();
      if (length < _readOffset) {
        // file was rotated or truncated
        _readOffset = 0;
        _remainder = '';
      }
      if (length == _readOffset) return;
      await raf.setPosition(_readOffset);
      final bytes = await raf.read(length - _readOffset);
      _readOffset = length;
      final chunk = _remainder + utf8.decode(bytes, allowMalformed: true);
      final lines = chunk.split('\n');
      // last element is empty on a complete write, or a partial line — buffer it
      _remainder = lines.removeLast();
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) continue;
        _logger.log(_levelParser(trimmed), trimmed);
      }
    } catch (e, st) {
      _logger.warning('NativeLogForwarder: failed to read ${_file.path}', e, st);
    } finally {
      await raf?.close();
    }
  }


  @override
  Future<void> dispose() async {
    await _watchSubscription?.cancel();
    _watchSubscription = null;
    await _pendingForward;
    _pendingForward = null;
  }
}

// Default parser for the format written by webtrit_callkeep's Kotlin Log.kt:
// "yyyy-MM-dd HH:mm:ss.SSS <level> <tag>: <message>"
// parts[2] is the single-character level: D=FINE, I=INFO, W=WARNING, E=SEVERE, V=FINEST.
Level _callkeepLevelParser(String line) {
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
