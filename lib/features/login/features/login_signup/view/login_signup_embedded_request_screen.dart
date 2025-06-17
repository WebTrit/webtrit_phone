import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('LoginSignupEmbeddedRequestScreen');

class LoginSignupEmbeddedRequestScreen extends StatefulWidget {
  const LoginSignupEmbeddedRequestScreen({
    super.key,
    required this.initialUrl,
  });

  final Uri initialUrl;

  @override
  State<LoginSignupEmbeddedRequestScreen> createState() => _LoginSignupEmbeddedRequestScreenState();
}

class _LoginSignupEmbeddedRequestScreenState extends State<LoginSignupEmbeddedRequestScreen> {
  final WebViewController _webViewController = WebViewController();

  bool _canGoBack = false;

  static const _jsChannelName = 'WebtritLoginChannel';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_canGoBack,
      onPopInvokedWithResult: (_, __) => _webViewController.goBack(),
      child: WebViewContainer(
        initialUri: widget.initialUrl,
        webViewController: _webViewController,
        showToolbar: false,
        userAgent: UserAgent.of(context),
        javaScriptChannels: {
          _jsChannelName: _onJavaScriptMessageReceived,
        },
        onPageLoadedSuccess: _onPageLoadedSuccess,
        onPageLoadedFailed: _onPageLoadedFailed,
        onUrlChange: _onUrlChange,
        errorBuilder: (context, error, controller) => EmbeddedRequestError(
          error: error,
          onPressed: () => _webViewController.reload(),
        ),
      ),
    );
  }

  void _onPageLoadedSuccess() {
    _logger.fine('Web page loaded successfully');

    final locale = Localizations.localeOf(context).languageCode;

    final script = '''
      if (typeof window.setLocale === 'function') {
        window.setLocale("$locale");
      }
    ''';

    _webViewController.runJavaScript(script);
  }

  void _onPageLoadedFailed(WebResourceError error) {
    _logger.warning('Failed to load page: $error');
  }

  void _onUrlChange(String? url) async {
    final canGoBack = await _webViewController.canGoBack();
    if (mounted) {
      setState(() {
        _canGoBack = canGoBack;
      });
    }
  }

  void _onJavaScriptMessageReceived(JavaScriptMessage message) {
    try {
      final decoded = jsonDecode(message.message);
      final event = decoded['event'];
      final data = decoded['data'];
      final embeddedCallbackData = decoded['callback'];

      if (event == 'signup') {
        _webViewController.runJavaScript('showProgress();');
        context.read<LoginCubit>().loginCustomSignupRequest(data, embeddedCallbackData);
      }
    } catch (e, st) {
      _logger.severe('Error decoding message', e, st);
    }
  }
}
