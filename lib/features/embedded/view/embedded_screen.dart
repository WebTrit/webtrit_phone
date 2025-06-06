import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

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
  late final _bloc = context.read<EmbeddedCubit>();

  // TODO(JohnBorys): Replace WebViewScaffold with WebViewContainer after testing is complete

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
            child: WebViewScaffold(
              initialUri: widget.initialUri,
              webViewController: _webViewController,
              showToolbar: false,
              userAgent: UserAgent.of(context),
              onPageLoadedSuccess: _bloc.onPageLoadedSuccess,
              onPageLoadedFailed: _bloc.onPageLoadedFailed,
              onUrlChange: (url) async {
                _bloc.onUrlChange(url ?? '');
                final canGoBack = await _webViewController.canGoBack();
                if (mounted) _bloc.onCanGoBackChange(canGoBack);
              },
              errorBuilder: (context, error, controller) {
                return EmbeddedRequestError(error: error, onPressed: () => _bloc.reload());
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

    if (state.isReadyToInjectedScript) _webViewController.runJavaScript(_buildInjectedScript(state.payload));
    if (state.isReloadWebView) _webViewController.reload();
  }

  String _buildInjectedScript(Map<String, dynamic> data) {
    final jsonString = const JsonEncoder().convert(data);
    return '''
    if (typeof window.onPayloadDataReady === 'function') {
      window.onPayloadDataReady($jsonString);
    }
  ''';
  }
}
