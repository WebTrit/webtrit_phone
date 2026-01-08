import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class PermissionTips extends StatelessWidget {
  const PermissionTips({
    super.key,
    required this.title,
    required this.instruction,
    required this.onGoToAppSettings,
    required this.onPop,
  });

  final String title;
  final List<String> instruction;
  final VoidCallback onGoToAppSettings;
  final VoidCallback? onPop;

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
          Icon(Icons.settings_suggest, color: themeData.colorScheme.primary, size: kInset * 6),
          const SizedBox(height: kInset * 2),
          Text(title, textAlign: TextAlign.center, style: themeData.textTheme.bodyLarge),
          const SizedBox(height: kInset / 4),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: instruction.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: kInset / 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${entry.key + 1}. ', style: themeData.textTheme.labelLarge),
                        Expanded(child: Text(entry.value, style: themeData.textTheme.labelLarge)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Text(
            context.l10n.permission_manufacturer_Text_trailing,
            textAlign: TextAlign.center,
            style: themeData.textTheme.labelMedium,
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
            key: permissionTipsButtonKey,
            onPressed: onPop,
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
              constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(child: InertSafeArea(bottom: true, child: body)),
            ),
          );
        },
      ),
    );
  }
}
