import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class DiagnosticAgreementDetails extends StatefulWidget {
  const DiagnosticAgreementDetails({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.onApply,
  });

  final String title;
  final String description;
  final AgreementStatus status;
  final ValueChanged<AgreementStatus> onApply;

  @override
  State<DiagnosticAgreementDetails> createState() => _DiagnosticAgreementDetailsState();
}

class _DiagnosticAgreementDetailsState extends State<DiagnosticAgreementDetails> {
  late AgreementStatus _agreementStatus = widget.status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppIcon(Icons.contacts),
              const SizedBox(width: 16),
              Text(
                widget.title,
                style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.description,
            style: textTheme.bodyMedium,
          ),
          const Spacer(),
          AgreementCheckbox(
            agreementAccepted: _agreementStatus.isAccepted,
            onChanged: _handleAgreementStatusChange,
            text: context.l10n.contacts_agreement_checkbox_text,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => widget.onApply(_agreementStatus),
              child: Text(context.l10n.contacts_agreement_button_text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAgreementStatusChange(bool value) {
    _agreementStatus = value ? AgreementStatus.accepted : AgreementStatus.declined;
    setState(() {});
  }
}
