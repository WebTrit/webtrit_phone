import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:auto_route/auto_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../widgets/widgets.dart';

final _logger = Logger('LoginSignupEmbeddedRequestScreen');

const _jsChannelName = 'WebtritLoginChannel';

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

  /// Indicates whether the WebView can navigate back in its history stack.
  /// Used to control PopScope behavior and decide whether to intercept back presses.
  bool _canGoBack = false;

  /// Prevents multiple error dialogs from being shown for the same failure.
  /// Acts as a guard during error state transitions or repeated error emissions from the same source.
  bool _errorDialogShown = false;

  /// Indicates whether the initial page load was successful (likely from cache).
  /// If true, suppresses Flutter-level error UI and delegates error handling to the embedded WebView app itself,
  /// which is typically expected in single-page application scenarios.
  bool _wasPageLoadedSuccessfully = false;

  LoginCubit get _loginCubit => context.read<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (LoginState previous, LoginState current) =>
          previous.embeddedRequestError != current.embeddedRequestError,
      listener: _handleEmbeddedErrorState,
      child: PopScope(
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
          onUrlChange: (_) => _updateCanGoBack(),
          errorBuilder: _buildErrorBuilder(),
        ),
      ),
    );
  }

  /// Returns a WebView error builder that shows a native error dialog,
  /// unless the page was previously loaded successfully (e.g., cached SPA).
  Widget Function(BuildContext, WebResourceError, WebViewController)? _buildErrorBuilder() {
    if (_wasPageLoadedSuccessfully) return null;

    return (context, error, controller) => EmbeddedRequestErrorDialog(
          title: error.titleL10n(context),
          error: error.messageL10n(context),
          onRetry: () => _webViewController.reload(),
        );
  }

  /// Updates the `_canGoBack` state by checking if the WebView can navigate back.
  void _updateCanGoBack() async {
    final canGoBack = await _webViewController.canGoBack();
    if (mounted) {
      setState(() {
        _canGoBack = canGoBack;
      });
    }
  }

  /// Handles the embedded error state by checking if an error is present
  void _handleEmbeddedErrorState(BuildContext context, LoginState state) {
    if (state.embeddedRequestError == null || _errorDialogShown) return;

    _errorDialogShown = true;

    _showEmbeddedErrorDialog(
      context: context,
      error: state.embeddedRequestError!,
      extras: state.embeddedExtras,
      callbackData: state.embeddedCallbackData,
    );
  }

  /// Displays an embedded request error dialog with appropriate localized title/message
  /// depending on the error type (network vs API failure). Dialog shows `Retry` button,
  /// and optionally a `Back` button if the request failed at the API level.
  void _showEmbeddedErrorDialog({
    required BuildContext context,
    required Object error,
    required Map<String, dynamic>? extras,
    required Map<String, dynamic>? callbackData,
  }) {
    final isRequestFailure = error is RequestFailure;

    final title =
        isRequestFailure ? context.l10n.default_TypeErrorError : context.l10n.common_noInternetConnection_title;

    final message = isRequestFailure
        ? (error.error?.message ?? error.toString())
        : context.l10n.common_noInternetConnection_message;

    context.router.pushWidget(
      EmbeddedRequestErrorDialog(
        title: title,
        error: message,
        onRetry: () => _onEmbeddedErrorRetry(extras, callbackData),
        onBack: isRequestFailure ? _onEmbeddedErrorBack : null,
      ),
      transitionBuilder: TransitionsBuilders.slideBottom,
    );
  }

  /// Handles retry action from the embedded error dialog.
  /// Triggers a new embedded login request using previously cached data.
  Future<void> _onEmbeddedErrorRetry(
    Map<String, dynamic>? extras,
    Map<String, dynamic>? callbackData,
  ) async {
    context.router.pop();
    _errorDialogShown = false;

    await _loginCubit.loginCustomSignupRequest(extras, callbackData);
  }

  /// Handles back action from the embedded error dialog.
  /// Tries to navigate back in the WebView, and reloads if no history available.
  Future<void> _onEmbeddedErrorBack() async {
    context.router.pop();
    _errorDialogShown = false;

    _loginCubit.clearEmbeddedRequestError();

    if (!mounted) return;

    final canGoBack = await _webViewController.canGoBack();
    if (canGoBack) {
      _webViewController.goBack();
    } else {
      _webViewController.reload();
    }
  }

  void _onPageLoadedSuccess() {
    _logger.fine('Web page loaded successfully');
    _wasPageLoadedSuccessfully = true;
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

  void _onJavaScriptMessageReceived(JavaScriptMessage message) {
    try {
      final decoded = jsonDecode(message.message);
      // Type of event sent from the embedded page (e.g. 'signup').
      final event = decoded['event'];
      // Payload associated with the event, typically containing user or signup data.
      final data = decoded['data'];
      // Optional callback data that may contain instructions for an additional HTTP request.
      final embeddedCallbackData = decoded['callback'];

      if (event == 'signup' && context.mounted) {
        _loginCubit.loginCustomSignupRequest(data, embeddedCallbackData);
      }
    } catch (e, st) {
      _logger.severe('Error decoding message', e, st);
    }
  }
}
