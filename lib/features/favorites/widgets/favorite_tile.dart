import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoriteTile extends StatelessWidget {
  final Favorite favorite;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final VoidCallback? onAudioPressed;
  final VoidCallback? onVideoPressed;
  final void Function(Favorite)? onDeleted;

  const FavoriteTile({
    Key? key,
    required this.favorite,
    this.onTap,
    this.onLongPress,
    this.onAudioPressed,
    this.onVideoPressed,
    this.onDeleted,
  }) : super(key: key);

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.call),
              onPressed: onAudioPressed,
            ),
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.videocam),
              onPressed: onVideoPressed,
            ),
          ],
        ),
        title: Text(
          favorite.name,
        ),
        subtitle: Text(favorite.label),
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
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
