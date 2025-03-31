import 'package:flutter/material.dart';
import 'package:webtrit_phone/extensions/string.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';

class FileView extends StatelessWidget {
  const FileView(this.path, {super.key});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            path.fileName.limit(20),
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '.${path.fileExtension}',
            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
