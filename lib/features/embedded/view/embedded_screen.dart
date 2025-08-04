import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../bloc/embedded_cubit.dart';

final _logger = Logger('EmbeddedScreen');

class EmbeddedScreen extends StatefulWidget {
  const EmbeddedScreen({
    required this.initialUri,
    required this.appBar,
    this.shouldForwardPop = true,
    super.key,
  });

  final Uri initialUri;
  final PreferredSizeWidget appBar;

  /// If true, the pop action will be forwarded to the WebView if backstack is available.
  final bool shouldForwardPop;

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
    final connectivityStream = Connectivity().onConnectivityChanged;

    _connectivityRecoveryStrategy = SoftReloadRecoveryStrategy(connectivityStream: connectivityStream);
    _pageInjectionStrategy = DefaultPayloadInjectionStrategy();

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
              // TODO: Move to environment config
              enableEmbeddedLogging: true,
              userAgent: UserAgent.of(context),
              onUrlChange: (url) async {
                _cubit.onUrlChange(url ?? '');
                final canGoBack = await _webViewController.canGoBack();
                if (mounted) _cubit.onCanGoBackChange(canGoBack);
              },
              errorBuilder: (context, error, controller) {
                return EmbeddedRequestError(error: error);
              },
            ),
          );
        },
        listener: _onBlocStateChanged,
      ),
    );
  }

  void _onBlocStateChanged(BuildContext context, EmbeddedState state) {
    _logger.info('onBlocStateChanged: $state');

    if (state.isReadyToInjectedScript) _pageInjectionStrategy.setPayload(state.payload);
    if (state.isReloadWebView) _webViewController.reload();
  }
}
