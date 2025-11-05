import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.text, this.launchLinkableElement = false});

  final String text;
  final bool launchLinkableElement;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Linkify(
      text: text,
      onOpen: !launchLinkableElement ? null : (link) => context.read<LoginCubit>().launchLinkableElement(link),
      highlightLinkifyElement: launchLinkableElement,
      style: LinkifyStyle(
        style: themeData.textTheme.bodyMedium,
        linkStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
