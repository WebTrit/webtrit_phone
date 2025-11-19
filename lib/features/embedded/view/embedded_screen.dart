import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../login/features/login_signup/widgets/widgets.dart';
import '../bloc/embedded_cubit.dart';

final _logger = Logger('EmbeddedScreen');

class EmbeddedScreen extends StatefulWidget {
  const EmbeddedScreen({
    required this.initialUri,
    required this.userAgent,
    required this.mediaQueryMetricsData,
    required this.deviceInfoData,
    required this.appBar,
    required this.connectivityRecoveryStrategyBuilder,
    required this.pageInjectionStrategyBuilder,
    this.shouldForwardPop = true,
    this.enableLogCapture = true,
    super.key,
  });

  final Uri initialUri;
  final String userAgent;
  final MediaQueryMetrics? mediaQueryMetricsData;
  final Map<String, String>? deviceInfoData;
  final PreferredSizeWidget appBar;

  /// Builder for creating the page injection strategy.
  final PageInjectionStrategyBuilder pageInjectionStrategyBuilder;

  /// Builder for creating the connectivity recovery strategy.
  final ConnectivityRecoveryStrategyBuilder connectivityRecoveryStrategyBuilder;

  /// If true, the console log will be captured and forwarded to the logger.
  final bool enableLogCapture;

  /// If true, the pop action will be forwarded to the WebView if backstack is available.
  final bool shouldForwardPop;

  @override
  State<EmbeddedScreen> createState() => _EmbeddedScreenState();
}

class _EmbeddedScreenState extends State<EmbeddedScreen> {
  late final _webViewController = WebViewController();
  late final ConnectivityRecoveryStrategy _connectivityRecoveryStrategy;
  late final PageInjectionStrategy _pageInjectionStrategy;

  late final List<JSChannelStrategy> _jSChannelStrategies;
  late final List<PageInjectionStrategy> _pageInjectionStrategies;

  EmbeddedCubit get _cubit => context.read<EmbeddedCubit>();

  @override
  void initState() {
    _pageInjectionStrategy = widget.pageInjectionStrategyBuilder();
    _connectivityRecoveryStrategy = widget.connectivityRecoveryStrategyBuilder();

    // TODO: Add to embedded configuration possibly disable media query injection and/or device info injection.
    _pageInjectionStrategies = PageInjectionBuilders.resolve(
      mediaQueryMetricsData: widget.mediaQueryMetricsData,
      deviceInfoData: widget.deviceInfoData,
      custom: [_pageInjectionStrategy],
    );

    _jSChannelStrategies = JSChannelBuilders.resolve(enableLogCapture: widget.enableLogCapture);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: BlocConsumer<EmbeddedCubit, EmbeddedState>(
        builder: (context, state) {
          final forwardPop = widget.shouldForwardPop && state.canGoBack;

          return PopScope(
            onPopInvokedWithResult: (_, _) => _webViewController.goBack(),
            canPop: forwardPop == false,
            child: WebViewContainer(
              initialUri: widget.initialUri,
              webViewController: _webViewController,
              connectivityRecoveryStrategy: _connectivityRecoveryStrategy,
              pageInjectionStrategies: _pageInjectionStrategies,
              jSChannelStrategies: _jSChannelStrategies,
              showToolbar: false,
              userAgent: widget.userAgent,
              errorBuilder: _buildErrorBuilder(),
              onUrlChange: _handleUrlChange,
            ),
          );
        },
        listener: _onBlocStateChanged,
      ),
    );
  }

  /// Handles WebView URL changes.
  ///
  /// - Used to support system back navigation via `PopScope`.
  Future<void> _handleUrlChange(String? url) async {
    final canGoBack = await _webViewController.canGoBack();

    if (!mounted || _cubit.isClosed) {
      _logger.finest('EmbeddedScreen is closed or not mounted, ignoring URL change: $url');
      return;
    }

    _cubit.onUrlChange(url ?? '');
    _cubit.onCanGoBackChange(canGoBack);
  }

  /// Returns a native error dialog builder unless:
  /// - the page loaded successfully at least once, and
  /// - the strategy is [ReconnectStrategy.notifyOnly].
  ///
  /// This ensures SPA apps can self-recover via JS after reconnect.
  Widget Function(BuildContext, WebResourceError, WebViewController)? _buildErrorBuilder() {
    if (_connectivityRecoveryStrategy.hasSuccessfulLoad &&
        _connectivityRecoveryStrategy.strategy == ReconnectStrategy.notifyOnly) {
      return null;
    }

    return (context, error, controller) => EmbeddedRequestErrorDialog(
      title: error.titleL10n(context),
      error: error.messageL10n(context),
      onRetry: () => _webViewController.reload(),
    );
  }

  void _onBlocStateChanged(BuildContext context, EmbeddedState state) {
    _logger.info('onBlocStateChanged: $state');

    if (state.isReadyToInjectedScript) _pageInjectionStrategy.setPayload(state.payload);
    if (state.isReloadWebView) _webViewController.reload();
  }
}
