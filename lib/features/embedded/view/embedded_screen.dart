import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../login/features/login_signup/widgets/widgets.dart';
import '../bloc/embedded_cubit.dart';

final _logger = Logger('EmbeddedScreen');

class EmbeddedScreen extends StatefulWidget {
  const EmbeddedScreen({
    required this.initialUri,
    required this.appBar,
    this.shouldForwardPop = true,
    this.enableConsoleLogCapture,
    required this.connectivityRecoveryStrategyBuilder,
    required this.pageInjectionStrategyBuilder,
    super.key,
  });

  final Uri initialUri;
  final PreferredSizeWidget appBar;

  /// If true, the console log will be captured and forwarded to the logger.
  final bool? enableConsoleLogCapture;

  /// If true, the pop action will be forwarded to the WebView if backstack is available.
  final bool shouldForwardPop;

  /// Builder for creating the page injection strategy.
  final PageInjectionStrategyBuilder pageInjectionStrategyBuilder;

  /// Builder for creating the connectivity recovery strategy.
  final ConnectivityRecoveryStrategyBuilder connectivityRecoveryStrategyBuilder;

  @override
  State<EmbeddedScreen> createState() => _EmbeddedScreenState();
}

class _EmbeddedScreenState extends State<EmbeddedScreen> {
  late final _webViewController = WebViewController();
  late final ConnectivityRecoveryStrategy _connectivityRecoveryStrategy;
  late final PageInjectionStrategy _pageInjectionStrategy;

  EmbeddedCubit get _cubit => context.read<EmbeddedCubit>();

  @override
  void initState() {
    _pageInjectionStrategy = widget.pageInjectionStrategyBuilder();
    _connectivityRecoveryStrategy = widget.connectivityRecoveryStrategyBuilder();
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
            onPopInvokedWithResult: (_, __) => _webViewController.goBack(),
            canPop: forwardPop == false,
            child: WebViewContainer(
              initialUri: widget.initialUri,
              webViewController: _webViewController,
              connectivityRecoveryStrategy: _connectivityRecoveryStrategy,
              pageInjectionStrategies: [_pageInjectionStrategy],
              showToolbar: false,
              enableEmbeddedLogging: widget.enableConsoleLogCapture ?? false,
              userAgent: UserAgent.of(context),
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

    if (_cubit.isClosed || !mounted) {
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
