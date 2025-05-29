import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    required CustomPrivateGatewayRepository? customPrivateGatewayRepository,
    required this.embeddedPayloadBuilder,
  })  : _customPrivateGatewayRepository = customPrivateGatewayRepository,
        super(const EmbeddedState()) {
    _init();
  }

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  /// Debounce duration for handling connectivity change events.
  /// Prevents excessive reloads when multiple connectivity events occur in quick succession.
  static const Duration _networkDebounceDuration = Duration(milliseconds: 500);

  /// Timer used to debounce connectivity handling logic.
  /// Cancelled and restarted each time a new connectivity event is received before the debounce completes.
  Timer? _connectivityDebounceTimer;

  // May be null if the embedded page is launched outside the main app routes.
  final CustomPrivateGatewayRepository? _customPrivateGatewayRepository;
  final EmbeddedPayloadBuilder embeddedPayloadBuilder;
  final List<EmbeddedPayloadData> payload;

  static const int _maxRetryAttempts = 3;
  int _retryCount = 0;

  bool get isExternalPageTokenRequired => payload.contains(EmbeddedPayloadData.externalPageToken);

  bool get isSupportExternalPageToken => _customPrivateGatewayRepository?.isSupportedExternalPageTokenEndpoint ?? false;

  Future<void> _init() async {
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
    await _loadPayload();
  }

  Future<void> _loadPayload() async {
    if (isExternalPageTokenRequired) {
      await _tryFetchExternalPageToken(_customPrivateGatewayRepository!);
    }
    // Fetches the self-config and builds the payload.
    _updatePayload();
  }

  Future<void> _handleConnectivity(List<ConnectivityResult> result) async {
    if (result.isEmpty || result.every((r) => r == ConnectivityResult.none)) return;

    await reload();
  }

  Future<void> _tryFetchExternalPageToken(CustomPrivateGatewayRepository customPrivateGatewayRepository) async {
    // Check if the external page token is already stored in secure storage or still not expired.
    final isExternalPageTokenAvailable = await customPrivateGatewayRepository.isExternalPageTokenAvailable();

    if (!isExternalPageTokenAvailable) {
      await customPrivateGatewayRepository.fetchExternalPageToken();
    }
  }

  void _updatePayload() {
    try {
      final payloadData = embeddedPayloadBuilder.build(payload);
      emit(state.copyWith(payload: payloadData, payloadReady: true));
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
      Future.delayed(const Duration(seconds: 5), () {
        _loadPayload();
      });
    } else {
      _logger.severe('ExternalPageTokenUnavailableException after max retries');
      emit(state.copyWith(webViewReady: false));
    }
  }

  /// Debounced reload of the embedded page and payload data.
  ///
  /// Cancels any pending reload operation and schedules a new one after a short delay.
  /// If the WebView is not ready, emits a reload intent. If the payload is not ready,
  /// it triggers loading of the payload.
  ///
  /// This method helps avoid redundant reload attempts when multiple connectivity changes
  /// or error states occur in rapid succession.
  Future<void> reload() async {
    _connectivityDebounceTimer?.cancel();

    _connectivityDebounceTimer = Timer(_networkDebounceDuration, () async {
      _retryCount = 0;

      if (!state.webViewReady) {
        _logger.info('Page not loaded yet or error present, reloading...');
        emit(state.copyWith(intent: EmbeddedIntents.reloadWebView));
        emit(state.copyWith(intent: null));
      }

      if (!state.payloadReady) {
        _logger.info('Payload not ready, reloading...');
        await _loadPayload();
      }
    });
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
    _connectivityDebounceTimer?.cancel();
    await _connectivitySub?.cancel();
    return super.close();
  }
}
