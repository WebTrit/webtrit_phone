import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/call/utils/peer_connection_factory.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'network_tester_state.dart';

class NetworkTesterCubit extends Cubit<NetworkTesterState> {
  NetworkTesterCubit({required this.iceChecker, IceServersResolver? iceServersResolver, Connectivity? connectivity})
    : _iceServersResolver = iceServersResolver,
      _connectivity = connectivity ?? Connectivity(),
      super(const NetworkTesterState()) {
    _connectivity.checkConnectivity().then(_onConnectivityChanged);
    _connectivitySub = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  /// Resolves the deployment's own ICE servers, so the gathered candidates
  /// reflect the servers a real call would use. `null` falls back to the public
  /// STUN server.
  final IceServersResolver? _iceServersResolver;

  final IceChecker iceChecker;
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;
  StreamSubscription<CandidateInfo>? _gatherSub;

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    emit(state.copyWith(networks: results));
    refresh();
  }

  Future<void> refresh() async {
    if (isClosed) return;

    await _gatherSub?.cancel();
    _gatherSub = null;
    emit(state.copyWith(candidates: const [], gatheringStatus: IceGatheringStatus.gathering));

    final connectedToAnyNetwork = state.networks.any((net) => net != ConnectivityResult.none);
    if (!connectedToAnyNetwork) {
      emit(state.copyWith(gatheringStatus: IceGatheringStatus.complete));
      return;
    }

    final iceServers = await _resolveIceServers();
    if (isClosed) return;

    _gatherSub = iceChecker
        .gatherCandidates(iceServers: iceServers)
        .listen(
          (candidate) => emit(state.copyWith(candidates: [...state.candidates, candidate])),
          onDone: () => emit(state.copyWith(gatheringStatus: IceGatheringStatus.complete)),
          onError: (Object e) => emit(state.copyWith(gatheringStatus: IceGatheringStatus.complete)),
        );
  }

  Future<List<Map<String, dynamic>>> _resolveIceServers() async {
    final resolver = _iceServersResolver;
    if (resolver == null) return kFallbackRtcIceServers;

    final iceServers = await resolver();
    return iceServers.isEmpty ? kFallbackRtcIceServers : iceServers;
  }

  @override
  Future<void> close() async {
    await _connectivitySub.cancel();
    await _gatherSub?.cancel();
    return super.close();
  }
}
