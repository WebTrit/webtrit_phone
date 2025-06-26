import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';
export 'package:webview_flutter/webview_flutter.dart' show JavaScriptMessage;

import 'package:webtrit_phone/core/mixins/widget_state_mixin.dart';
import 'package:webtrit_phone/widgets/web_view_content.dart';
import 'package:webtrit_phone/widgets/web_view_toolbar.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

final _logger = Logger('WebViewContainer');

const _kNavigationRequestScheme = 'app';
const _kNavigationRequestHostExternalBrowser = 'openInExternalBrowser';
const _kNavigationRequestParamUrl = 'url';

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
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> with WidgetStateMixin {
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
    _finalLoadTimer?.cancel();
    if (!_progressStreamController.isClosed) _progressStreamController.close();

    super.dispose();
  }

  void _initializeWebViewController() {
    final navigationDelegate = NavigationDelegate(
      onUrlChange: (url) => widget.onUrlChange?.call(url.url),
      onPageFinished: _onPageFinished,
      onProgress: _onProgress,
      onNavigationRequest: _onNavigationRequest,
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
  }

  void _onProgress(int progress) {
    _isPageLoading = progress < 100;
    _progressStreamController.add(progress);
    if (_isPageLoading) {
      _finalLoadTimer?.cancel();
    }
  }

  FutureOr<NavigationDecision> _onNavigationRequest(NavigationRequest request) async {
    final uri = Uri.tryParse(request.url);

    final isExternalBrowserRequest =
        uri?.scheme == _kNavigationRequestScheme && uri?.host == _kNavigationRequestHostExternalBrowser;

    if (isExternalBrowserRequest) {
      final targetUrl = uri?.queryParameters[_kNavigationRequestParamUrl];
      if (targetUrl?.isEmpty ?? true) {
        _logger.warning('Missing or empty external URL');
        return NavigationDecision.prevent;
      }

      final targetUri = Uri.tryParse(targetUrl!);
      if (targetUri == null) {
        _logger.warning('Invalid external URL: $targetUrl');
        return NavigationDecision.prevent;
      }

      if (!await canLaunchUrl(targetUri)) {
        _logger.warning('Cannot launch URL: $targetUri');
        return NavigationDecision.prevent;
      }

      if (!await launchUrl(targetUri, mode: LaunchMode.externalApplication)) {
        _logger.severe('Failed to launch external URL: $targetUri');
      }

      return NavigationDecision.prevent;
    }

    _logger.fine('Navigation request: ${request.url}');
    return NavigationDecision.navigate;
  }

  void _onWebResourceError(WebResourceError error) {
    _logger.warning('WebView error: $error');
    safeSetState(() {
      _currentError = error;
      _latestError = error;
    });
  }
}
