import 'package:flutter/material.dart';

import 'copy_to_clipboard.dart';

class ErrorFieldModel {
  ErrorFieldModel(this.title, this.details);

  final String title;
  final String details;
}

class ErrorDetailsView extends StatelessWidget {
  final String title;
  final List<ErrorFieldModel> fields;

  const ErrorDetailsView({
    super.key,
    required this.title,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final labelTitleStyle = textTheme.labelLarge?.copyWith(color: colorScheme.secondary);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: textTheme.titleSmall,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: fields.length,
              itemBuilder: (context, index) {
                return CopyToClipboard(
                  data: fields[index].details,
                  child: ListTile(
                    title: Text(
                      fields[index].title,
                      style: labelTitleStyle,
                    ),
                    subtitle: Text(
                      fields[index].details,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
