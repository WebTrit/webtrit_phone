// Web variant of [nativeRestartAudio].
//
// There is no native AVAudioEngine on web - the browser owns the audio device
// and WebRTC manages playout/recording automatically, so there is nothing to
// restart.
//
// TODO(web): revisit if a manual audio-engine restart is ever needed on web.
Future<void> nativeRestartAudio() async {}
