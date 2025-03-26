import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/extensions/string.dart';

import 'package:webtrit_phone/features/messaging/extensions/string_path_utils.dart';

class ExchangeBar extends StatelessWidget {
  const ExchangeBar({
    super.key,
    required this.text,
    required this.icon,
    this.onCancel,
    this.onConfirm,
  });

  final String text;
  final IconData icon;
  final Function()? onCancel;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
          if (onConfirm != null) ...[
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.check), onPressed: onConfirm, color: Colors.white),
          ],
          if (onCancel != null) ...[
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
          ]
        ],
      ),
    );
  }
}

class AttachmentsExchangeBar extends StatelessWidget {
  const AttachmentsExchangeBar({
    super.key,
    required this.attachments,
    this.icon = Icons.attach_file,
    this.onCancel,
  });

  final List<String> attachments;
  final IconData icon;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: Colors.white),
              if (attachments.isNotEmpty)
                Positioned(
                  right: -2,
                  bottom: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: colorScheme.tertiary, shape: BoxShape.circle),
                    child: Text(
                      attachments.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(child: Builder(builder: (context) {
            return Wrap(
              spacing: 6,
              runSpacing: 4,
              children: attachments.map((attachment) {
                if (attachment.isImagePath) return imagePreview(attachment);
                return filePreview(attachment.split('/').last);
              }).toList(),
            );
          })),
          if (onCancel != null) ...[
            IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
          ]
        ],
      ),
    );
  }

  Widget filePreview(String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fileName.split('.').first.limit(10),
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '.${fileName.split('.').last}',
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget imagePreview(String path) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 32),
      ),
    );
  }
}
