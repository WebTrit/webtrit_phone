import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/models/resource_loader.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// One row of the embedded resources listed on the About screen: the address,
/// which opens the resource when tapped and can be copied on a long press.
class EmbeddedLinkTile extends StatelessWidget {
  const EmbeddedLinkTile({super.key, required this.resource, required this.onOpen});

  final EmbeddedData resource;

  /// Called when the row is tapped. Never called for a resource that cannot be
  /// opened, so the caller does not have to check.
  final ValueChanged<EmbeddedData> onOpen;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final address = resource.uri.toString();

    // The screen that opens a resource resolves its loader while building and
    // fails outright on a scheme no loader claims, which a caller cannot catch.
    // Such a row still shows its address; it just does not offer to open it.
    final openable = ResourceLoader.supportsUri(resource.uri);

    final baseStyle = themeData.textTheme.bodySmall;
    final style = openable
        ? baseStyle?.copyWith(
            color: themeData.colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: themeData.colorScheme.primary,
          )
        : baseStyle;

    return CopyToClipboard(
      data: address,
      child: ListTile(
        onTap: openable ? () => onOpen(resource) : null,
        title: Text(address, style: style, textAlign: TextAlign.center),
      ),
    );
  }
}
