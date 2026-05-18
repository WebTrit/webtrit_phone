import 'package:flutter_webrtc/flutter_webrtc.dart';

extension IceCandidateExt on RTCIceCandidate {
  // SDP: candidate:<foundation> <component> <transport> <priority> <address> <port> typ <type> ...
  String? get address {
    final parts = candidate?.split(' ');
    return (parts != null && parts.length > 4) ? parts[4] : null;
  }

  int? get port {
    final parts = candidate?.split(' ');
    return (parts != null && parts.length > 5) ? int.tryParse(parts[5]) : null;
  }

  String? get transport {
    final parts = candidate?.split(' ');
    return (parts != null && parts.length > 2) ? parts[2] : null;
  }

  String? get type {
    final parts = candidate?.split(' ');
    return (parts != null && parts.length > 7) ? parts[7] : null;
  }

  // Extension key-value pairs start at index 8 and alternate key/value.
  String? get networkCost {
    final parts = candidate?.split(' ');
    if (parts == null) return null;
    for (var i = 8; i + 1 < parts.length; i += 2) {
      if (parts[i] == 'network-cost') return parts[i + 1];
    }
    return null;
  }

  bool get isLoopback {
    final addr = address;
    if (addr == null) return false;
    return addr == '::1' || addr == '127.0.0.1' || addr.startsWith('127.');
  }

  String get str {
    final cost = networkCost;
    return 'mid=$sdpMid ${type ?? '?'} ${transport ?? '?'} ${address ?? '?'}:${port ?? '?'}'
        '${cost != null ? ' cost=$cost' : ''}';
  }

  bool isSfrlxCandidate() => type == 'srflx';

  bool isRelayCandidate() => type == 'relay';

  bool isHostCandidate() => type == 'host';
}

extension RTCIceCandidateListExt on Iterable<RTCIceCandidate> {
  List<RTCIceCandidate> get hostCandidates => where((e) => e.isHostCandidate()).toList();

  List<RTCIceCandidate> get srflxCandidates => where((e) => e.isSfrlxCandidate()).toList();

  List<RTCIceCandidate> get relayCandidates => where((e) => e.isRelayCandidate()).toList();

  (int host, int relay, int srflx) get typesCount {
    return (hostCandidates.length, relayCandidates.length, srflxCandidates.length);
  }
}

extension MediaStreamTrackExt on MediaStreamTrack {
  String get str => 'Track(id: $id, kind: $kind, label: $label, enabled: $enabled, muted: $muted)';
}

extension RTCRtpReceiverExt on RTCRtpReceiver {
  String get str => 'Receiver(id: $receiverId, track: ${track?.str})';
}

extension RTCRtpSenderExt on RTCRtpSender {
  String get str => 'Sender(id: $senderId, track: ${track?.str})';
}

extension RTCRtpTransceiverExt on RTCRtpTransceiver {
  String get str => 'Transceiver(mid: $mid, sender: ${sender.str}, receiver: ${receiver.str})';
}

extension MediaStreamExt on MediaStream {
  String get str =>
      'MediaStream(id: $id, ownerTag: $ownerTag, audio: ${getAudioTracks().length}, video: ${getVideoTracks().length})';
}

extension RTCTrackEventExt on RTCTrackEvent {
  String get str =>
      'TrackEvent(track: ${track.str}, receiver: ${receiver?.str}, transceiver: ${transceiver?.str}, streams: ${streams.map((e) => e.str).toList()})';
}

extension MediaDeviceInfoExt on MediaDeviceInfo {
  String get str => 'MediaDeviceInfo(id: $deviceId, kind: $kind, label: $label, groupId: $groupId)';
}
