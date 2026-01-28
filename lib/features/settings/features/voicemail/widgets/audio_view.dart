import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';
import 'audio_player_interface.dart';

final _logger = Logger('AudioView');

class AudioView extends StatefulWidget {
  const AudioView({required this.path, super.key, this.onPlaybackStarted});

  final String path;

  // Callback triggered when playback starts, useful for marking the audio as seen
  final VoidCallback? onPlaybackStarted;

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  StreamSubscription<PlaybackEvent>? _playbackSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  late final String _cachePath;
  late final Map<String, String>? _headers;
  late final Uri _uri;

  bool _isLoading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final voicemailContext = context.read<VoicemailScreenContext>();
    _cachePath = voicemailContext.mediaCacheBasePath;
    _headers = voicemailContext.mediaHeaders;
    _uri = Uri.parse(widget.path);

    _initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelSubscriptions();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Future<void> _initialize() async {
    try {
      _setLoadingState();

      // Cancel previous subscriptions if retrying
      _cancelSubscriptions();

      await _setupAudioSession();
      if (!mounted) return;

      await _player.setAudioSource(_createAudioSource());
      if (!mounted) return;

      _playbackSub = _player.playbackEventStream.listen(_onPlaybackEvent, onError: _handleError);

      _playerStateSub = _player.playerStateStream.listen(_onPlayerStateChanged);

      _setSuccessState();
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  void _cancelSubscriptions() {
    _playbackSub?.cancel();
    _playerStateSub?.cancel();
    _playbackSub = null;
    _playerStateSub = null;
  }

  void _setLoadingState() {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }
  }

  void _setSuccessState() {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _handleError(Object e, [StackTrace? stackTrace]) {
    _logger.warning('Playback error for $_uri', e, stackTrace);

    if (!mounted) return;

    _player.stop();
    _cancelSubscriptions();

    setState(() {
      _error = e;
      _isLoading = false;
    });
  }

  void _onPlaybackEvent(PlaybackEvent event) {
    if (mounted) setState(() {});
  }

  void _onPlayerStateChanged(PlayerState state) {
    if (state.processingState == ProcessingState.completed) {
      _resetPlayer();
    }
  }

  void _resetPlayer() {
    _player.stop();
    _player.seek(Duration.zero);
  }

  Future<void> _setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  AudioSource _createAudioSource() {
    if (widget.path.isLocalPath) {
      return AudioSource.uri(_uri);
    }

    return LockCachingAudioSource(_uri, headers: _headers, cacheFile: _getCacheFile());
  }

  File? _getCacheFile() {
    // Do not provide a custom cacheFile on iOS:
    // just_audio internally handles caching on iOS, and supplying a custom file
    // may lead to PlayerException (-11828) if the file is not yet created or invalid.

    if (widget.path.isLocalPath || Platform.isIOS) return null;

    // Safer path construction: use the filename from the URI,
    // ensuring we don't accidentally create invalid directory structures.
    final fileName = _uri.pathSegments.lastWhere((element) => element.isNotEmpty, orElse: () => 'audio_temp');

    return File(path.join(_cachePath, fileName));
  }

  Future<void> _handleTogglePlayback() async {
    try {
      if (_player.playing) {
        await _player.pause();
      } else {
        widget.onPlaybackStarted?.call();
        await _player.play();
      }
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleSeek(Duration position) => _player.seek(position);

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _AudioErrorView(onRetry: _initialize);
    }

    if (_isLoading) {
      return const _AudioLoadingView();
    }

    return AudioPlayerInterface(player: _player, onToggle: _handleTogglePlayback, onSeek: _handleSeek);
  }
}

class _AudioLoadingView extends StatelessWidget {
  const _AudioLoadingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: Center(child: LinearProgressIndicator(color: colorScheme.primaryContainer)),
    );
  }
}

class _AudioErrorView extends StatelessWidget {
  const _AudioErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.l10n.voicemail_Label_playbackError,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
          ),
          IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
