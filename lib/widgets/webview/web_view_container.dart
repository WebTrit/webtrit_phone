import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';
export 'package:webview_flutter/webview_flutter.dart' show JavaScriptMessage;

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/core/mixins/widget_state_mixin.dart';
import 'package:webtrit_phone/widgets/webview/web_view_content.dart';
import 'package:webtrit_phone/widgets/webview/web_view_toolbar.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '_widgets/_widgets.dart';
import 'models/models.dart';

final _logger = Logger('WebViewContainer');

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    super.key,
    required this.initialUri,
    required this.userAgent,
    this.title,
    this.addLocaleNameToQueryParameters = true,
    this.errorBuilder,
    this.showToolbar = true,
    this.builder,
    this.webViewController,
    this.onPageLoadedSuccess,
    this.onPageLoadedFailed,
    this.onUrlChange,
    this.connectivityRecoveryStrategy,
    this.pageInjectionStrategies = const [],
    this.jSChannelStrategies = const [],
  });

  final Widget? title;
  final Uri initialUri;
  final bool addLocaleNameToQueryParameters;

  final bool showToolbar;
  final Widget? Function(BuildContext context, WebResourceError error, WebViewController controller)? errorBuilder;
  final TransitionBuilder? builder;
  final String userAgent;
  final WebViewController? webViewController;

  final void Function()? onPageLoadedSuccess;
  final void Function(WebResourceError error)? onPageLoadedFailed;
  final void Function(String? url)? onUrlChange;

  /// Strategy for handling connectivity recovery and retrying page loads.
  final ConnectivityRecoveryStrategy? connectivityRecoveryStrategy;

  /// List of strategies for injecting data into the WebView when it is ready.
  final List<PageInjectionStrategy> pageInjectionStrategies;

  final List<JSChannelStrategy> jSChannelStrategies;

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> with WidgetStateMixin {
  late final WebViewController _webViewController;
  late final NavigationRequestHandler _navigationRequestHandler;
  final _progressStreamController = StreamController<int>.broadcast();

  Color? _backgroundColorCache;
  Uri? _effectiveInitialUrlCache;

  WebResourceError? _latestError;
  WebResourceError? _currentError;

  SslAuthError? _sslAuthError;
  String? _sslFailingUrl;

  /// Indicates whether a page is currently in the process of loading.
  ///
  /// This flag is set to `true` when [onProgress] reports progress < 100,
  /// and reset to `false` once the page is fully loaded ([onPageFinished] called).
  ///
  /// It is used to coordinate the timing of JavaScript injection or
  /// signaling that the page has finished loading in a stable state.
  bool _isPageLoading = false;

  /// A debounce timer used to determine when the page has truly finished loading.
  ///
  /// This timer is started after [onPageFinished] is triggered, with a delay
  /// (e.g., 500ms) to ensure no further progress updates follow. If no additional
  /// loading activity occurs during this period, [onPageLoadedSuccess] is invoked.
  ///
  /// If [onProgress] reports further activity before the timer fires, the timer is cancelled.
  /// This prevents race conditions where the DOM might not be ready for JavaScript injection.
  Timer? _finalLoadTimer;

  /// Debounce duration after page finishes loading.
  /// Used to delay success callback to ensure loading is truly complete.
  static const Duration _finalLoadDebounceDuration = Duration(milliseconds: 500);

  Uri _composeEffectiveInitialUrl() {
    if (!widget.addLocaleNameToQueryParameters) {
      return widget.initialUri;
    } else {
      return widget.initialUri.replace(
        queryParameters: {...widget.initialUri.queryParameters, 'localeName': context.l10n.localeName},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeHandlers();
    _initializeWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    final hasWebViewError = _sslAuthError != null || _latestError != null;

    errorPlaceholderBuilder(BuildContext context) {
      if (_sslAuthError != null) {
        return SslAuthErrorView(error: _sslAuthError!, onReload: _reloadPage, failingUrl: _sslFailingUrl);
      }

      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, _latestError!, _webViewController) ?? const SizedBox.shrink();
      }

      // fallback to default
      return DefaultWebViewErrorView(error: _latestError!, onReload: _reloadPage);
    }

    successBuilder(BuildContext context) {
      final webViewWidget = WebViewWidget(controller: _webViewController);
      return widget.builder != null ? widget.builder!(context, webViewWidget) : webViewWidget;
    }

    final content = WebViewContent(
      hasWebViewError: hasWebViewError,
      errorBuilder: errorPlaceholderBuilder,
      successBuilder: successBuilder,
      progressStream: _progressStreamController.stream,
    );

    if (widget.showToolbar) {
      return Column(
        children: [
          WebViewToolbar(title: widget.title, onReload: _webViewController.reload),
          Expanded(child: content),
        ],
      );
    } else {
      return content;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final themeData = Theme.of(context);
    final backgroundColor = themeData.colorScheme.surface;
    if (_backgroundColorCache != backgroundColor && !kIsWeb) {
      _backgroundColorCache = backgroundColor;
      _webViewController.setBackgroundColor(backgroundColor);
    }

    final effectiveInitialUrl = _composeEffectiveInitialUrl();
    if (_effectiveInitialUrlCache != effectiveInitialUrl) {
      _effectiveInitialUrlCache = effectiveInitialUrl;
      _webViewController.loadRequest(effectiveInitialUrl);
    }
  }

  @override
  void didUpdateWidget(WebViewContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialUri != oldWidget.initialUri ||
        widget.addLocaleNameToQueryParameters != oldWidget.addLocaleNameToQueryParameters) {
      final effectiveInitialUrl = _composeEffectiveInitialUrl();
      _effectiveInitialUrlCache = effectiveInitialUrl;
      _webViewController.loadRequest(effectiveInitialUrl);
    }
  }

  @override
  void dispose() {
    _disposeTimers();
    _disposeStreams();
    _disposeConnectivityStrategy();
    _disposeInjectionStrategies();
    super.dispose();
  }

  void _disposeTimers() {
    _finalLoadTimer?.cancel();
  }

  void _disposeStreams() {
    if (!_progressStreamController.isClosed) {
      _progressStreamController.close();
    }
  }

  void _disposeConnectivityStrategy() {
    widget.connectivityRecoveryStrategy?._dispose();
  }

  void _disposeInjectionStrategies() {
    for (final strategy in widget.pageInjectionStrategies) {
      strategy._dispose();
    }
  }

  void _initializeHandlers() {
    _navigationRequestHandler = NavigationRequestHandler(canLaunchUrlFn: canLaunchUrl, launchUrlFn: launchUrl);
  }

  void _initializeWebViewController() {
    _webViewController = widget.webViewController ?? WebViewController();

    if (!kIsWeb) {
      final navigationDelegate = NavigationDelegate(
        onUrlChange: _onUrlChange,
        onPageFinished: _onPageFinished,
        onProgress: _onProgress,
        onSslAuthError: _onSslAuthError,
        onNavigationRequest: _navigationRequestHandler.handle,
        onWebResourceError: _onWebResourceError,
      );

      // Set up WebViewController with navigation delegate and unrestricted JS mode.
      // These configurations are applied only on non-web platforms to avoid unsupported operations.
      _webViewController
        ..enableZoom(false)
        ..setUserAgent(widget.userAgent)
        ..setNavigationDelegate(navigationDelegate)
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
    }

    if (widget.jSChannelStrategies.isNotEmpty) {
      for (final s in widget.jSChannelStrategies) {
        s._attach(_webViewController);
      }
    }

    widget.connectivityRecoveryStrategy?._startMonitoring(_webViewController);
  }

  void _onUrlChange(UrlChange change) {
    _logger.fine('URL changed: ${change.url}');
    widget.onUrlChange?.call(change.url);
  }

  void _onPageFinished(String url) {
    if (!mounted) {
      _logger.finest('Skipped page finished handling because widget is unmounted');
      return;
    }

    if (_currentError == null) {
      _latestError = null;
    } else {
      _logger.warning('Page finished with error: $_currentError');
      widget.onPageLoadedFailed?.call(_currentError!);
    }

    safeSetState(() {
      _currentError = null;
    });

    _isPageLoading = false;
    _finalLoadTimer?.cancel();
    _finalLoadTimer = Timer(_finalLoadDebounceDuration, () {
      if (!mounted) {
        _logger.finest('Skipped final load handling because widget is unmounted');
        return;
      }

      if (!_isPageLoading) {
        if (_latestError == null) {
          widget.onPageLoadedSuccess?.call();
          widget.connectivityRecoveryStrategy?._onPageLoadSuccess();

          for (final strategy in widget.pageInjectionStrategies) {
            strategy._handlePageReady(_webViewController, context);
          }
        } else {
          widget.connectivityRecoveryStrategy?._onPageLoadFailed();
          _logger.warning('Skipped injection, page loading failed');
        }
      } else {
        _logger.fine('Skipped injection, page loading resumed');
      }
    });
  }

  void _onProgress(int progress) {
    _isPageLoading = progress < 100;
    _progressStreamController.add(progress);
    if (_isPageLoading) {
      _finalLoadTimer?.cancel();
    }
  }

  // TODO: Cover with tests
  /// Handles errors reported by the WebView engine during resource loading.
  ///
  /// This callback may be triggered in several situations:
  /// - **Main frame navigation failures** - e.g. no internet connection,
  ///   DNS lookup failure, SSL handshake errors, or the server not responding.
  ///   These usually mean the page cannot be displayed at all.
  /// - **Subresource load errors** - e.g. missing images, blocked fonts,
  ///   CORS issues, or network hiccups while loading scripts/styles.
  ///   In such cases, the main page may still load and work.
  ///
  /// Since subresource errors are common and often non-fatal,
  /// we ignore them and only surface main-frame errors to the UI.
  ///
  /// To avoid UI thrashing, duplicate errors (same code and URL) are also suppressed.
  void _onWebResourceError(WebResourceError error) {
    final code = error.errorCode;
    final type = error.errorType;
    final url = error.url;
    final isMain = error.isForMainFrame ?? true;

    _logger.warning('WebView error', {
      'code': code,
      'type': type,
      'url': url,
      'isMainFrame': isMain,
      'desc': error.description,
    });

    // Ignore subresource errors (images, fonts, trackers, etc.)
    if (!isMain) {
      _logger.fine('Ignoring non-main-frame error for $url ($type/$code)');
      return;
    }

    // De-dupe: don't re-set the same main-frame error over and over.
    if (_latestError != null && _latestError!.errorCode == code && _latestError!.url == url) {
      _logger.fine('Duplicate main-frame error suppressed for $url ($code)');
      return;
    }

    safeSetState(() {
      _currentError = error;
      _latestError = error;
    });
  }

  void _onSslAuthError(SslAuthError error) {
    _logger.severe('SSL Auth Error: $error');
    safeSetState(() {
      _sslAuthError = error;
    });

    widget.connectivityRecoveryStrategy?._onPageLoadFailed();
  }

  void _reloadPage() {
    _sslAuthError = null;
    _latestError = null;
    _currentError = null;
    _webViewController.reload();
  }
}

class NavigationRequestHandler {
  NavigationRequestHandler({required this.canLaunchUrlFn, required this.launchUrlFn});

  final Future<bool> Function(Uri) canLaunchUrlFn;
  final Future<bool> Function(Uri, {LaunchMode mode}) launchUrlFn;

  static const _kNavigationRequestScheme = 'app';
  static const _kNavigationRequestHostExternalBrowser = 'openinexternalbrowser';
  static const _kNavigationRequestParamUrl = 'url';

  /// Handles a navigation request and determines whether to allow it in the WebView.
  ///
  /// - HTTP/HTTPS requests are allowed.
  /// - Requests to `app://openinexternalbrowser?url=...` are launched in an external browser.
  /// - All other schemes are blocked.
  ///
  /// Returns [NavigationDecision.navigate] to allow loading in WebView,
  /// or [NavigationDecision.prevent] to block the navigation.
  Future<NavigationDecision> handle(NavigationRequest request) async {
    _logger.fine('Handling navigation request: ${request.url}');

    final uri = Uri.tryParse(request.url);
    if (uri == null) {
      return NavigationDecision.prevent;
    }

    final scheme = uri.scheme.toLowerCase();
    final host = uri.host.toLowerCase();

    if (_isExternalBrowserRequest(scheme, host)) {
      return _handleExternalBrowserRequest(uri);
    }

    if (_isInternalHttpRequest(scheme)) {
      return NavigationDecision.navigate;
    }

    return NavigationDecision.prevent;
  }

  /// Returns `true` if the given scheme represents an internal WebView-supported
  /// HTTP or HTTPS request.
  bool _isInternalHttpRequest(String scheme) {
    return scheme == 'http' || scheme == 'https';
  }

  /// Returns `true` if the request is targeting the app-defined URL scheme for
  /// opening links in an external browser.
  ///
  /// Specifically checks for:
  /// `app://openinexternalbrowser?url=https://example.com`
  bool _isExternalBrowserRequest(String scheme, String host) {
    return scheme == _kNavigationRequestScheme && host == _kNavigationRequestHostExternalBrowser;
  }

  /// Handles a request to open an external browser via the custom app URL scheme.
  ///
  /// Validates that the `url` query parameter exists and is a valid URI,
  /// and attempts to launch it using [launchUrlFn].
  ///
  /// Returns [NavigationDecision.prevent] in all cases to block WebView navigation.
  /// If launch fails, navigation is still blocked.
  Future<NavigationDecision> _handleExternalBrowserRequest(Uri uri) async {
    final targetUrl = uri.queryParameters[_kNavigationRequestParamUrl];
    if (targetUrl?.isEmpty ?? true) {
      return NavigationDecision.prevent;
    }

    final targetUri = Uri.tryParse(targetUrl!);
    if (targetUri == null) {
      return NavigationDecision.prevent;
    }

    if (!await canLaunchUrlFn(targetUri)) {
      return NavigationDecision.prevent;
    }

    const mode = kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication;
    if (!await launchUrlFn(targetUri, mode: mode)) {
      return NavigationDecision.prevent;
    }

    return NavigationDecision.prevent;
  }
}

/// A builder function that creates a [PageInjectionStrategy].
typedef PageInjectionStrategyBuilder = PageInjectionStrategy Function();

/// Defines a strategy interface for injecting payload data into a WebView.
abstract class PageInjectionStrategy {
  /// Updates the payload that may be injected into the WebView.
  void setPayload(Map<String, dynamic> payload);

  /// Called when the WebView is fully initialized and ready for interaction.
  void _handlePageReady(WebViewController controller, BuildContext context);

  /// Releases resources and stops any listeners.
  void _dispose();
}

/// A default implementation of [PageInjectionStrategy] that injects
/// JSON-encoded payloads into a WebView when it becomes ready.
///
/// The injection is performed by executing a JavaScript function
/// on the `window` object. By default, it calls `window.onPayloadDataReady(...)`,
/// but the function name can be customized via the [functionName] parameter.
class DefaultPayloadInjectionStrategy implements PageInjectionStrategy {
  DefaultPayloadInjectionStrategy({this.functionName = 'onPayloadDataReady', Map<String, dynamic>? initialPayload})
    : _payloadNotifier = ValueNotifier<Map<String, dynamic>>(initialPayload ?? {}) {
    _payloadNotifier.addListener(_attemptPayloadInjection);
  }

  /// The name of the JavaScript function to call in the WebView.
  final String functionName;

  /// Stores the current payload to inject.
  final ValueNotifier<Map<String, dynamic>> _payloadNotifier;

  WebViewController? _controller;
  BuildContext? _context;

  /// Testing-only helper to simulate page readiness.
  @visibleForTesting
  void onPageReadyForTesting(WebViewController controller, BuildContext context) =>
      _handlePageReady(controller, context);

  /// Marks the WebView as ready and attempts to inject the payload.
  @override
  void _handlePageReady(WebViewController controller, BuildContext context) {
    _logger.finest('WebView is ready, will inject if payload is set');
    _controller = controller;
    _context = context;
    _attemptPayloadInjection();
  }

  /// Updates the payload to be injected when the WebView is ready.
  @override
  void setPayload(Map<String, dynamic> payload) {
    _logger.finest('setData called with: $payload');
    _payloadNotifier.value = payload;
  }

  /// Attempts to inject the payload into the WebView using JavaScript.
  ///
  /// Skips injection if the WebView or payload is not ready.
  void _attemptPayloadInjection() {
    if (_controller == null || _context == null) {
      _logger.fine('Cannot inject - WebView not ready');
      return;
    }

    final payload = _payloadNotifier.value;
    if (payload.isEmpty) {
      _logger.warning('Payload is empty. Skipping injection.');
      return;
    }

    final jsonString = const JsonEncoder().convert(payload);
    final script =
        '''
      if (typeof window.$functionName === 'function') {
        window.$functionName($jsonString);
      }
    ''';

    _logger.finest('Injecting payload data: $jsonString');
    _controller!.runJavaScript(script);
  }

  /// Testing-only helper to dispose resources manually.
  @visibleForTesting
  void disposeForTesting() => _dispose();

  /// Removes listeners and cleans up resources.
  @override
  void _dispose() {
    _payloadNotifier.removeListener(_attemptPayloadInjection);
  }
}

/// Strategy for injecting arbitrary JavaScript when the page is ready.
class JavaScriptInjectionStrategy implements PageInjectionStrategy {
  JavaScriptInjectionStrategy.raw(this.script, {this.label, this.returnResult = false, this.onError, this.onSuccess});

  /// Optional label to simplify logging.
  final String? label;

  /// The JS source to execute.
  final String script;

  /// If true - uses runJavaScriptReturningResult, otherwise runJavaScript.
  final bool returnResult;

  /// Optional callbacks.
  final void Function(Object error, StackTrace st)? onError;
  final void Function(Object? result)? onSuccess;

  WebViewController? _controller;

  @override
  void _handlePageReady(WebViewController controller, BuildContext context) {
    _controller = controller;
    _inject();
  }

  @override
  void setPayload(Map<String, dynamic> payload) {
    // no-op for pure script injection; kept to satisfy interface
  }

  Future<void> _inject() async {
    final c = _controller;
    if (c == null) return;

    try {
      if (returnResult) {
        final res = await c.runJavaScriptReturningResult(script);
        _logger.finest('${label ?? "JS"} inject result: $res');
        onSuccess?.call(res);
      } else {
        await c.runJavaScript(script);
        _logger.finest('${label ?? "JS"} injected');
        onSuccess?.call(null);
      }
    } catch (e, st) {
      _logger.severe('${label ?? "JS"} inject failed', e, st);
      onError?.call(e, st);
    }
  }

  @override
  void _dispose() {}
}

/// Builder function for creating a [ConnectivityRecoveryStrategy].
typedef ConnectivityRecoveryStrategyBuilder = ConnectivityRecoveryStrategy Function();

/// Builder function for creating a [ConnectivityChecker].
typedef ConnectivityCheckerBuilder = ConnectivityChecker Function();

/// Strategy interface for recovering from connectivity loss by reattempting actions.
abstract class ConnectivityRecoveryStrategy {
  /// Creates a [ConnectivityRecoveryStrategy] based on the specified [ReconnectStrategy].
  static ConnectivityRecoveryStrategy create({
    required Uri initialUri,
    required ReconnectStrategy type,
    required Stream<List<ConnectivityResult>> connectivityStream,
    required ConnectivityCheckerBuilder connectivityCheckerBuilder,
  }) {
    _logger.fine('Creating connectivity recovery strategy: $type for $initialUri');

    switch (type) {
      case ReconnectStrategy.none:
        return NoneConnectivityRecoveryStrategy();
      case ReconnectStrategy.notifyOnly:
        return NotifyOnlyConnectivityRecoveryStrategy(
          connectivityStream: connectivityStream,
          connectivityChecker: connectivityCheckerBuilder(),
        );
      case ReconnectStrategy.softReload:
        return SoftReloadRecoveryStrategy(connectivityStream: connectivityStream);
      case ReconnectStrategy.hardReload:
        return HardReloadRecoveryStrategy(connectivityStream: connectivityStream, initialUri: initialUri);
    }
  }

  /// Returns true if the page has successfully loaded at least once.
  bool get hasSuccessfulLoad;

  /// The strategy type for this recovery strategy.
  ReconnectStrategy get strategy;

  /// Starts monitoring connectivity and retries based on the strategy.
  void _startMonitoring(WebViewController controller);

  /// Disposes the strategy and its resources.
  void _dispose();

  /// Called when a page load succeeds (resets state and stops retries).
  void _onPageLoadSuccess();

  /// Called when a page load fails (may trigger retry depending on state).
  void _onPageLoadFailed();
}

/// Disables all connectivity recovery behavior.
/// No reloads, retries, or JS notifications are performed.
/// Useful when the WebView handles reconnection internally.
class NoneConnectivityRecoveryStrategy implements ConnectivityRecoveryStrategy {
  @override
  bool get hasSuccessfulLoad => true;

  /// The strategy type for this recovery strategy.
  @override
  ReconnectStrategy get strategy => ReconnectStrategy.none;

  @override
  void _startMonitoring(WebViewController controller) {}

  @override
  void _dispose() {}

  @override
  void _onPageLoadSuccess() {}

  @override
  void _onPageLoadFailed() {}
}

/// Retry strategy that calls WebView's reload() on each attempt.
/// Continues retrying while connected until success or max attempts.
/// Preserves in-page JS state (soft reload).
class SoftReloadRecoveryStrategy implements ConnectivityRecoveryStrategy {
  SoftReloadRecoveryStrategy({
    required this.connectivityStream,
    this.retryDelay = const Duration(seconds: 1),
    this.maxAttempts = 100,
  });

  /// Stream of connectivity results to monitor.
  final Stream<List<ConnectivityResult>> connectivityStream;

  /// Delay between retry attempts.
  final Duration retryDelay;

  /// Maximum number of retry attempts before giving up.
  final int maxAttempts;

  /// The WebView controller to control the WebView.
  late final WebViewController _controller;

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _retryTimer;
  int _attempt = 0;
  bool _isConnected = false;
  bool _retryInProgress = false;
  bool _hasSuccessfulLoad = false;

  /// Returns true if the page has successfully loaded at least once.
  @override
  bool get hasSuccessfulLoad => _hasSuccessfulLoad;

  /// The strategy type for this recovery strategy.
  @override
  ReconnectStrategy get strategy => ReconnectStrategy.softReload;

  @override
  void _startMonitoring(WebViewController controller) {
    if (_subscription != null) {
      _logger.warning('startMonitoring was called more than once. Ignoring.');
      return;
    }

    _logger.info('Starting recovery strategy');
    _controller = controller;

    _subscription = connectivityStream.debounce(const Duration(milliseconds: 300)).listen(_handleConnectivityChange);
  }

  @visibleForTesting
  void startMonitoringForTesting(WebViewController controller) {
    _startMonitoring(controller);
  }

  /// Handles connectivity changes and manages retry logic accordingly.
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    _isConnected = results.any((r) => r != ConnectivityResult.none);
    _logger.info('Connectivity status: ${_isConnected ? "online" : "offline"} ($results)');

    if (!_isConnected) {
      _logger.info('Connectivity lost, stopping retries');
      _stopRetries();
      return;
    }

    // If we already had a successful load at least once, do NOT auto-retry on reconnect.
    if (_hasSuccessfulLoad) {
      _logger.info('Page had a successful load earlier; skipping retries on reconnect');
      return;
    }

    if (!_retryInProgress) {
      _logger.info('Connectivity restored, starting retry attempts');
      _startRetries();
    }
  }

  /// Starts periodic retry attempts if conditions are met.
  void _startRetries() {
    _stopRetries();

    if (!_shouldStartRetries()) {
      _logger.info('Retry conditions not met, skipping start');
      return;
    }

    _retryInProgress = true;
    _retryTimer = Timer.periodic(retryDelay, (_) => _onRetryTick());
  }

  /// Checks whether retry attempts should be started.
  ///
  /// Returns `false` if disconnected, if attempts exceeded, or if a successful
  /// load already happened.
  bool _shouldStartRetries() {
    if (!_isConnected) {
      _logger.info('Device is offline');
      return false;
    }

    if (_hasSuccessfulLoad) {
      _logger.info('Already had a successful load; no need to start retries');
      return false;
    }

    if (_attempt >= maxAttempts) {
      _logger.warning('Max retry attempts already reached ($_attempt/$maxAttempts)');
      return false;
    }

    return true;
  }

  /// Handles a single retry timer tick.
  ///
  /// If still connected and attempts remain, it triggers [_onRetryAttempt].
  void _onRetryTick() {
    if (!_isConnected) {
      _logger.info('Still offline, skipping retry attempt');
      return;
    }

    if (_attempt >= maxAttempts) {
      _logger.warning('Max retry attempts reached, stopping retries');
      _stopRetries();
      return;
    }

    _attempt++;
    _logger.info('Retry attempt $_attempt/$maxAttempts');
    _onRetryAttempt();
  }

  /// Attempts to reload the WebView. Subclasses may override.
  Future<void> _onRetryAttempt() {
    return _controller.reload();
  }

  /// Stops the retry timer and resets flags.
  void _stopRetries() {
    _logger.finest('Stopping retries');
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryInProgress = false;
  }

  /// Manually triggers success handling (used in tests).
  @visibleForTesting
  void onPageLoadSuccess() => _onPageLoadSuccess();

  /// Handles successful page load and stops retrying.
  @override
  void _onPageLoadSuccess() {
    _logger.info('Page load succeeded, stopping retries');
    _hasSuccessfulLoad = true;
    _attempt = 0;
    _stopRetries();
  }

  /// Manually triggers failure handling (used in tests).
  @visibleForTesting
  void onPageLoadFailed() => _onPageLoadFailed();

  /// Handles page load failure by (re)enabling retries if applicable.
  @override
  void _onPageLoadFailed() {
    _logger.warning('Page load failed, will continue retrying if connected');
    // After any explicit failure, allow retries again even if we had a prior success.
    _hasSuccessfulLoad = false;

    if (_isConnected && !_retryInProgress) {
      _startRetries();
    }
  }

  /// Manually disposes the strategy (used in tests).
  @visibleForTesting
  void disposeForTesting() => _dispose();

  /// Cancels connectivity subscription and cleans up resources.
  @override
  void _dispose() {
    _logger.info('Stopping recovery strategy');
    _hasSuccessfulLoad = false;
    _subscription?.cancel();
    _subscription = null;
    _stopRetries();
    _attempt = 0;
  }
}

/// Notifies the WebView of connectivity restoration via JS callback.
/// Calls `window.onReconnect?.()` once upon reconnect.
/// Does not trigger reload or retry logic.
class NotifyOnlyConnectivityRecoveryStrategy extends SoftReloadRecoveryStrategy {
  NotifyOnlyConnectivityRecoveryStrategy({
    required super.connectivityStream,
    required ConnectivityChecker connectivityChecker,
    this.reconnectCallbackFunction = 'onWebTritReconnect',
    super.retryDelay,
    super.maxAttempts,
  }) : _connectivityChecker = connectivityChecker;

  final ConnectivityChecker _connectivityChecker;

  /// JS method to call when connectivity is restored.
  final String reconnectCallbackFunction;

  /// The strategy type for this recovery strategy.
  @override
  ReconnectStrategy get strategy => ReconnectStrategy.notifyOnly;

  @override
  Future<void> _onRetryAttempt() async {
    final hasInternet = await _connectivityChecker.checkConnection();
    if (hasInternet && hasSuccessfulLoad) {
      _logger.info('NotifyOnlyConnectivityRecoveryStrategy: Connectivity restored, notifying WebView');

      // Wait for the next event loop to ensure the WebView is ready.
      await Future.delayed(Duration.zero);
      _controller.runJavaScript('window.$reconnectCallbackFunction?.()');
      _stopRetries();
    } else {
      super._onRetryAttempt();
    }
  }
}

/// Reloads the WebView from the original [initialUri] on each retry.
/// Clears internal app state unlike soft reload.
/// Suitable for apps that require a full refresh after reconnect.
class HardReloadRecoveryStrategy extends SoftReloadRecoveryStrategy {
  HardReloadRecoveryStrategy({
    required super.connectivityStream,
    required this.initialUri,
    super.retryDelay,
    super.maxAttempts,
  });

  final Uri initialUri;

  /// The strategy type for this recovery strategy.
  @override
  ReconnectStrategy get strategy => ReconnectStrategy.hardReload;

  @override
  Future<void> _onRetryAttempt() {
    return _controller.loadRequest(initialUri);
  }
}

/// A strategy wrapper for handling JavaScript channels in [WebViewController].
///
/// This class provides a convenient way to:
/// - Register a named JavaScript channel.
/// - Automatically decode messages into [JsonJsEvent].
/// - Route events to the correct handler based on the event name.
/// - Handle malformed or unknown messages gracefully.
///
/// Typical usage:
///
/// ```dart
/// // Single handler
/// final strategy = JSChannelStrategy(
///   name: 'MyChannel',
///   onEvent: (controller, event) {
///     if (event.event == 'signup') {
///       // You can use controller here (e.g. reload)
///     }
///   },
///   onMalformed: (raw) => print('Malformed message: $raw'),
/// );
///
/// // Router-based handler
/// final routed = JSChannelStrategy.route(
///   name: 'MyChannel',
///   routes: {
///     'signup': (c, e) => handleSignup(c, e),
///     'logout': (c, e) => handleLogout(c, e),
///   },
///   onUnknown: (e) => print('Unknown event: ${e.event}'),
/// );
/// ```
///
/// The default channel name is [defaultJSChannelName].
class JSChannelStrategy {
  /// Creates a [JSChannelStrategy].
  ///
  /// - [name]: The JavaScript channel name to listen for (must match the name used in the web page).
  /// - [onEvent]: Callback invoked with the [WebViewController] and parsed [JsonJsEvent] when a valid message is received.
  /// - [onMalformed]: Optional callback when the incoming message is not valid JSON or cannot be parsed.
  const JSChannelStrategy({required this.name, required this.onEvent, this.onMalformed});

  /// The JavaScript channel name.
  final String name;

  /// Handler for successfully decoded events (with controller).
  final JsonEventHandler onEvent;

  /// Handler for raw, malformed messages that failed to decode.
  final void Function(String raw)? onMalformed;

  /// Attaches this strategy to a [WebViewController].
  ///
  /// Called internally by [WebViewContainer] to register the channel.
  void _attach(WebViewController controller) {
    controller.addJavaScriptChannel(
      name,
      onMessageReceived: (m) {
        final e = JsonJsEvent.fromMessage(m);
        if (e == null) {
          onMalformed?.call(m.message);
          return;
        }
        onEvent(controller, e);
      },
    );
  }

  /// Creates a router-based [JSChannelStrategy] that dispatches events
  /// to different handlers based on the [JsonJsEvent.event] field.
  ///
  /// - [routes]: A map of event name -> handler.
  /// - [onUnknown]: Optional handler called if the event name
  ///   does not match any entry in [routes].
  /// - [onMalformed]: Optional handler for malformed raw messages.
  ///
  /// Example:
  /// ```dart
  /// final channel = JSChannelStrategy.route(
  ///   routes: {
  ///     'signup': (c, e) => handleSignup(c, e),
  ///     'logout': (c, e) => handleLogout(c, e),
  ///   },
  ///   onUnknown: (e) => print('Unknown event: ${e.event}'),
  /// );
  /// ```
  factory JSChannelStrategy.route({
    required String name,
    required Map<String, JsonEventHandler> routes,
    void Function(String raw)? onMalformed,
    void Function(JsonJsEvent e)? onUnknown,
  }) {
    return JSChannelStrategy(
      name: name,
      onMalformed: onMalformed,
      onEvent: (controller, e) {
        final handler = routes[e.event];
        if (handler != null) {
          handler(controller, e);
        } else {
          onUnknown?.call(e);
        }
      },
    );
  }
}
