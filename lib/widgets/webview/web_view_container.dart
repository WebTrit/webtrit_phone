import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';
export 'package:webview_flutter/webview_flutter.dart' show JavaScriptMessage;

import 'package:webtrit_phone/core/mixins/widget_state_mixin.dart';
import 'package:webtrit_phone/widgets/webview/web_view_content.dart';
import 'package:webtrit_phone/widgets/webview/web_view_toolbar.dart';
import 'package:webtrit_phone/widgets/webview/extensions/extensions.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

final _logger = Logger('WebViewContainer');

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    super.key,
    required this.initialUri,
    required this.userAgent,
    this.title,
    this.addLocaleNameToQueryParameters = true,
    this.javaScriptChannels = const {},
    this.errorBuilder,
    this.showToolbar = true,
    this.builder,
    this.webViewController,
    this.onPageLoadedSuccess,
    this.onPageLoadedFailed,
    this.onUrlChange,
    this.connectivityRecoveryStrategy,
    this.pageInjectionStrategies = const [],
    this.enableEmbeddedLogging = false,
  });

  final Widget? title;
  final Uri initialUri;
  final bool addLocaleNameToQueryParameters;
  final Map<String, void Function(JavaScriptMessage)> javaScriptChannels;
  final bool showToolbar;
  final Widget? Function(BuildContext context, WebResourceError error, WebViewController controller)? errorBuilder;
  final TransitionBuilder? builder;
  final String userAgent;
  final WebViewController? webViewController;
  final bool enableEmbeddedLogging;

  final void Function()? onPageLoadedSuccess;
  final void Function(WebResourceError error)? onPageLoadedFailed;
  final void Function(String? url)? onUrlChange;

  /// Strategy for handling connectivity recovery and retrying page loads.
  final ConnectivityRecoveryStrategy? connectivityRecoveryStrategy;

  /// List of strategies for injecting data into the WebView when it is ready.
  final List<PageInjectionStrategy> pageInjectionStrategies;

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
        queryParameters: {
          ...widget.initialUri.queryParameters,
          'localeName': context.l10n.localeName,
        },
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
    final hasWebViewError = widget.errorBuilder != null && _latestError != null;

    errorPlaceholderBuilder(BuildContext context) {
      return widget.errorBuilder!(context, _latestError!, _webViewController) ?? const SizedBox.shrink();
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
          WebViewToolbar(
            title: widget.title,
            onReload: _webViewController.reload,
          ),
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
    _navigationRequestHandler = NavigationRequestHandler(
      canLaunchUrlFn: canLaunchUrl,
      launchUrlFn: launchUrl,
    );
  }

  void _initializeWebViewController() {
    final navigationDelegate = NavigationDelegate(
      onUrlChange: _onUrlChange,
      onPageFinished: _onPageFinished,
      onProgress: _onProgress,
      onNavigationRequest: _navigationRequestHandler.handle,
      onWebResourceError: _onWebResourceError,
    );

    _webViewController = widget.webViewController ?? WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(widget.userAgent)
      ..enableZoom(false)
      ..setNavigationDelegate(navigationDelegate);

    for (var MapEntry(key: name, value: onMessageReceived) in widget.javaScriptChannels.entries) {
      _webViewController.addJavaScriptChannel(name, onMessageReceived: onMessageReceived);
    }

    if (widget.enableEmbeddedLogging) {
      _setupConsoleLoggerChannel();
    }

    widget.connectivityRecoveryStrategy?._startMonitoring(_webViewController);
  }

  /// Registers the `ConsoleLog` JavaScript channel to receive log messages
  /// from the WebView (injected via `_injectConsoleLogging()`).
  ///
  /// Parses log level prefixes (e.g. "ERROR:", "INFO:") and routes messages
  /// to the appropriate Dart logger level (`_logger.severe`, `.info`, etc.).
  void _setupConsoleLoggerChannel() {
    _webViewController.addJavaScriptChannel(
      'ConsoleLog',
      onMessageReceived: (message) {
        final raw = message.message.trim();

        if (raw.startsWith('ERROR:')) {
          _logger.webViewLog(level: 'ERROR', message: raw.substring(6).trim());
        } else if (raw.startsWith('WARN:')) {
          _logger.webViewLog(level: 'WARN', message: raw.substring(5).trim());
        } else if (raw.startsWith('INFO:')) {
          _logger.webViewLog(level: 'INFO', message: raw.substring(5).trim());
        } else if (raw.startsWith('DEBUG:')) {
          _logger.webViewLog(level: 'DEBUG', message: raw.substring(6).trim());
        } else if (raw.startsWith('LOG:')) {
          _logger.webViewLog(level: 'LOG', message: raw.substring(4).trim());
        } else {
          _logger.webViewLog(level: 'INFO', message: raw);
        }
      },
    );
  }

  void _onUrlChange(UrlChange change) {
    _logger.fine('URL changed: ${change.url}');
    widget.onUrlChange?.call(change.url);
  }

  void _onPageFinished(String url) {
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
        _logger.fine('Skipped final load handling because widget is unmounted');
        return;
      }

      if (!_isPageLoading) {
        if (_latestError == null) {
          widget.onPageLoadedSuccess?.call();
          widget.connectivityRecoveryStrategy?._onPageLoadSuccess();

          for (final strategy in widget.pageInjectionStrategies) {
            strategy._handlePageReady(_webViewController, context);
          }

          _injectMediaQueryData();
          if (widget.enableEmbeddedLogging) {
            _injectConsoleLogging();
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

  void _onWebResourceError(WebResourceError error) {
    _logger.warning('WebView error: $error');
    safeSetState(() {
      _currentError = error;
      _latestError = error;
    });
  }

  /// Injects media query-related data from Flutter into the WebView as JSON.
  ///
  /// This method gathers the current media query information such as:
  /// - `brightness`: light or dark theme (`light` / `dark`)
  /// - `devicePixelRatio`: screen density
  /// - `topSafeInset`: top padding (usually status bar height)
  /// - `bottomSafeInset`: bottom padding (gesture area or system-reserved space)
  ///
  /// It serializes the data into JSON and calls a JavaScript function
  /// `window.onMediaQueryReady(json)` inside the WebView, if it's defined.
  ///
  /// Example JS hook on the page:
  /// ```js
  /// window.onMediaQueryReady = function(payload) {
  ///   const data = JSON.parse(payload); // or use directly if it's an object
  ///   // apply UI adjustments here
  /// };
  /// ```
  void _injectMediaQueryData() {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final payload = {
      'brightness': theme.brightness.name,
      'devicePixelRatio': mediaQuery.devicePixelRatio,
      'topSafeInset': mediaQuery.viewPadding.top.round(),
      'bottomSafeInset': mediaQuery.viewPadding.bottom.round(),
    };

    final jsonString = const JsonEncoder().convert(payload);

    final script = '''
      if (typeof window.onMediaQueryReady === 'function') {
        window.onMediaQueryReady($jsonString);
      }
    ''';

    _logger.finest('Injecting media query data: $jsonString');
    _webViewController.runJavaScript(script);
  }

  /// Injects JavaScript that overrides `console.*` methods to:
  /// - Send logs to Flutter via the `ConsoleLog` channel (e.g. "ERROR: message")
  /// - Preserve original browser console output
  ///
  /// Must be used with `addJavaScriptChannel('ConsoleLog', ...)`.
  /// Call after page load (e.g. in `onPageFinished`).
  void _injectConsoleLogging() {
    const script = '''
    (function() {
      function wrapConsole(method, level) {
        const original = console[method];
        console[method] = function(...args) {
          try {
            const message = args.map(a =>
              typeof a === 'object' ? JSON.stringify(a) : a
            ).join(' ');
            ConsoleLog.postMessage(level + ": " + message);
          } catch (e) {
            ConsoleLog.postMessage(level + ": [Unserializable console args]");
          }
          original.apply(console, args);
        };
      }

      wrapConsole('log', 'LOG');
      wrapConsole('info', 'INFO');
      wrapConsole('warn', 'WARN');
      wrapConsole('error', 'ERROR');
      wrapConsole('debug', 'DEBUG');
    })();
  ''';

    _webViewController.runJavaScript(script);
  }
}

class NavigationRequestHandler {
  NavigationRequestHandler({
    required this.canLaunchUrlFn,
    required this.launchUrlFn,
  });

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

    if (!await launchUrlFn(targetUri, mode: LaunchMode.externalApplication)) {
      return NavigationDecision.prevent;
    }

    return NavigationDecision.prevent;
  }
}

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
  DefaultPayloadInjectionStrategy({this.functionName = 'onPayloadDataReady'}) {
    _payloadNotifier.addListener(_attemptPayloadInjection);
  }

  /// The name of the JavaScript function to call in the WebView.
  final String functionName;

  /// Stores the current payload to inject.
  final ValueNotifier<Map<String, dynamic>> _payloadNotifier = ValueNotifier({});

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
      _logger.fine('Cannot inject — WebView not ready');
      return;
    }

    final payload = _payloadNotifier.value;
    if (payload.isEmpty) {
      _logger.warning('Payload is empty. Skipping injection.');
      return;
    }

    final jsonString = const JsonEncoder().convert(payload);
    final script = '''
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

/// Strategy interface for recovering from connectivity loss by reattempting actions.
abstract class ConnectivityRecoveryStrategy {
  /// Creates a [ConnectivityRecoveryStrategy] based on the specified [ReconnectStrategy].
  static ConnectivityRecoveryStrategy create({
    required ReconnectStrategy type,
    required Stream<List<ConnectivityResult>> connectivityStream,
    Uri? initialUri,
  }) {
    switch (type) {
      case ReconnectStrategy.none:
        return NoneConnectivityRecoveryStrategy();
      case ReconnectStrategy.notifyOnly:
        return NotifyOnlyConnectivityRecoveryStrategy(connectivityStream: connectivityStream);
      case ReconnectStrategy.softReload:
        return SoftReloadRecoveryStrategy(connectivityStream: connectivityStream);
      case ReconnectStrategy.hardReload:
        if (initialUri == null) {
          throw ArgumentError('initialUri is required for HardReloadRecoveryStrategy');
        }
        return HardReloadRecoveryStrategy(
          connectivityStream: connectivityStream,
          initialUri: initialUri,
        );
    }
  }

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
  /// Returns `false` if disconnected or if the attempt limit has been reached.
  bool _shouldStartRetries() {
    if (!_isConnected) {
      _logger.info('Device is offline');
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
  /// If still connected and attempts remain, it triggers [tryReload].
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

  /// Attempts to reload the WebView.
  void _onRetryAttempt() {
    _controller.reload();
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
    _attempt = 0;
    _stopRetries();
  }

  /// Manually triggers failure handling (used in tests).
  @visibleForTesting
  void onPageLoadFailed() => _onPageLoadFailed();

  /// Handles page load failure by restarting retries if applicable.
  @override
  void _onPageLoadFailed() {
    _logger.warning('Page load failed, will continue retrying if connected');
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
    super.retryDelay,
    super.maxAttempts,
  });

  @override
  void _onRetryAttempt() {
    _controller.runJavaScript('window.onReconnect?.()');
    _stopRetries();
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

  @override
  void _onRetryAttempt() {
    _controller.loadRequest(initialUri);
  }
}
