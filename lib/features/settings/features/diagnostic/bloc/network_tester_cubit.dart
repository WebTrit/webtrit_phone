import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/utils/utils.dart';

part 'network_tester_state.dart';

class NetworkTesterCubit extends Cubit<NetworkTesterState> {
  NetworkTesterCubit({this.iceServers = _defaultIceServers, required this.iceChecker})
    : super(const NetworkTesterState()) {
    Connectivity().checkConnectivity().then(_onConnectivityChanged);
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  static const _defaultIceServers = [
    {'url': 'stun:stun.l.google.com:19302'},
  ];

  final List<Map<String, dynamic>> iceServers;
  final IceChecker iceChecker;
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

    _gatherSub = iceChecker
        .gatherCandidates(iceServers: iceServers)
        .listen(
          (candidate) => emit(state.copyWith(candidates: [...state.candidates, candidate])),
          onDone: () => emit(state.copyWith(gatheringStatus: IceGatheringStatus.complete)),
          onError: (Object e) => emit(state.copyWith(gatheringStatus: IceGatheringStatus.complete)),
        );
  }

  @override
  Future<void> close() async {
    await _connectivitySub.cancel();
    await _gatherSub?.cancel();
    return super.close();
  }
}
