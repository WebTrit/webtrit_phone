import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    Key? key,
    required this.favorite,
    this.onTap,
    this.onLongPress,
    this.onInfoPressed,
    this.onDeleted,
  }) : super(key: key);

  final Favorite favorite;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final VoidCallback? onInfoPressed;
  final void Function(Favorite)? onDeleted;

  @override
  Widget build(BuildContext context) {
    final onDeleted = this.onDeleted;
    return Dismissible(
      key: ObjectKey(favorite),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
      confirmDismiss: (direction) => _confirmDelete(context, favorite),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(favorite),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: LeadingAvatar(
          username: favorite.name,
        ),
        trailing: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.info_outline),
          onPressed: onInfoPressed,
        ),
        title: Text(
          favorite.name,
        ),
        subtitle: Text('${favorite.label.capitalize}: ${favorite.number}'),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, Favorite favorite) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm delete"),
          content: const Text("Are you sure you want to delete current favorite?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No".toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text("Yes".toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
