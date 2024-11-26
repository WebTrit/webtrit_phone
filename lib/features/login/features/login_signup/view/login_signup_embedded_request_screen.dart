import 'dart:async';
import 'dart:convert';

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
  final _controller = WebViewController();
  final _progressStreamController = StreamController<int>.broadcast();

  WebResourceError? _latestError;
  WebResourceError? _currentError;

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.addJavaScriptChannel(
      _loginJavascriptChannelName,
      onMessageReceived: _onJavaScriptMessageReceived,
    );
    _controller.loadRequest(Uri.parse(widget.initialUrl.toString()));
    _controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (_) {
        _setWebViewLocale();
        if (_currentError == null) _latestError = null;
        setState(() {
          _currentError = null;
        });
      },
      onProgress: (progress) => _progressStreamController.add(progress),
      onWebResourceError: (error) {
        setState(() {
          _currentError = error;
          _latestError = error;
        });
      },
    ));
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
          if (hasWebViewError) EmbeddedRequestError(error: _latestError!) else WebViewWidget(controller: _controller),
          WebViewProgressIndicator(stream: _progressStreamController.stream),
        ]);
      },
      listener: (BuildContext context, LoginState state) {
        if (state.processing) {
          _controller.runJavaScript('showProgress();');
        } else {
          _controller.runJavaScript('hideProgress();');
        }
      },
    );
  }

  void _setWebViewLocale() {
    Locale currentLocale = Localizations.localeOf(context);
    _controller.runJavaScript('setLocale("${currentLocale.languageCode}");');
  }

  void _onJavaScriptMessageReceived(JavaScriptMessage message) {
    try {
      final decodedMessage = jsonDecode(message.message);
      final event = decodedMessage['event'];
      final data = decodedMessage['data'];

      if (event == 'signup') {
        _controller.runJavaScript('showProgress();');
        context.read<LoginCubit>().loginCustomSignupRequest(data);
      }
    } catch (e) {
      _logger.severe('Error decoding message', e);
    }
  }
}
