import 'package:flutter/material.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({required this.name, this.size = 24, super.key});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    var segments = name.split(' ');
    for (String s in segments) {
      if (s.length > 8) segments[segments.indexOf(s)] = s.substring(0, 8);
    }
    if (segments.length > 3) segments = segments.sublist(0, 3);
    var text = segments.join('\n');
    if (text.isEmpty) text = ' ';

    return CircleAvatar(
      radius: size,
      backgroundColor: colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(child: Text(text.toUpperCase(), softWrap: true, textAlign: TextAlign.center)),
      ),
    );
  }
}
