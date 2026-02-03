import 'package:flutter/material.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CoreInfoTile extends StatelessWidget {
  const CoreInfoTile({super.key, required this.coreUrl, required this.coreVersion, required this.progress});

  final Uri? coreUrl;
  final Version? coreVersion;
  final bool progress;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final versionLabel = context.l10n.settings_AboutText_CoreVersion;
    final versionValue = progress
        ? ''
        : (coreVersion ?? context.l10n.settings_AboutText_CoreVersionUndefined).toString();

    return CopyToClipboard(
      data: '${coreUrl.toString()}\n$versionLabel $versionValue',
      child: Column(
        children: [
          Text(coreUrl.toString(), textAlign: TextAlign.center),
          Text(versionLabel),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Text(versionValue, style: themeData.textTheme.bodyMedium),
              if (progress)
                SizedCircularProgressIndicator(size: themeData.textTheme.bodyMedium!.fontSize!, strokeWidth: 2),
            ],
          ),
        ],
      ),
    );
  }
}
