import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'audio_constraints_builder.dart';
import 'video_constraints_builder.dart';

abstract class UserMediaBuilder {
  Future<MediaStream> build({required bool video, bool? frontCamera, bool allowAudioFallback = false});

  Future<MediaStreamTrack?> ensureVideoTrack(MediaStream stream, {bool? frontCamera});

  Future<void> release(MediaStream stream);
}

class DefaultUserMediaBuilder implements UserMediaBuilder {
  DefaultUserMediaBuilder({
    this.audioConstraintsBuilder,
    this.videoConstraintsBuilder,
    this.isCameraPermissionGranted,
    this.getUserMedia,
    this.createLocalStream,
  });

  final AudioConstraintsBuilder? audioConstraintsBuilder;
  final VideoConstraintsBuilder? videoConstraintsBuilder;

  /// Optional callback to check whether camera permission is granted.
  ///
  /// When [null], video availability is assumed to be [true] — the platform
  /// itself (OS / browser) will handle the permission prompt.
  final Future<bool> Function()? isCameraPermissionGranted;

  /// Injectable override for [navigator.mediaDevices.getUserMedia].
  ///
  /// Defaults to the real platform API when [null].
  /// Intended for use in tests only.
  @visibleForTesting
  final Future<MediaStream> Function(Map<String, dynamic>)? getUserMedia;

  /// Injectable override for [createLocalMediaStream].
  ///
  /// Defaults to the real platform API when [null].
  @visibleForTesting
  final Future<MediaStream> Function(String label)? createLocalStream;

  final Map<String, _BorrowedStreamLease> _borrowedStreams = {};
  _PooledTrack? _audioTrack;
  _PooledTrack? _videoTrack;

  /// Requests access to the user's media input devices (camera and/or microphone).
  ///
  /// When [allowAudioFallback] is [true] and [video] is [true], the camera
  /// permission is checked first via [isCameraPermissionGranted]. If denied,
  /// the stream is acquired without video rather than throwing.
  ///
  /// If the pre-check passes but [getUserMedia] still fails (e.g. permission
  /// revoked between check and call), the method retries with [video: false]
  /// so the incoming call is answered audio-only rather than dropped.
  ///
  /// When [allowAudioFallback] is [false] (default), any failure to acquire
  /// media throws [UserMediaError], preserving the original behaviour for
  /// callers that handle the error explicitly (e.g. camera-enable action).
  ///
  /// For more information on constraints structure, see:
  /// https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
  @override
  Future<MediaStream> build({required bool video, bool? frontCamera, bool allowAudioFallback = false}) async {
    final resolvedVideo = video && (!allowAudioFallback || await _isCameraAvailable());

    try {
      return await _acquirePooledStream(resolvedVideo: resolvedVideo, frontCamera: frontCamera);
    } catch (_) {
      if (!allowAudioFallback || !resolvedVideo) rethrow;
      return _acquirePooledStream(resolvedVideo: false, frontCamera: frontCamera);
    }
  }

  @override
  Future<MediaStreamTrack?> ensureVideoTrack(MediaStream stream, {bool? frontCamera}) async {
    final existingTrack = stream.getVideoTracks().firstOrNull;
    if (existingTrack != null) return existingTrack;

    final videoTrack = await _acquireVideoTrack(frontCamera: frontCamera);

    try {
      await stream.addTrack(videoTrack);
      _borrowedStreams.update(
        stream.id,
        (lease) => lease.copyWith(videoTrackId: videoTrack.id),
        ifAbsent: () => _BorrowedStreamLease(videoTrackId: videoTrack.id),
      );

      await _configureAppleAudio(hasVideo: true);
      return videoTrack;
    } catch (e) {
      await _releaseVideoTrack(videoTrack.id);
      throw UserMediaError(e.toString());
    }
  }

  @override
  Future<void> release(MediaStream stream) async {
    final lease = _borrowedStreams.remove(stream.id);

    if (lease != null) {
      // Detach pooled tracks from the stream before disposing it.
      // On iOS and Android, streamDispose iterates stream.audioTracks /
      // stream.videoTracks and removes each from the native localTracks
      // registry. If a track is still referenced by another active call
      // (references > 1), removing it from the stream first prevents
      // streamDispose from evicting it — mediaStreamRemoveTrack does not
      // touch localTracks, only the stream's own track list.
      await _detachIfStillPooled(stream, lease.audioTrackId, _audioTrack);
      await _detachIfStillPooled(stream, lease.videoTrackId, _videoTrack);
      await _releaseAudioTrack(lease.audioTrackId);
      await _releaseVideoTrack(lease.videoTrackId);
    }

    await stream.dispose();
  }

  Future<void> _detachIfStillPooled(MediaStream stream, String? trackId, _PooledTrack? pooled) async {
    if (trackId == null || pooled == null || pooled.track.id != trackId) return;
    // references <= 1 means this is the last holder — _releaseAudioTrack /
    // _releaseVideoTrack will stop and dispose the track anyway, so there
    // is no need to detach it from the stream beforehand.
    if (pooled.references <= 1) return;
    await stream.removeTrack(pooled.track);
  }

  Future<MediaStream> _acquirePooledStream({required bool resolvedVideo, bool? frontCamera}) async {
    MediaStream? stream;
    MediaStreamTrack? audioTrack;
    MediaStreamTrack? videoTrack;

    try {
      stream = await (createLocalStream ?? createLocalMediaStream)(_nextStreamLabel());
      final lease = _BorrowedStreamLease();

      audioTrack = await _acquireAudioTrack();
      await stream.addTrack(audioTrack);
      lease.audioTrackId = audioTrack.id;

      if (resolvedVideo) {
        videoTrack = await _acquireVideoTrack(frontCamera: frontCamera);
        await stream.addTrack(videoTrack);
        lease.videoTrackId = videoTrack.id;
      }

      _borrowedStreams[stream.id] = lease;
      await _configureAppleAudio(hasVideo: resolvedVideo);

      return stream;
    } catch (e) {
      await _releaseVideoTrack(videoTrack?.id);
      await _releaseAudioTrack(audioTrack?.id);
      await stream?.dispose();

      if (e is UserMediaError) rethrow;
      if (e is PlatformException && e.code == 'mediaStreamAddTrack') {
        throw UserMediaTrackSetupError(e.toString());
      }
      throw UserMediaError(e.toString());
    }
  }

  Future<MediaStreamTrack> _acquireAudioTrack() async {
    final pooledTrack = _audioTrack;
    if (pooledTrack != null) {
      pooledTrack.references++;
      return pooledTrack.track;
    }

    final sourceStream = await _requestStream(audio: true, video: false);
    final track = sourceStream.getAudioTracks().firstOrNull;
    if (track == null) {
      await sourceStream.dispose();
      throw UserMediaError('Unable to acquire local audio track');
    }

    _audioTrack = _PooledTrack(track: track, sourceStream: sourceStream)..references = 1;
    return track;
  }

  Future<MediaStreamTrack> _acquireVideoTrack({bool? frontCamera}) async {
    final pooledTrack = _videoTrack;
    if (pooledTrack != null) {
      pooledTrack.references++;
      return pooledTrack.track;
    }

    final sourceStream = await _requestStream(audio: false, video: true, frontCamera: frontCamera);
    final track = sourceStream.getVideoTracks().firstOrNull;
    if (track == null) {
      await sourceStream.dispose();
      throw UserMediaError('Unable to acquire local video track');
    }

    _videoTrack = _PooledTrack(track: track, sourceStream: sourceStream)..references = 1;
    return track;
  }

  Future<void> _releaseAudioTrack(String? trackId) async {
    final pooledTrack = _audioTrack;
    if (pooledTrack == null || trackId == null || pooledTrack.track.id != trackId) return;

    if (pooledTrack.references == 0) return;
    pooledTrack.references--;
    if (pooledTrack.references > 0) return;

    // Null the pool slot before the first await so that a concurrent
    // _acquireAudioTrack call sees an empty pool and opens a fresh getUserMedia
    // instead of grabbing this track while it is being torn down. If nulled after
    // the await, the concurrent caller increments references on a track that the
    // native layer has already removed from localTracks, causing the subsequent
    // stream.addTrack() to fail with "track is null".
    _audioTrack = null;
    await pooledTrack.track.stop();
    await pooledTrack.sourceStream.dispose();
  }

  Future<void> _releaseVideoTrack(String? trackId) async {
    final pooledTrack = _videoTrack;
    if (pooledTrack == null || trackId == null || pooledTrack.track.id != trackId) return;

    if (pooledTrack.references == 0) return;
    pooledTrack.references--;
    if (pooledTrack.references > 0) return;

    // Same rationale as _releaseAudioTrack: null before await to close the race.
    _videoTrack = null;
    await pooledTrack.track.stop();
    await pooledTrack.sourceStream.dispose();
  }

  Future<MediaStream> _requestStream({required bool audio, required bool video, bool? frontCamera}) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': audio ? _buildAudioConstraints() : false,
      'video': video ? _buildVideoConstraintsMap(frontCamera: frontCamera) : false,
    };

    try {
      return await (getUserMedia ?? navigator.mediaDevices.getUserMedia)(mediaConstraints);
    } catch (e) {
      throw UserMediaError(e.toString());
    }
  }

  Future<bool> _isCameraAvailable() async {
    if (kIsWeb || isCameraPermissionGranted == null) return true;
    return isCameraPermissionGranted!();
  }

  Future<void> _configureAppleAudio({required bool hasVideo}) async {
    if (kIsWeb) return;

    // Always use VoiceChat so enabling video does not automatically switch
    // the audio output to the speaker. The user can turn on the speaker
    // manually if needed.
    await Helper.setAppleAudioConfiguration(AppleAudioConfiguration(appleAudioMode: AppleAudioMode.voiceChat));
  }

  String _nextStreamLabel() => 'user_media_${DateTime.now().microsecondsSinceEpoch}';

  /// Constructs the map structure for audio constraints.
  Map<String, dynamic> _buildAudioConstraints() {
    return {'mandatory': audioConstraintsBuilder?.build() ?? <String, String>{}};
  }

  /// Constructs the video constraints map.
  ///
  /// This method is only called when video is enabled.
  /// Returns a strictly typed [Map<String, dynamic>].
  Map<String, dynamic> _buildVideoConstraintsMap({bool? frontCamera}) {
    return <String, dynamic>{
      'mandatory': videoConstraintsBuilder?.build() ?? <String, String>{},
      if (frontCamera != null) 'facingMode': frontCamera ? 'user' : 'environment',
      'optional': <dynamic>[],
    };
  }
}

class UserMediaError implements Exception {
  final String message;

  UserMediaError(this.message);

  @override
  String toString() => 'UserMediaError: $message';
}

/// Thrown when a native media track cannot be added to a local stream.
///
/// Distinct from [UserMediaError]: the cause is a stale or invalidated native
/// track reference, not a permission denial. Does not warrant showing
/// "check permissions" to the user.
final class UserMediaTrackSetupError extends UserMediaError {
  UserMediaTrackSetupError(super.message);
}

class _PooledTrack {
  _PooledTrack({required this.track, required this.sourceStream});

  final MediaStreamTrack track;
  final MediaStream sourceStream;
  int references = 0;
}

class _BorrowedStreamLease {
  _BorrowedStreamLease({this.audioTrackId, this.videoTrackId});

  String? audioTrackId;
  String? videoTrackId;

  _BorrowedStreamLease copyWith({String? audioTrackId, String? videoTrackId}) {
    return _BorrowedStreamLease(
      audioTrackId: audioTrackId ?? this.audioTrackId,
      videoTrackId: videoTrackId ?? this.videoTrackId,
    );
  }
}
