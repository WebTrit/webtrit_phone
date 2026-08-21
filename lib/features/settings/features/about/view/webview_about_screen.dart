import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class WebAboutScreen extends StatefulWidget {
  const WebAboutScreen({
    super.key,
    required this.baseAppAboutUrl,
    required this.userAgent,
    required this.packageInfo,
    required this.infoRepository,
  });

  final Uri baseAppAboutUrl;
  final String userAgent;
  final PackageInfo packageInfo;
  final SystemInfoRepository infoRepository;

  @override
  State<WebAboutScreen> createState() => _WebAboutScreenState();
}

class _WebAboutScreenState extends State<WebAboutScreen> {
  /// Resolved once instead of in `build`: a rebuild would start a second lookup
  /// and remount the web view on a freshly built URL.
  ///
  /// TODO: use session repository
  late final Future<Uri> _coreUrl = widget.infoRepository.getCoreUrl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uri>(
      future: _coreUrl,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        // A failed lookup opens the page without the core URL rather than
        // leaving the screen on a spinner for the rest of the session.
        final coreUrl = snapshot.data?.toString() ?? '';

        return WebViewContainer(
          title: Text(context.l10n.settings_ListViewTileTitle_about),
          initialUri: widget.baseAppAboutUrl.replace(
            queryParameters: {
              'appName': widget.packageInfo.appName,
              'packageName': widget.packageInfo.packageName,
              'version': widget.packageInfo.version,
              'buildNumber': widget.packageInfo.buildNumber,
              'coreUrl': coreUrl,
            },
          ),
          userAgent: widget.userAgent,
        );
      },
    );
  }
}
