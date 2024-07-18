import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

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
                Text('Add user', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: textController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter phone number';
                    if (value.length < 8) return 'Phone number is too short';
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[+\d]+$'))],
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    hintText: 'Enter phone number',
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: onCancel, child: const Text('Cancel')),
                    TextButton(onPressed: isValid ? onConfirm : null, child: const Text('Add')),
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
