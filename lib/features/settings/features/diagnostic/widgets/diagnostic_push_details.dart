import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

class DiagnosticPushDetails extends StatelessWidget {
  const DiagnosticPushDetails({super.key, this.onTap, required this.status});

  final PushTokenStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            trailing: const Icon(Icons.info_outline),
            title: Text(context.l10n.diagnosticPushDetails_configuration_title),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (status.type.isSuccess)
                    ListTile(
                      title: Text(
                        context.l10n.diagnosticPushDetails_successMessage,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.green),
                      ),
                    ),
                  if (status.type.isError)
                    ListTile(
                      title: Text(status.error!, style: textTheme.bodyMedium?.copyWith(color: colorScheme.error)),
                    ),
                  if (status.type.isError)
                    ListTile(
                      title: Text.rich(
                        TextSpan(
                          text: context.l10n.diagnosticPushDetails_errorMessage_intro,
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: context.l10n.diagnosticPushDetails_errorMessage_step1,
                              style: textTheme.labelLarge?.copyWith(height: 2),
                            ),
                            TextSpan(
                              text: context.l10n.diagnosticPushDetails_errorMessage_step2,
                              style: textTheme.labelLarge?.copyWith(height: 2),
                            ),
                            TextSpan(
                              text: context.l10n.diagnosticPushDetails_errorMessage_step3,
                              style: textTheme.labelLarge?.copyWith(height: 2),
                            ),
                            TextSpan(
                              text: context.l10n.diagnosticPushDetails_errorMessage_step4,
                              style: textTheme.labelLarge?.copyWith(height: 2),
                            ),
                            TextSpan(
                              text: context.l10n.diagnosticPushDetails_errorMessage_step5,
                              style: textTheme.labelLarge?.copyWith(height: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
