import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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
                Text('Group name', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: textController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter group name';
                    if (value.length < 3) return 'Group name is too short';
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Group name',
                    hintText: 'Enter group name',
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: onCancel, child: const Text('Cancel')),
                    TextButton(onPressed: isValid ? onConfirm : null, child: const Text('Save')),
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
