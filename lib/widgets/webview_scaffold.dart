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
    this.injectedScriptBuilder,
    this.webViewController,
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

  /// Optional builder that returns a JavaScript snippet to be injected into the WebView
  /// after the page has finished loading or when the widget is updated.
  ///
  /// Use this to dynamically provide runtime data (e.g., auth tokens, user session info)
  /// to the embedded page via JavaScript. The builder is re-evaluated on reloads and updates,
  /// and the script will only be injected if it has changed since the last injection.
  final FutureOr<String>? Function()? injectedScriptBuilder;

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

  String? _injectedScript;

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
      // Retrieve and store the initial injected script, if provided, for use after the page loads
      final injectedScript = await widget.injectedScriptBuilder?.call();

      if (!kIsWeb) {
        await Future.wait([
          _webViewController.setUserAgent(widget.userAgent),
          _webViewController.enableZoom(false),
          _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
          for (var MapEntry(key: name, value: onMessageReceived) in widget.javaScriptChannels.entries)
            _webViewController.addJavaScriptChannel(name, onMessageReceived: onMessageReceived),
          _webViewController.setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                if (_currentError == null) {
                  _latestError = null; // Reset the error only if the page loaded successfully
                }
                setState(() {
                  _currentError = null; // Always reset the current error after page finishes loading
                });

                // Inject the script after the page has loaded,onPageFinished can be called multiple times so need clear the injected script for correct injection
                _injectedScript = null;

                // Inject the script if available
                unawaited(_injectScriptIfAvailable(injectedScript));
              },
              onProgress: (progress) {
                _progressStreamController.add(progress);
              },
              onWebResourceError: (error) {
                setState(() {
                  _currentError = error; // Capture the current error
                  _latestError = error; // Store the error for future reference or display
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

    // Rebuild case: check if a new script is available from the builder,
    // and inject it into the WebView if it differs from the last injected one.
    () async {
      final injectedScript = await widget.injectedScriptBuilder?.call();
      unawaited(_injectScriptIfAvailable(injectedScript));
    }();
  }

  @override
  void dispose() {
    () async {
      if (!kIsWeb) {
        await _webViewController.setNavigationDelegate(NavigationDelegate());
      }
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

  // TODO: consider encrypting the injected script to protect sensitive data
  Future<void> _injectScriptIfAvailable(String? script) async {
    if (script != null && script.trim().isNotEmpty && script != _injectedScript) {
      try {
        await _webViewController.runJavaScript(script);
        _injectedScript = script;
        _logger.finest('injected script: $script');
      } catch (e, st) {
        _logger.severe('failed to inject script: $e\n$st');
      }
    } else {
      _logger.finest('script unchanged or empty, skipping injection');
    }
  }
}
