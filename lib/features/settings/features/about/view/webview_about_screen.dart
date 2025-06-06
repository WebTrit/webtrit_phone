import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class WebAboutScreen extends StatelessWidget {
  const WebAboutScreen({
    super.key,
    required this.baseAppAboutUrl,
    required this.packageInfo,
    required this.infoRepository,
  });

  final Uri baseAppAboutUrl;
  final PackageInfo packageInfo;
  final SystemInfoRepository infoRepository;

  // TODO(JohnBorys): Replace WebViewScaffold with WebViewContainer after testing is complete

  @override
  Widget build(BuildContext context) {
    return WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_about),
      initialUri: baseAppAboutUrl.replace(queryParameters: {
        'appName': packageInfo.appName,
        'packageName': packageInfo.packageName,
        'version': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
        'coreUrl': infoRepository.coreUrl.toString(),
      }),
      userAgent: UserAgent.of(context),
    );
  }
}
