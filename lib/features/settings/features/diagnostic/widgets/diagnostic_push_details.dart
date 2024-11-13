import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

class DiagnosticPushDetails extends StatelessWidget {
  const DiagnosticPushDetails({
    super.key,
    this.onTap,
    required this.status,
  });

  final PushTokenStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: const Icon(Icons.info_outline),
            title: Text(context.l10n.diagnosticPushDetails_configuration_title),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (status.type.isSuccess)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        context.l10n.diagnosticPushDetails_successMessage,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.green),
                      ),
                    ),
                  if (status.type.isError)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        status.error!,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                      ),
                    ),
                  if (status.type.isError)
                    Text.rich(
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
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
