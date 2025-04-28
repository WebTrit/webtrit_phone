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

  // May be null if the embedded page is launched outside the main app routes.
  final SelfConfigRepository? selfConfigRepository;
  final EmbeddedPayloadBuilder embeddedPayloadBuilder;
  final List<EmbeddedPayloadData> payload;

  // True if the payload requires an externalPageToken and a valid SelfConfigRepository is available for the route.
  bool get isExternalPageTokenRequired =>
      payload.contains(EmbeddedPayloadData.externalPageToken) && selfConfigRepository != null;

  Future<void> _init() async {
    if (isExternalPageTokenRequired) {
      await _tryFetchExternalPageToken(selfConfigRepository!);
    }
    // Fetches the self-config and builds the payload.
    _updatePayload();
  }

  Future<void> _tryFetchExternalPageToken(SelfConfigRepository selfConfigRepository) async {
    // Check if the external page token is already stored in secure storage or still not expired.
    final isExternalPageTokenAvailable = await selfConfigRepository.isExternalPageTokenAvailable();

    if (!isExternalPageTokenAvailable) {
      await selfConfigRepository.fetchExternalPageToken();
    }
  }

  void _updatePayload() {
    final payloadData = embeddedPayloadBuilder.build(payload);
    emit(state.copyWith(status: EmbeddedStateStatus.initial));
    emit(state.copyWith(payload: payloadData, status: EmbeddedStateStatus.ready));
  }
}
