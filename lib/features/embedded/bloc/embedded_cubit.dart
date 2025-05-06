import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/utils.dart';

part 'embedded_state.dart';

part 'embedded_cubit.freezed.dart';

final _logger = Logger('EmbeddedCubit');

class EmbeddedCubit extends Cubit<EmbeddedState> {
  EmbeddedCubit({
    required this.payload,
    required CustomPrivateGatewayRepository? customPrivateGatewayRepository,
    required this.embeddedPayloadBuilder,
  })  : _customPrivateGatewayRepository = customPrivateGatewayRepository,
        super(const EmbeddedState()) {
    _init();
  }

  // May be null if the embedded page is launched outside the main app routes.
  final CustomPrivateGatewayRepository? _customPrivateGatewayRepository;
  final EmbeddedPayloadBuilder embeddedPayloadBuilder;
  final List<EmbeddedPayloadData> payload;

  // True if the payload requires an externalPageToken and a valid SelfConfigRepository is available for the route.
  bool get isExternalPageTokenRequired =>
      payload.contains(EmbeddedPayloadData.externalPageToken) && _customPrivateGatewayRepository != null;

  Future<void> _init() async {
    if (isExternalPageTokenRequired) {
      await _tryFetchExternalPageToken(_customPrivateGatewayRepository!);
    }
    // Fetches the self-config and builds the payload.
    _updatePayload();
  }

  Future<void> _tryFetchExternalPageToken(CustomPrivateGatewayRepository customPrivateGatewayRepository) async {
    // Check if the external page token is already stored in secure storage or still not expired.
    final isExternalPageTokenAvailable = await customPrivateGatewayRepository.isExternalPageTokenAvailable();

    if (!isExternalPageTokenAvailable) {
      await customPrivateGatewayRepository.fetchExternalPageToken();
    }
  }

  void _updatePayload() {
    _logger.info('Updating payload: $payload');
    final payloadData = embeddedPayloadBuilder.build(payload);
    emit(state.copyWith(payload: payloadData, payloadReady: true));
  }

  ///  Called when the page is loaded successfully and ready to be injected with JS.
  void onPageLoadedSuccess() {
    _logger.info('Page loaded successfully');
    emit(state.copyWith(webViewReady: true));
  }

  /// Called when the page fails to load.
  void onPageLoadedFailed(WebResourceError error) {
    _logger.warning('Page loaded with error');
    emit(state.copyWith(webViewReady: false, webResourceError: error));
  }
}
