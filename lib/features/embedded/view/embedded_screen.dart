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
    super.key,
    required this.initialUri,
    required this.appBar,
  });

  final Uri initialUri;

  final PreferredSizeWidget appBar;

  @override
  State<EmbeddedScreen> createState() => _EmbeddedScreenState();
}

class _EmbeddedScreenState extends State<EmbeddedScreen> {
  final WebViewController _webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: BlocConsumer<EmbeddedCubit, EmbeddedState>(
        builder: (context, state) => Stack(
          children: [
            WebViewScaffold(
              initialUri: widget.initialUri,
              webViewController: _webViewController,
              showToolbar: false,
              userAgent: UserAgent.of(context),
              onPageLoadedSuccess: context.read<EmbeddedCubit>().onPageLoadedSuccess,
              onPageLoadedFailed: context.read<EmbeddedCubit>().onPageLoadedFailed,
            )
          ],
        ),
        listener: _onBlocStateChanged,
      ),
    );
  }

  void _onBlocStateChanged(BuildContext context, EmbeddedState state) {
    _logger.info('onBlocStateChanged: $state');

    if (state.isReadyToInjectedScript) _webViewController.runJavaScript(_buildInjectedScript(state.payload));
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
