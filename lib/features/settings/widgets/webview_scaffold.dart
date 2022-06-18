import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/data/package_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class WebViewScaffold extends StatefulWidget {
  const WebViewScaffold({
    Key? key,
    this.title,
    required this.initialUri,
    this.addLocaleNameToQueryParameters = true,
  }) : super(key: key);

  final Widget? title;
  final Uri initialUri;
  final bool addLocaleNameToQueryParameters;

  @override
  State<WebViewScaffold> createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  late final WebViewController _controller;

  final StreamController<int> _progressStreamController = StreamController<int>.broadcast();
  Timer? _resetProgressTimer;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final initialUriQueryParameters = Map.of(widget.initialUri.queryParameters);
    if (widget.addLocaleNameToQueryParameters) {
      initialUriQueryParameters['localeName'] = context.l10n.localeName;
    }
    final initialUrl = widget.initialUri.replace(queryParameters: initialUriQueryParameters).toString();

    final userAgent = '${PackageInfo().appName}/${PackageInfo().version} '
        '(${Platform.operatingSystem}; ${Platform.operatingSystemVersion})';

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
              _controller.reload();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: StreamBuilder<int>(
            stream: _progressStreamController.stream,
            builder: (context, snapshot) {
              final snapshotData = snapshot.data;
              if (snapshotData != null && snapshotData != -1) {
                return LinearProgressIndicator(
                  value: snapshotData / 100,
                  backgroundColor: themeData.colorScheme.surface,
                  minHeight: 2.0,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
      body: WebView(
        onWebViewCreated: (controller) => _controller = controller,
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (_) {
          _resetProgressTimer?.cancel();
          _resetProgressTimer = null;
        },
        onPageFinished: (_) {
          _resetProgressTimer = Timer(kTabScrollDuration, () {
            _progressStreamController.add(-1);
          });
        },
        onProgress: (progress) {
          _progressStreamController.add(progress);
        },
        userAgent: userAgent,
        zoomEnabled: false,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        allowsInlineMediaPlayback: true,
        backgroundColor: themeData.colorScheme.background,
      ),
    );
  }
}
