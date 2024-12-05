import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class CallToActionsWebScreen extends StatefulWidget {
  const CallToActionsWebScreen({
    super.key,
    required this.initialUrl,
  });

  final Uri initialUrl;

  @override
  State<CallToActionsWebScreen> createState() => _CallToActionsWebScreenState();
}

class _CallToActionsWebScreenState extends State<CallToActionsWebScreen> with WidgetsBindingObserver {
  final WebViewController _webViewController = WebViewController();

  WebResourceError? _error;
  Color? _backgroundColorCache;
  bool _isVisibleProgress = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    () async {
      await Future.wait([
        _webViewController.setNavigationDelegate(
          NavigationDelegate(
            onUrlChange: (UrlChange change) {
              if (Uri.parse(change.url!).queryParameters['status'] == 'completed') {
                context.back();
              }
            },
            onPageFinished: (url) {
              _webViewController.runJavaScript(_definesCssVariablesJavascript(context));
              _isVisibleProgress = false;
              setState(() {});
            },
            onWebResourceError: (error) async {
              if (_error == null) {
                _error = error;
                _webViewController.reload();
              } else {
                final result = await _showWebResourceErrorDialog(context, error);
                _isVisibleProgress = false;
                _error = null;
                setState(() {});

                if (!mounted) return;
                if (result == null) {
                  context.back();
                } else {
                  _webViewController.loadRequest(widget.initialUrl);
                }
              }
            },
          ),
        ),
        _webViewController.enableZoom(false),
        _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
      ]);
      await _webViewController.loadRequest(widget.initialUrl);
    }();
  }

  Future<bool?> _showWebResourceErrorDialog(BuildContext context, WebResourceError error) {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(context.l10n.webRegistration_ErrorAcknowledgeDialog_title),
          content: Text(
            error.description,
          ),
          actions: [
            TextButton(
              child: Text(context.l10n.webRegistration_ErrorAcknowledgeDialogActions_skip),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            TextButton(
              child: Text(context.l10n.webRegistration_ErrorAcknowledgeDialogActions_retry),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final themeData = Theme.of(context);
    final backgroundColor = themeData.colorScheme.surfaceBright;
    if (_backgroundColorCache != backgroundColor) {
      _backgroundColorCache = backgroundColor;
      _webViewController.setBackgroundColor(backgroundColor);
    }
  }

  @override
  void didUpdateWidget(CallToActionsWebScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialUrl != oldWidget.initialUrl) {
      _webViewController.loadRequest(widget.initialUrl);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    }
    if (state == AppLifecycleState.paused) {
      _webViewController.setJavaScriptMode(JavaScriptMode.disabled);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    () async {
      await _webViewController.setNavigationDelegate(NavigationDelegate());
      await _webViewController.loadBlank();
    }();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isVisibleProgress)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  String _definesCssVariablesJavascript(BuildContext context) {
    final safeAreaPadding = MediaQuery.of(context).padding;
    return {
      '--safe-area-inset-left': safeAreaPadding.left,
      '--safe-area-inset-top': safeAreaPadding.top,
      '--safe-area-inset-right': safeAreaPadding.right,
      '--safe-area-inset-bottom': safeAreaPadding.bottom,
    }
        .entries
        .map((mapEntry) => "document.documentElement.style.setProperty('${mapEntry.key}', '${mapEntry.value}px');")
        .join();
  }
}
