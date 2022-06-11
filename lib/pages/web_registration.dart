import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/data/data.dart';
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

class WebRegistrationPage extends StatefulWidget {
  const WebRegistrationPage({
    Key? key,
    required this.initialUrl,
  }) : super(key: key);

  final String initialUrl;

  @override
  WebRegistrationPageState createState() => WebRegistrationPageState();
}

class WebRegistrationPageState extends State<WebRegistrationPage> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: {
        JavascriptChannel(
            name: 'WebTritTokenChannel',
            onMessageReceived: (JavascriptMessage message) async {
              final token = message.message;
              await SecureStorage().writeToken(token);

              if (!mounted) return;
              context.goNamed(AppRoute.main);
            }),
      },
      onWebViewCreated: (WebViewController controller) {
        _controller = controller;
      },
      onPageStarted: (url) async {
        //
      },
      onPageFinished: (url) async {
        _controller.runJavascript(_definesCssVariablesJavascript(context));
      },
      onWebResourceError: (WebResourceError error) async {
        final result = await _showWebResourceErrorDialog(context, error);
        if (result == null) {
          if (!mounted) return;
          context.goNamed(AppRoute.login);
        } else {
          _controller.loadUrl(result ? widget.initialUrl : _demoInitialUrl());
        }
      },
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
    );
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

  String _demoInitialUrl() {
    return 'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(kDemoPage))}';
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
