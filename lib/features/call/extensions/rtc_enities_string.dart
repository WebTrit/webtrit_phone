import 'package:flutter_webrtc/flutter_webrtc.dart';

extension IceCandidateToToString on RTCIceCandidate {
  String get str => 'Candidate(sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex, candidate: $candidate)';
}

extension MediaStreamTrackToString on MediaStreamTrack {
  String get str => 'Track(id: $id, kind: $kind, label: $label, enabled: $enabled, muted: $muted)';
}

extension RTCRtpReceiverToString on RTCRtpReceiver {
  String get str => 'Receiver(id: $receiverId, track: ${track?.str})';
}

extension RTCRtpSenderToString on RTCRtpSender {
  String get str => 'Sender(id: $senderId, track: ${track?.str})';
}

extension RTCRtpTransceiverToString on RTCRtpTransceiver {
  String get str => 'Transceiver(mid: $mid, sender: ${sender.str}, receiver: ${receiver.str})';
}

extension MediaStreamToString on MediaStream {
  String get str =>
      'MediaStream(id: $id, ownerTag: $ownerTag, audio: ${getAudioTracks().length}, video: ${getVideoTracks().length})';
}

extension RTCTrackEventToString on RTCTrackEvent {
  String get str =>
      'TrackEvent(track: ${track.str}, receiver: ${receiver?.str}, transceiver: ${transceiver?.str}, streams: ${streams.map((e) => e.str).toList()})';
}
