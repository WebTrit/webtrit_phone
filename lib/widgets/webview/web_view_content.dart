import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/webview/webview_progress_indicator.dart';

class WebViewContent extends StatelessWidget {
  final bool hasWebViewError;
  final Widget Function(BuildContext) errorBuilder;
  final Widget Function(BuildContext) successBuilder;
  final Stream<int> progressStream;

  const WebViewContent({
    super.key,
    required this.hasWebViewError,
    required this.errorBuilder,
    required this.successBuilder,
    required this.progressStream,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        hasWebViewError ? errorBuilder(context) : successBuilder(context),
        WebViewProgressIndicator(stream: progressStream),
      ],
    );
  }
}
