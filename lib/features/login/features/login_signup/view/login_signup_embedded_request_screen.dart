import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/models/models.dart';

import '../widgets/widgets.dart';

class LoginSignupEmbeddedRequestScreen extends StatefulWidget {
  const LoginSignupEmbeddedRequestScreen({
    super.key,
    required this.initialUrl,
    required this.userAgent,
    required this.mediaQueryMetricsData,
    required this.deviceInfoData,
    required this.connectivityRecoveryStrategyBuilder,
    required this.pageInjectionStrategyBuilder,
  });

  final Uri initialUrl;
  final String userAgent;
  final MediaQueryMetrics? mediaQueryMetricsData;
  final Map<String, String>? deviceInfoData;

  /// Builder for creating the page injection strategy.
  final PageInjectionStrategyBuilder pageInjectionStrategyBuilder;

  /// Builder for creating the connectivity recovery strategy.
  final ConnectivityRecoveryStrategyBuilder connectivityRecoveryStrategyBuilder;

  @override
  State<LoginSignupEmbeddedRequestScreen> createState() => _LoginSignupEmbeddedRequestScreenState();
}

class _LoginSignupEmbeddedRequestScreenState extends State<LoginSignupEmbeddedRequestScreen> {
  final WebViewController _webViewController = WebViewController();

  late final ConnectivityRecoveryStrategy _connectivityRecoveryStrategy;

  late final List<JSChannelStrategy> _jSChannelStrategies;
  late final List<PageInjectionStrategy> _pageInjectionStrategies;

  /// Indicates whether the WebView can navigate back in its history stack.
  /// Used to control PopScope behavior and decide whether to intercept back presses.
  bool _canGoBack = false;

  /// Prevents multiple error dialogs from being shown for the same failure.
  /// Acts as a guard during error state transitions or repeated error emissions from the same source.
  bool _errorDialogShown = false;

  LoginCubit get _loginCubit => context.read<LoginCubit>();

  @override
  void initState() {
    _connectivityRecoveryStrategy = widget.connectivityRecoveryStrategyBuilder();

    // TODO: Add to embedded configuration possibly disable media query injection and/or device info injection.
    _pageInjectionStrategies = PageInjectionBuilders.resolve(
      mediaQueryMetricsData: widget.mediaQueryMetricsData,
      deviceInfoData: widget.deviceInfoData,
      custom: [widget.pageInjectionStrategyBuilder()],
    );

    _jSChannelStrategies = JSChannelBuilders.resolve(
      custom: [
        JSChannelStrategy.route(name: 'WebtritLoginChannel', routes: {'signup': _onJSMessageReceived}),
      ],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (LoginState previous, LoginState current) =>
          previous.embeddedRequestError != current.embeddedRequestError,
      listener: _handleEmbeddedErrorState,
      child: PopScope(
        canPop: !_canGoBack,
        onPopInvokedWithResult: (_, _) => _webViewController.goBack(),
        child: WebViewContainer(
          initialUri: widget.initialUrl,
          webViewController: _webViewController,
          connectivityRecoveryStrategy: _connectivityRecoveryStrategy,
          showToolbar: false,
          userAgent: widget.userAgent,
          pageInjectionStrategies: _pageInjectionStrategies,
          jSChannelStrategies: _jSChannelStrategies,
          onUrlChange: (_) => _updateCanGoBack(),
          errorBuilder: _buildErrorBuilder(),
        ),
      ),
    );
  }

  /// Returns a WebView error builder that shows a native error dialog,
  /// unless the page was previously loaded successfully (e.g., cached SPA).
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

    final title = isRequestFailure
        ? context.l10n.default_TypeErrorError
        : context.l10n.common_noInternetConnection_title;

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
  Future<void> _onEmbeddedErrorRetry(Map<String, dynamic>? extras, Map<String, dynamic>? callbackData) async {
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

  void _onJSMessageReceived(WebViewController _, JsonJsEvent e) {
    if (context.mounted) _loginCubit.loginCustomSignupRequest(e.data, e.callback);
  }
}
