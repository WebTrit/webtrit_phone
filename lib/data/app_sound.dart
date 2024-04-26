import 'package:soundpool/soundpool.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

class AppSound {
  static late AppSound _instance;

  static Future<void> init({
    required String outgoingCallRingAsset,
    int outgoingCallRingRepeat = 50,
  }) async {
    final sound = Soundpool.fromOptions(options: const SoundpoolOptions(streamType: StreamType.ring));

    final ringSoundId = await sound.loadAsset(outgoingCallRingAsset);

    _instance = AppSound._(sound, outgoingCallRingRepeat, ringSoundId);
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
