import 'package:soundpool/soundpool.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class AppSound {
  static late AppSound _instance;

  static Future<AppSound> init({
    required String outgoingCallRingAsset,
    int outgoingCallRingRepeat = 50,
  }) async {
    final sound = Soundpool.fromOptions(options: const SoundpoolOptions(streamType: StreamType.music));

    final ringSoundId = await sound.loadAsset(outgoingCallRingAsset);

    _instance = AppSound._(sound, outgoingCallRingRepeat, ringSoundId);
    return _instance;
  }

  factory AppSound() {
    return _instance;
  }

  AppSound._(
    this._sound,
    this._repeat,
    this._outgoingCallRingSoundId,
  );

  final Soundpool _sound;
  final int _repeat;

  final int _outgoingCallRingSoundId;

  final List<int> _activeStreamIds = [];

  /// Play the outgoing call ring sound e.g `ringback` sound.
  /// Don't get confused with ringtone and ringback sound.
  /// use StreamType.music instead of StreamType.ring to not block sound by silence mode or system preferences.
  Future<void> playOutgoingCall() async {
    await stopOutgoingCall();

    final streamId = await _sound.play(
      _outgoingCallRingSoundId,
      repeat: _repeat,
    );
    _activeStreamIds.add(streamId);
  }

  Future<void> stopOutgoingCall() async {
    for (final streamId in _activeStreamIds) {
      await _sound.stop(streamId);
    }
    _activeStreamIds.clear();
  }
}
