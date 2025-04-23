import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../utils/utils.dart';

part 'embedded_state.dart';

part 'embedded_cubit.freezed.dart';

class EmbeddedCubit extends Cubit<EmbeddedState> {
  EmbeddedCubit({
    required this.payload,
    required this.selfConfigRepository,
    required this.embeddedPayloadBuilder,
  }) : super(const EmbeddedState()) {
    _init();
  }

  final SelfConfigRepository selfConfigRepository;
  final EmbeddedPayloadBuilder embeddedPayloadBuilder;
  final List<EmbeddedPayloadData> payload;

  StreamSubscription? _tokenSubscription;

  Future<void> _init() async {
    if (payload.contains(EmbeddedPayloadData.externalPageToken)) {
      await _handleTokenRequirement();
    }

    // Fetches the self-config and builds the payload.
    _updatePayload();
  }

  Future<void> _handleTokenRequirement() async {
    if (!(await selfConfigRepository.isExternalPageTokenAvailable())) {
      await selfConfigRepository.fetchExternalPageToken();
    }

    // Subscribes to token updates and rebuilds the payload when a new token is issued.
    _tokenSubscription = selfConfigRepository.externalPageTokenStream.listen((_) {
      _updatePayload();
    });
  }

  void _updatePayload() {
    final payloadData = embeddedPayloadBuilder.build(payload);
    emit(state.copyWith(status: EmbeddedStateStatus.initial));
    emit(state.copyWith(payload: payloadData, status: EmbeddedStateStatus.ready));
  }

  @override
  Future<void> close() async {
    await _tokenSubscription?.cancel();
    return super.close();
  }
}
