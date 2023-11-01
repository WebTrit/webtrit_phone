import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

const String kDemoPage = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>WebTrit Web Registration Example</title>
  <style>
    body {
      margin-top: var(--safe-area-inset-top);
    }
    p {
      text-align: center;
    }
  </style>
</head>
<body>
  <p>
    <label for="token">Token:</label>
    <input type="text" id="token" name="token" value="Test token 123">
  </p>
  <p>
    <button class="block-center" onclick="WebTritTokenChannel.postMessage(document.getElementById('token').value)">Write token</button  
  </p>
</body>
</html>
''';

class WebRegistrationScreen extends StatefulWidget {
  static const initialUriQueryParameterName = 'initialUrl';

  const WebRegistrationScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  @override
  State<WebRegistrationScreen> createState() => _WebRegistrationScreenState();
}

class _WebRegistrationScreenState extends State<WebRegistrationScreen> {
  final WebViewController _webViewController = WebViewController();

  Color? _backgroundColorCache;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.wait([
        _webViewController.enableZoom(false),
        _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted),
        _webViewController.addJavaScriptChannel(
          'WebTritTokenChannel',
          onMessageReceived: (JavaScriptMessage message) async {
            final token = message.message;
            await SecureStorage().writeToken(token);

            if (!mounted) return;
            context.goNamed(MainRoute.favorites);
          },
        ),
        _webViewController.setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (url) {
              _webViewController.runJavaScript(_definesCssVariablesJavascript(context));
            },
            onWebResourceError: (error) async {
              final result = await _showWebResourceErrorDialog(context, error);

              if (!mounted) return;
              if (result == null) {
                context.goNamed(AppRoute.login);
              } else {
                _webViewController.loadRequest(result ? widget.initialUri : _demoInitialUri());
              }
            },
          ),
        ),
      ]);
      await _webViewController.loadRequest(widget.initialUri);
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
  }

  @override
  void didUpdateWidget(WebRegistrationScreen oldWidget) {
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
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _webViewController);
  }

  Uri _demoInitialUri() {
    return Uri.parse('data:text/html;base64,${base64Encode(const Utf8Encoder().convert(kDemoPage))}');
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
