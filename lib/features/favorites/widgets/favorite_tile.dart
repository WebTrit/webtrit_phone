import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    super.key,
    required this.favorite,
    this.onTap,
    this.onLongPress,
    this.onInfoPressed,
    this.onDeleted,
  });

  final Favorite favorite;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final VoidCallback? onInfoPressed;
  final void Function(Favorite)? onDeleted;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final onDeleted = this.onDeleted;
    return Dismissible(
      key: ObjectKey(favorite),
      background: Container(
        color: themeData.colorScheme.error,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
          ),
        ),
      ),
      confirmDismiss: (direction) => ConfirmDialog.showDangerous(
        context,
        title: context.l10n.favorites_DeleteConfirmDialog_title,
        content: context.l10n.favorites_DeleteConfirmDialog_content,
      ),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(favorite),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: LeadingAvatar(
          username: favorite.name,
          thumbnail: favorite.contact.thumbnail,
          thumbnailUrl: favorite.contact.thumbnailUrl,
          registered: favorite.contact.registered,
        ),
        trailing: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.info_outline),
          onPressed: onInfoPressed,
        ),
        title: Text(favorite.name),
        subtitle: Text('${favorite.label.capitalize}: ${favorite.number}'),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
