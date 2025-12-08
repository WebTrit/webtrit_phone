import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../models/models.dart';
import '../utils/utils.dart';

part 'embedded_state.dart';

part 'embedded_cubit.freezed.dart';

final _logger = Logger('EmbeddedCubit');

class EmbeddedCubit extends Cubit<EmbeddedState> {
  EmbeddedCubit({
    required this.payload,
    required PrivateGatewayRepository? customPrivateGatewayRepository,
    required this.embeddedPayloadBuilder,
  }) : _customPrivateGatewayRepository = customPrivateGatewayRepository,
       super(const EmbeddedState()) {
    _init();
  }

  /// Timer used to debounce connectivity handling logic and to schedule payload reload retries.
  /// Cancelled and restarted each time a new connectivity event is received before the debounce completes,
  /// or when a payload reload retry is scheduled after a failure.
  Timer? _payloadReloadDebounceTimer;

  // May be null if the embedded page is launched outside the main app routes.
  final PrivateGatewayRepository? _customPrivateGatewayRepository;
  final EmbeddedPayloadBuilder embeddedPayloadBuilder;
  final List<EmbeddedPayloadData> payload;

  static const int _maxRetryAttempts = 3;
  int _retryCount = 0;

  bool get isExternalPageTokenRequired => payload.contains(EmbeddedPayloadData.externalPageToken);

  bool get isSupportExternalPageToken => _customPrivateGatewayRepository?.isSupportedExternalPageTokenEndpoint ?? false;

  Future<void> _init() async {
    await _loadPayload();
  }

  Future<void> _loadPayload() async {
    if (isExternalPageTokenRequired) {
      await _tryFetchExternalPageToken(_customPrivateGatewayRepository!);
    }
    // Fetches the self-config and builds the payload.
    _updatePayload();
  }

  Future<void> _tryFetchExternalPageToken(PrivateGatewayRepository customPrivateGatewayRepository) async {
    // Check if the external page token is already stored in secure storage or still not expired.
    final isExternalPageTokenAvailable = await customPrivateGatewayRepository.isExternalPageTokenAvailable();

    if (!isExternalPageTokenAvailable) {
      await customPrivateGatewayRepository.fetchExternalPageToken();
    } else {
      _logger.info('External page token is already available, skipping fetch.');
    }
  }

  void _updatePayload() {
    try {
      final payloadData = embeddedPayloadBuilder.build(payload);
      emit(state.copyWith(payload: payloadData));
    } on ExternalPageTokenUnavailableException catch (_) {
      _handleExternalPageTokenUnavailable();
    } catch (e, s) {
      _logger.severe(e, s);
    }
  }

  /// Called when the external page token is unavailable.
  void _handleExternalPageTokenUnavailable() {
    _logger.warning('ExternalPageTokenUnavailableException, retrying...');

    if (isSupportExternalPageToken && _retryCount < _maxRetryAttempts) {
      _retryCount++;
      _logger.warning('ExternalPageTokenUnavailableException, retrying ($_retryCount/$_maxRetryAttempts)...');

      _payloadReloadDebounceTimer?.cancel();
      _payloadReloadDebounceTimer = Timer(const Duration(seconds: 5), () {
        _loadPayload();
      });
    } else {
      _logger.severe('ExternalPageTokenUnavailableException after max retries');
    }
  }

  /// Called when the URL changes in the WebView.
  void onUrlChange(String url) {
    _logger.info('URL changed: $url');
    emit(state.copyWith(currentUrl: url));
  }

  /// Called when the WebView's back navigation state changes.
  void onCanGoBackChange(bool canGoBack) {
    _logger.info('Can go back changed: $canGoBack');
    emit(state.copyWith(canGoBack: canGoBack));
  }

  @override
  Future<void> close() async {
    _payloadReloadDebounceTimer?.cancel();
    return super.close();
  }
}
