import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/app/constants.dart';

extension WebViewControllerExtension on WebViewController {
  Future<void> loadBlank() {
    return loadRequest(Uri.parse(kBlankUri));
  }
}
