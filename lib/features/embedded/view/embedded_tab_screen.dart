import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/models/main_flavor.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webtrit_phone/repositories/route_state/main_screen_route_state_repository.dart';

import '../bloc/embedded_cubit.dart';

final _logger = Logger('EmbeddedTabScreen');

class EmbeddedTabScreen extends StatefulWidget {
  const EmbeddedTabScreen({
    super.key,
    required this.initialUri,
    required this.appBar,
  });

  final Uri initialUri;

  final PreferredSizeWidget appBar;

  @override
  State<EmbeddedTabScreen> createState() => _EmbeddedTabScreenState();
}

class _EmbeddedTabScreenState extends State<EmbeddedTabScreen> {
  late final _webViewController = WebViewController();
  late final _bloc = context.read<EmbeddedCubit>();
  StreamSubscription? _tabSub;
  bool _isTabActive = false;

  @override
  void initState() {
    super.initState();
    _tabSub = context.read<MainScreenRouteStateRepository>().activeFlavorTabStream.listen((flavor) {
      if (mounted) setState(() => _isTabActive = flavor == MainFlavor.embedded);
    });
  }

  @override
  void dispose() {
    _tabSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: BlocConsumer<EmbeddedCubit, EmbeddedState>(
        builder: (context, state) {
          final canGoBack = state.canGoBack;
          return PopScope(
            onPopInvokedWithResult: (didPop, result) async {
              if (_isTabActive && canGoBack) _webViewController.goBack();
            },
            canPop: canGoBack && _isTabActive ? false : true,
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
