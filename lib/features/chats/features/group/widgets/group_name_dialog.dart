import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class GroupNameDialog extends StatefulWidget {
  const GroupNameDialog({super.key, this.initialName});

  final String? initialName;

  @override
  State<GroupNameDialog> createState() => _GroupNameDialogState();
}

class _GroupNameDialogState extends State<GroupNameDialog> {
  final formKey = GlobalKey<FormState>();
  late final textController = TextEditingController(text: widget.initialName);

  onConfirm() {
    Navigator.of(context).pop(textController.text);
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  bool get isValid => formKey.currentState?.validate() == true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.chats_GroupNameDialog_title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: textController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) return context.l10n.chats_GroupNameDialog_fieldValidation_empty;
                    if (value.length < 3) return context.l10n.chats_GroupNameDialog_fieldValidation_short;
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: context.l10n.chats_GroupNameDialog_fieldLabel,
                    hintText: context.l10n.chats_GroupNameDialog_fieldHint,
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onCancel,
                      child: Text(context.l10n.chats_GroupNameDialog_cancelBtnText),
                    ),
                    TextButton(
                      onPressed: isValid ? onConfirm : null,
                      child: Text(context.l10n.chats_GroupNameDialog_saveBtnText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
