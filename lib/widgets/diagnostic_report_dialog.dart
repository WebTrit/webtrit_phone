import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/services/diagnostic/diagnostic.dart';

import 'circular_progress_template.dart';

class DiagnosticReportDialog extends StatefulWidget {
  const DiagnosticReportDialog({super.key});

  @override
  State<DiagnosticReportDialog> createState() => _DiagnosticReportDialogState();
}

class _DiagnosticReportDialogState extends State<DiagnosticReportDialog> {
  final TextEditingController _commentController = TextEditingController();
  bool _includeAdvancedLogs = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    setState(() => _isSubmitting = true);

    final result = DiagnosticReportOptions(
      comment: _commentController.text.trim().isEmpty ? null : _commentController.text.trim(),
      includeAdvancedLogs: _includeAdvancedLogs,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(context.l10n.diagnosticReportDialogTitle),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.diagnosticReportDialogContent, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          _LogsSwitchTile(
            value: _includeAdvancedLogs,
            onChanged: _isSubmitting ? null : (value) => setState(() => _includeAdvancedLogs = value),
          ),
          const SizedBox(height: 16),
          _CommentSection(controller: _commentController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(null),
          child: Text(context.l10n.diagnosticReportDialogCancelButtonLabel),
        ),
        FilledButton.icon(
          onPressed: _isSubmitting ? null : _onSubmit,

          icon: _isSubmitting
              ? const CircularProgressTemplate(size: 12, width: 1)
              : const Icon(Icons.send_rounded, size: 18),
          label: Text(context.l10n.diagnosticReportDialogSendReportButtonLabel),
        ),
      ],
    );
  }
}

class _LogsSwitchTile extends StatelessWidget {
  const _LogsSwitchTile({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      title: Text(
        context.l10n.diagnosticReportDialogIncludeSystemLogsSwitchTileTitle,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          context.l10n.diagnosticReportDialogIncludeSystemLogsSwitchTileSubtitle,
          style: theme.textTheme.bodySmall,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _CommentSection extends StatelessWidget {
  const _CommentSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: const Border(),
      collapsedShape: const Border(),
      title: Text(
        context.l10n.diagnosticReportDialogAddNoteExpansionTileTitle,
        style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
      ),
      leading: Icon(Icons.comment_outlined, size: 20, color: theme.colorScheme.primary),
      children: [
        TextField(
          controller: controller,
          maxLines: 3,
          minLines: 2,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: context.l10n.diagnosticReportDialogCommentTextFieldHintText,
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
