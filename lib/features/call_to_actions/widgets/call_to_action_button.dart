import 'package:flutter/material.dart';

class DemoActionButton extends StatelessWidget {
  const DemoActionButton({super.key, required this.title, required this.description, this.thumbnailUrl});

  final String? title;
  final String? description;
  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final title = this.title ?? '';
    final description = this.description ?? '';
    final thumbnailUrl = this.thumbnailUrl ?? '';

    return Material(
      color: Colors.transparent,
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.primary,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (thumbnailUrl.isNotEmpty) Positioned.fill(child: Image.network(thumbnailUrl, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(color: colorScheme.surface),
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.surface),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4, // Limit the number of lines if needed
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
