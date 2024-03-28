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

class WebViewScaffold extends StatefulWidget {
  const WebViewScaffold({
    super.key,
    this.title,
    required this.initialUri,
    this.addLocaleNameToQueryParameters = true,
  });

  final Widget? title;
  final Uri initialUri;
  final bool addLocaleNameToQueryParameters;

  @override
  State<WebViewScaffold> createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  final _webViewController = WebViewController();
  final _progressStreamController = StreamController<int>.broadcast();

  Color? _backgroundColorCache;
  Uri? _effectiveInitialUrlCache;

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
          _webViewController.setNavigationDelegate(
            NavigationDelegate(
              onProgress: (progress) {
                _progressStreamController.add(progress);
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
    final backgroundColor = themeData.colorScheme.background;
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
      appBar: AppBar(
        title: widget.title,
        leading: const ExtBackButton(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              _webViewController.reload();
            },
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          WebViewProgressIndicator(
            stream: _progressStreamController.stream,
          ),
        ],
      ),
    );
  }
}
