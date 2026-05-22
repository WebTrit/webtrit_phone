part of 'network_tester_cubit.dart';

enum IceGatheringStatus { initial, gathering, complete }

class NetworkTesterState extends Equatable {
  const NetworkTesterState({
    this.candidates = const [],
    this.networks = const [],
    this.gatheringStatus = IceGatheringStatus.initial,
  });

  final List<CandidateInfo> candidates;
  final List<ConnectivityResult> networks;
  final IceGatheringStatus gatheringStatus;

  Iterable<CandidateInfo> get effectiveCandidates => candidates.where((c) => c.isLoopback == false);

  NetworkTesterState copyWith({
    List<CandidateInfo>? candidates,
    List<ConnectivityResult>? networks,
    IceGatheringStatus? gatheringStatus,
  }) => NetworkTesterState(
    candidates: candidates ?? this.candidates,
    networks: networks ?? this.networks,
    gatheringStatus: gatheringStatus ?? this.gatheringStatus,
  );

  @override
  List<Object?> get props => [candidates, networks, gatheringStatus];
}
