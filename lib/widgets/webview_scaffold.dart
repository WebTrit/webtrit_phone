import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'webview_progress_indicator.dart';

export 'package:webview_flutter/webview_flutter.dart' show JavaScriptMessage;

final _logger = Logger('WebViewScaffold');

class WebViewScaffold extends StatefulWidget {
  const WebViewScaffold({
    super.key,
    this.title,
    required this.initialUri,
    this.addLocaleNameToQueryParameters = true,
    this.javaScriptChannels = const {},
    this.errorBuilder,
    this.showToolbar = true,
    this.builder,
    required this.userAgent,
    this.webViewController,
    this.onPageLoadedSuccess,
    this.onPageLoadedFailed,
    this.onUrlChange,
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

  final void Function()? onPageLoadedSuccess;
  final void Function(WebResourceError error)? onPageLoadedFailed;
  final void Function(String? url)? onUrlChange;

  @override
  State<WebViewScaffold> createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  late final WebViewController _webViewController;
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

    _webViewController = widget.webViewController ?? WebViewController();
    () async {
      if (!kIsWeb) {
        await Future.wait([
          _webViewController.setUserAgent(widget.userAgent),
          _webViewController.enableZoom(false),
          _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
          for (var MapEntry(key: name, value: onMessageReceived) in widget.javaScriptChannels.entries)
            _webViewController.addJavaScriptChannel(name, onMessageReceived: onMessageReceived),
          _webViewController.setNavigationDelegate(
            NavigationDelegate(
              onUrlChange: (url) {
                widget.onUrlChange?.call(url.url);
              },
              onPageFinished: (url) {
                if (_currentError == null) {
                  // Reset the error only if the page loaded successfully
                  _latestError = null;
                } else {
                  _logger.warning('Page finished with error: $_currentError');
                  widget.onPageLoadedFailed?.call(_currentError!);
                }

                setState(() {
                  // Always reset the current error after page finishes loading
                  _currentError = null;
                });

                _isPageLoading = false;

                _finalLoadTimer?.cancel();
                _finalLoadTimer = Timer(_finalLoadDebounceDuration, () {
                  if (!_isPageLoading) {
                    if (_latestError == null) {
                      widget.onPageLoadedSuccess?.call();
                    } else {
                      _logger.warning('Skipped injection, page loading failed');
                    }
                  } else {
                    _logger.fine('Skipped injection, page loading resumed');
                  }
                });
              },
              onProgress: (progress) {
                _isPageLoading = progress < 100;
                _progressStreamController.add(progress);

                if (_isPageLoading) {
                  _finalLoadTimer?.cancel();
                }
              },
              onWebResourceError: (error) {
                _logger.warning('WebView error: $error');

                setState(() {
                  // Capture the current error
                  _currentError = error;
                  // Store the error for future reference or display
                  _latestError = error;
                });
              },
            ),
          ),
        ]);
      }
    }();
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
  void didUpdateWidget(WebViewScaffold oldWidget) {
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
    () async {
      if (!kIsWeb) {
        await _webViewController.setNavigationDelegate(NavigationDelegate());
      }

      _finalLoadTimer?.cancel();
      await _webViewController.loadBlank();
      await _progressStreamController.close();
    }();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showToolbar
          ? AppBar(
              title: widget.title,
              leading: const ExtBackButton(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _webViewController.reload,
                ),
              ],
            )
          : null,
      body: Builder(
        builder: (context) {
          final hasWebViewError = widget.errorBuilder != null && _latestError != null;

          final errorPlaceholderBuilder = Builder(builder: (context) {
            return widget.errorBuilder!(context, _latestError!, _webViewController) ?? const SizedBox.shrink();
          });

          final successBuilder = Builder(builder: (context) {
            final webViewWidget = WebViewWidget(controller: _webViewController);
            return widget.builder != null ? widget.builder!(context, webViewWidget) : webViewWidget;
          });

          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              hasWebViewError ? errorPlaceholderBuilder : successBuilder,
              WebViewProgressIndicator(stream: _progressStreamController.stream),
            ],
          );
        },
      ),
    );
  }
}
