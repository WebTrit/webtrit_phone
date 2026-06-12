import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'package:webtrit_phone/extensions/extensions.dart';

final _logger = Logger('VoicemailPlaybackController');

class VoicemailPlaybackController extends ChangeNotifier with WidgetsBindingObserver {
  VoicemailPlaybackController() {
    WidgetsBinding.instance.addObserver(this);
    _playerStateSub = _player.playerStateStream.listen(_onPlayerStateChanged);
  }

  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSub;

  String? _activeId;
  bool _isLoading = false;
  Object? _error;

  String? get activeId => _activeId;
  bool get isLoading => _isLoading;
  Object? get error => _error;
  AudioPlayer get player => _player;

  bool get isPlaying => _player.playing;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _player.stop();
  }

  Future<void> play({
    required String id,
    required Uri uri,
    Map<String, String>? headers,
    String? cacheBasePath,
    String? cacheKey,
    bool isLocal = false,
  }) async {
    if (_activeId == id) {
      if (!_player.playing && !_isLoading) await _player.play();
      return;
    }

    _activeId = id;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _setupAudioSession();
      final source = await _buildSource(
        uri: uri,
        headers: headers,
        cacheBasePath: cacheBasePath,
        cacheKey: cacheKey,
        isLocal: isLocal,
      );
      await _player.setAudioSource(source);
      _isLoading = false;
      notifyListeners();
      await _player.play();
    } catch (e, s) {
      _logger.warning('Playback error for $uri', e, s);
      _isLoading = false;
      _error = e;
      notifyListeners();
    }
  }

  Future<void> pause() => _player.pause();

  Future<void> resume() => _player.play();

  void seek(Duration position) => _player.seek(position);

  Future<void> _setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<AudioSource> _buildSource({
    required Uri uri,
    required Map<String, String>? headers,
    required String? cacheBasePath,
    required String? cacheKey,
    required bool isLocal,
  }) async {
    if (isLocal) return AudioSource.uri(uri);

    // No stable caching alternative exists in just_audio (0.10.5).
    // LockCachingAudioSource is the only built-in caching API and has been actively maintained since 2020.
    // ignore: experimental_member_use
    if (Platform.isIOS) return LockCachingAudioSource(uri, headers: headers);

    if (cacheBasePath != null) {
      await Directory(cacheBasePath).create(recursive: true);
    }
    final cacheFile = _resolveCacheFile(cacheBasePath: cacheBasePath, uri: uri, cacheKey: cacheKey);
    // ignore: experimental_member_use
    return LockCachingAudioSource(uri, headers: headers, cacheFile: cacheFile);
  }

  File? _resolveCacheFile({required String? cacheBasePath, required Uri uri, required String? cacheKey}) {
    if (cacheBasePath == null) return null;
    final rawKey = cacheKey ?? uri.pathSegments.where((s) => s.isNotEmpty).join('_');
    if (rawKey.isEmpty) return null;
    // Prevent path traversal from server-provided cacheKey values.
    final key = rawKey.replaceAll(RegExp(r'[/\\]'), '_');
    return File(path.join(cacheBasePath, key));
  }

  void _onPlayerStateChanged(PlayerState state) {
    if (state.processingState == ProcessingState.completed) {
      _player.stop();
      _player.seek(Duration.zero);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _playerStateSub?.cancel();
    _player.stopAndDispose();
    super.dispose();
  }
}
