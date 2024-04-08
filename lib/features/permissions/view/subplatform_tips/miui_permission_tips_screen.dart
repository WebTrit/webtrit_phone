import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/theme/theme.dart';

class MiuiPermissionTipsScreen extends StatelessWidget {
  const MiuiPermissionTipsScreen({required this.onGoToAppSettings, super.key});

  final VoidCallback onGoToAppSettings;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    final body = Padding(
      padding: const EdgeInsets.all(kInset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: kInset * 2),
          Icon(
            Icons.settings_suggest,
            color: Theme.of(context).colorScheme.primary,
            size: kInset * 6,
          ),
          const SizedBox(height: kInset * 2),
          Text(
            "Miui permission tip description",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          const SizedBox(height: kInset),
          OutlinedButton(
            onPressed: onGoToAppSettings,
            style: elevatedButtonStyles?.primary,
            child: Text("Go to app settings"),
          ),
          const SizedBox(height: kInset),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: elevatedButtonStyles?.primary,
            child: Text("Got it"),
          ),
        ],
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: body,
              ),
            ),
          );
        },
      ),
    );
  }
}
