import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/data/data.dart';

const String kDemoPage = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>WebTrit Web Registration Example</title>
  <style>
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
  WebRegistrationPage({
    Key key,
    @required this.initialUrl,
  }) : super(key: key);

  final String initialUrl;

  @override
  _WebRegistrationPageState createState() => _WebRegistrationPageState();
}

class _WebRegistrationPageState extends State<WebRegistrationPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
            name: 'WebTritTokenChannel',
            onMessageReceived: (JavascriptMessage message) async {
              final token = message.message;
              await SecureStorage.writeToken(token);

              Navigator.pushReplacementNamed(context, '/register');
            }),
      ].toSet(),
      onWebViewCreated: (WebViewController controller) {
        _controller.complete(controller);
      },
      onPageStarted: (url) async {
      },
      onPageFinished: (url) async {
      },
      onWebResourceError: (WebResourceError error) async {
        final result = await _showWebResourceErrorDialog(context, error);
        if (result == null) {
          Navigator.pushReplacementNamed(context, '/register');
        } else {
          final webViewController = await _controller.future;
          webViewController.loadUrl(result ? widget.initialUrl : _demoInitialUrl());
        }
      },
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
    );
  }

  Future<bool> _showWebResourceErrorDialog(BuildContext context, WebResourceError error) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'WebResourceError',
          ),
          content: Text(
            error.description,
          ),
          actions: <Widget>[
            TextButton(
              child: new Text("Demo".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: new Text("Skip".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: new Text("Retry".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  String _demoInitialUrl() {
    return 'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(kDemoPage))}';
  }
}
