import 'package:flutter/material.dart';
import 'package:webtrit_phone/widgets/back_button.dart';

class WebViewToolbar extends StatelessWidget {
  final Widget? title;
  final VoidCallback onReload;

  const WebViewToolbar({
    super.key,
    required this.title,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: const ExtBackButton(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onReload,
        ),
      ],
    );
  }
}
