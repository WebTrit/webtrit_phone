import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract interface class IceChecker {
  Stream<CandidateInfo> gatherCandidates({required List<Map<String, dynamic>> iceServers});
}

class IceCheckerFlutterWebrtcImpl implements IceChecker {
  const IceCheckerFlutterWebrtcImpl();

  @override
  Stream<CandidateInfo> gatherCandidates({required List<Map<String, dynamic>> iceServers}) {
    RTCPeerConnection? pc;

    final controller = StreamController<CandidateInfo>(
      onCancel: () async {
        await pc?.close();
        pc = null;
      },
    );

    Future<void> start() async {
      pc = await createPeerConnection({'iceServers': iceServers});

      pc!.onIceCandidate = (candidate) {
        if (controller.isClosed) return;
        if (candidate.candidate == null || candidate.candidate!.isEmpty) return;
        final info = _parseCandidate(candidate);
        if (!info.isLoopback) controller.add(info);
      };

      pc!.onIceGatheringState = (gatheringState) async {
        if (gatheringState == RTCIceGatheringState.RTCIceGatheringStateComplete) {
          await pc?.close();
          pc = null;
          controller.close();
        }
      };

      final offer = await pc!.createOffer({
        'mandatory': {'OfferToReceiveAudio': true, 'OfferToReceiveVideo': false},
      });
      await pc!.setLocalDescription(offer);
    }

    start().catchError(controller.addError);
    return controller.stream;
  }

  CandidateInfo _parseCandidate(RTCIceCandidate candidate) {
    // SDP candidate format (RFC 5245):
    // candidate:<foundation> <component> <transport> <priority> <address> <port>
    //   typ <type> [raddr <raddr>] [rport <rport>] [key value ...]
    final parts = candidate.candidate!.split(' ');
    final address = parts[4];
    final ext = <String, String>{};
    for (var i = 8; i + 1 < parts.length; i += 2) {
      ext[parts[i]] = parts[i + 1];
    }
    return CandidateInfo(
      mid: candidate.sdpMid ?? '',
      type: IceType.values.firstWhere((element) => element.name == parts[7], orElse: () => IceType.other),
      foundation: parts[0].contains(':') ? parts[0].split(':')[1] : parts[0],
      transport: parts[2].toLowerCase() == 'udp' ? IceTransport.udp : IceTransport.tcp,
      priority: parts[3],
      address: address,
      port: int.parse(parts[5]),
      network: address.contains(':') ? IceNetwork.ipv6 : IceNetwork.ipv4,
      generation: int.tryParse(ext['generation'] ?? '') ?? 0,
      usernameFragment: ext['ufrag'] ?? '',
      networkCost: ext['network-cost'] ?? '',
      relatedAddress: ext['raddr'] ?? '',
      relatedPort: int.tryParse(ext['rport'] ?? '') ?? 0,
      protocol: ext['tcptype'] ?? '',
    );
  }
}

enum IceTransport { udp, tcp }

enum IceNetwork { ipv4, ipv6 }

enum IceType { host, srflx, relay, prflx, other }

class CandidateInfo extends Equatable {
  CandidateInfo({
    required this.mid,
    required this.type,
    required this.transport,
    required this.network,
    required this.address,
    required this.port,
    required this.generation,
    required this.usernameFragment,
    required this.priority,
    required this.networkCost,
    required this.foundation,
    required this.relatedAddress,
    required this.relatedPort,
    required this.protocol,
  });

  final String mid;
  final IceType type;
  final IceTransport transport;
  final IceNetwork network;
  final int port;
  final String address;
  final int generation;
  final String usernameFragment;
  final String priority;
  final String networkCost;
  final String foundation;
  final String relatedAddress;
  final int relatedPort;
  final String protocol;

  late final isLoopback = address == '127.0.0.1' || address.startsWith('127.') || address == '::1';

  @override
  List<Object?> get props => [
    mid,
    type,
    transport,
    network,
    address,
    port,
    priority,
    generation,
    usernameFragment,
    networkCost,
    foundation,
    relatedAddress,
    relatedPort,
    protocol,
  ];

  @override
  String toString() {
    return 'CandidateInfo:'
        'mid: $mid, '
        'type: ${type.name}, '
        'transport: ${transport.name}, '
        'network: ${network.name}, '
        'address: $address, '
        'port: $port, '
        'generation: $generation, '
        'usernameFragment: $usernameFragment, '
        'priority: $priority, '
        'networkCost: $networkCost, '
        'foundation: $foundation, '
        'relatedAddress: $relatedAddress, '
        'relatedPort: $relatedPort, '
        'protocol: $protocol';
  }
}
