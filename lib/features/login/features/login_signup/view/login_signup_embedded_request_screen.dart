import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/widgets/webview_progress_indicator.dart';
import 'package:webtrit_phone/features/features.dart';

import '../widgets/embedded_request_error.dart';

const _loginJavascriptChannelName = 'WebtritLoginChannel';

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
  final _webViewController = WebViewController();
  final _progressStreamController = StreamController<int>.broadcast();

  WebResourceError? _latestError;
  WebResourceError? _currentError;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);

      _webViewController.addJavaScriptChannel(
        _loginJavascriptChannelName,
        onMessageReceived: _onJavaScriptMessageReceived,
      );

      // Ensure NavigationDelegate callbacks are only triggered if the widget is still mounted.
      // This prevents potential errors caused by invoking callbacks after the widget has been disposed.
      _webViewController.setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => mounted ? _onPageFinishedNavigationDelegate() : null,
        onProgress: (progress) => mounted ? _onProgressNavigationDelegate(progress) : null,
        onWebResourceError: (error) => mounted ? _onWebResourceErrorNavigationDelegate(error) : null,
      ));
    }

    _webViewController.loadRequest(Uri.parse(widget.initialUrl.toString()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!kIsWeb) {
      _webViewController.setBackgroundColor(Colors.transparent);
    }
  }

  @override
  void dispose() {
    _progressStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.processing != current.processing,
      builder: (context, state) {
        final hasWebViewError = _latestError != null;

        return Stack(alignment: AlignmentDirectional.topCenter, children: [
          if (hasWebViewError)
            EmbeddedRequestError(error: _latestError!)
          else
            WebViewWidget(controller: _webViewController),
          WebViewProgressIndicator(stream: _progressStreamController.stream),
        ]);
      },
      listener: (BuildContext context, LoginState state) {
        if (state.processing) {
          _webViewController.runJavaScript('showProgress();');
        } else {
          _webViewController.runJavaScript('hideProgress();');
        }
      },
    );
  }

  // WebView navigation delegates
  void _onPageFinishedNavigationDelegate() {
    final currentLocale = Localizations.localeOf(context);
    _webViewController.runJavaScript('setLocale("${currentLocale.languageCode}");');

    if (_currentError == null) _latestError = null;
    setState(() {
      _currentError = null;
    });
  }

  void _onProgressNavigationDelegate(int progress) {
    if (!_progressStreamController.isClosed) {
      _progressStreamController.add(progress);
    }
  }

  void _onWebResourceErrorNavigationDelegate(WebResourceError error) {
    setState(() {
      _currentError = error;
      _latestError = error;
    });
  }

  void _onJavaScriptMessageReceived(JavaScriptMessage message) {
    try {
      final decodedMessage = jsonDecode(message.message);
      final event = decodedMessage['event'];
      final data = decodedMessage['data'];

      if (event == 'signup') {
        _webViewController.runJavaScript('showProgress();');
        context.read<LoginCubit>().loginCustomSignupRequest(data);
      }
    } catch (e) {
      _logger.severe('Error decoding message', e);
    }
  }
}
