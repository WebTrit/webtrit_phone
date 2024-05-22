import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../models/models.dart';
import '../extensions/extensions.dart';

class UndefinedScreen extends StatelessWidget {
  const UndefinedScreen({
    super.key,
    required this.undefinedType,
  });

  final UndefinedType undefinedType;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(kInset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: kInset * 2),
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: kInset * 6,
                      ),
                      const SizedBox(height: kInset * 2),
                      Text(
                        undefinedType.l10n(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      const SizedBox(height: kInset),
                      OutlinedButton(
                        onPressed: () => context.router.pop(),
                        style: elevatedButtonStyles?.primary,
                        child: Text(context.l10n.permission_Button_request),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
