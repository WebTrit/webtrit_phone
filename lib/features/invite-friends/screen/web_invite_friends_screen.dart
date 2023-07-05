import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

class WebInviteFriendsScreen extends StatefulWidget {
  const WebInviteFriendsScreen({
    Key? key,
    required this.initialUri,
  }) : super(key: key);

  final Uri initialUri;

  @override
  State<WebInviteFriendsScreen> createState() => _WebInviteFriendsScreenState();
}

class _WebInviteFriendsScreenState extends State<WebInviteFriendsScreen> {
  final WebViewController _webViewController = WebViewController();

  Color? _backgroundColorCache;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.wait([
        _webViewController.setNavigationDelegate(
          NavigationDelegate(
            onUrlChange: (UrlChange change) {
              if (Uri.parse(change.url!).queryParameters['status'] == 'completed') {
                context.pop();
              }
            },
            onPageFinished: (url) {
              _webViewController.runJavaScript(_definesCssVariablesJavascript(context));
            },
            onWebResourceError: (error) async {
              final result = await _showWebResourceErrorDialog(context, error);

              if (!mounted) return;
              if (result == null) {
                context.pop();
              } else {
                _webViewController.loadRequest(widget.initialUri);
              }
            },
          ),
        ),
        _webViewController.enableZoom(false),
        _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
      ]);
      await _webViewController.loadRequest(widget.initialUri);
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
              child: Text(context.l10n.webRegistration_ErrorAcknowledgeDialogActions_demo),
              onPressed: () => Navigator.of(context).pop(false),
            ),
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
    final backgroundColor = themeData.colorScheme.background;
    if (_backgroundColorCache != backgroundColor) {
      _backgroundColorCache = backgroundColor;
      _webViewController.setBackgroundColor(backgroundColor);
    }
  }

  @override
  void didUpdateWidget(WebInviteFriendsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialUri != oldWidget.initialUri) {
      _webViewController.loadRequest(widget.initialUri);
    }
  }

  @override
  void dispose() {
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
      body: WebViewWidget(controller: _webViewController),
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
