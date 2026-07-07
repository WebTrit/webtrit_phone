import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('VoicemailPlaybackController');

class VoicemailPlaybackController extends ChangeNotifier with WidgetsBindingObserver {
  VoicemailPlaybackController({AudioPlayer? player, Future<void> Function()? setupAudioSession})
    : _player = player ?? AudioPlayer(),
      _setupAudioSession = setupAudioSession ?? _defaultSetupAudioSession {
    WidgetsBinding.instance.addObserver(this);
    _playerStateSub = _player.playerStateStream.listen(_onPlayerStateChanged);
  }

  static Future<void> _defaultSetupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  final AudioPlayer _player;
  final Future<void> Function() _setupAudioSession;
  StreamSubscription<PlayerState>? _playerStateSub;

  String? _activeId;
  bool _isLoading = false;
  Object? _error;
  final _loadingDebounce = Debounce(const Duration(milliseconds: 200));
  int _generation = 0;

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
    // Resume same track -- but fall through if previous attempt left an error.
    if (_activeId == id && _error == null) {
      if (!_player.playing && !_isLoading) await _player.play();
      return;
    }

    final generation = ++_generation;

    _activeId = id;
    _error = null;
    // Show the player UI immediately (optimistic); only show loading spinner
    // if setAudioSource takes longer than the debounce threshold (e.g. slow network).
    // This prevents a blink on cached audio where loading is near-instant.
    _loadingDebounce.schedule(() {
      if (_generation == generation) {
        _isLoading = true;
        notifyListeners();
      }
    });
    notifyListeners();

    try {
      await _setupAudioSession();
      if (_generation != generation) return;

      final source = await _buildSource(
        uri: uri,
        headers: headers,
        cacheBasePath: cacheBasePath,
        cacheKey: cacheKey,
        isLocal: isLocal,
      );
      if (_generation != generation) return;

      await _player.setAudioSource(source);
      if (_generation != generation) return;

      _loadingDebounce.cancel();
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
      await _player.play();
    } catch (e, s) {
      if (_generation != generation) return;
      _logger.warning('Playback error for $uri', e, s);
      _loadingDebounce.cancel();
      _isLoading = false;
      _error = e;
      _player.stop();
      notifyListeners();
    }
  }

  /// Stops playback and clears the active track. Used when the active
  /// voicemail disappears from the list (deleted locally or remotely) --
  /// the player is screen-scoped, so nothing else would stop it.
  Future<void> stop() async {
    _generation++;
    _loadingDebounce.cancel();
    _activeId = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
    await _player.stop();
  }

  Future<void> pause() => _player.pause();

  Future<void> resume() => _player.play();

  void seek(Duration position) => _player.seek(position);

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
    final cacheFile = resolveCacheFile(cacheBasePath: cacheBasePath, uri: uri, cacheKey: cacheKey);
    // ignore: experimental_member_use
    return LockCachingAudioSource(uri, headers: headers, cacheFile: cacheFile);
  }

  @visibleForTesting
  File? resolveCacheFile({required String? cacheBasePath, required Uri uri, required String? cacheKey}) {
    if (cacheBasePath == null) return null;
    final rawKey = cacheKey ?? uri.pathSegments.where((s) => s.isNotEmpty).join('_');
    if (rawKey.isEmpty) return null;
    // Prevent path traversal from server-provided cacheKey values: strip path
    // separators, and reject the special directory names `.`/`..` which would
    // otherwise escape cacheBasePath via path.join even without a separator.
    final key = rawKey.replaceAll(RegExp(r'[/\\]'), '_');
    if (key == '.' || key == '..') return null;
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
    _loadingDebounce.dispose();
    _playerStateSub?.cancel();
    _player.stopAndDispose();
    super.dispose();
  }
}
