import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'webview_progress_indicator.dart';

export 'package:webview_flutter/webview_flutter.dart' show JavaScriptMessage;

class WebViewScaffold extends StatefulWidget {
  const WebViewScaffold({
    super.key,
    this.title,
    required this.initialUri,
    this.addLocaleNameToQueryParameters = true,
    this.javaScriptChannels = const {},
    this.errorPlaceholder,
    this.showToolbar = true,
  });

  final Widget? title;
  final Uri initialUri;
  final bool addLocaleNameToQueryParameters;
  final Map<String, void Function(JavaScriptMessage)> javaScriptChannels;
  final Widget? Function(BuildContext context, WebResourceError error, WebViewController controller)? errorPlaceholder;
  final bool showToolbar;

  @override
  State<WebViewScaffold> createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  final _webViewController = WebViewController();
  final _progressStreamController = StreamController<int>.broadcast();

  Color? _backgroundColorCache;
  Uri? _effectiveInitialUrlCache;

  WebResourceError? _latestError;
  WebResourceError? _currentError;

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

    final userAgent = '${PackageInfo().appName}/${PackageInfo().version} '
        '(${Platform.operatingSystem}; ${Platform.operatingSystemVersion})';

    () async {
      if (!kIsWeb) {
        await Future.wait([
          _webViewController.setUserAgent(userAgent),
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
    if (_backgroundColorCache != backgroundColor) {
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
      await _webViewController.setNavigationDelegate(NavigationDelegate());
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
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              (widget.errorPlaceholder != null && _latestError != null)
                  ? widget.errorPlaceholder!(context, _latestError!, _webViewController) ?? const SizedBox.shrink()
                  : WebViewWidget(controller: _webViewController),
              WebViewProgressIndicator(stream: _progressStreamController.stream),
            ],
          );
        },
      ),
    );
  }
}
