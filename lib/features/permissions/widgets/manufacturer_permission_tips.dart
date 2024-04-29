import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

class ManufacturerPermissionTips extends StatelessWidget {
  const ManufacturerPermissionTips({
    super.key,
    required this.instruction,
    required this.onGoToAppSettings,
  });

  final List<String> instruction;
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
            context.l10n.permission_manufacturer_Text_heading,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: kInset / 4),
          Card(
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: instruction.map((it) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: kInset / 8),
                      child: Text(it, textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge),
                    );
                  }).toList()),
            ),
          ),
          Text(
            context.l10n.permission_manufacturer_Text_trailing,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(),
          const SizedBox(height: kInset),
          OutlinedButton(
            onPressed: onGoToAppSettings,
            style: elevatedButtonStyles?.neutral,
            child: Text(context.l10n.permission_manufacturer_Button_toSettings),
          ),
          const SizedBox(height: kInset / 4),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: elevatedButtonStyles?.primary,
            child: Text(context.l10n.permission_manufacturer_Button_gotIt),
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
