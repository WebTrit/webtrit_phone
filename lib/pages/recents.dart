import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class RecentsPage extends StatelessWidget with PageSnackBarMixin {
  const RecentsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recents'),
      ),
      body: BlocConsumer<RecentsBloc, RecentsState>(
        listener: (context, state) {
          if (state is RecentsLoadFailure) {
            showErrorSnackBar(context, 'Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! RecentsRefreshFailure && current is! RecentsLoadUnchangedSuccess;
        },
        // ignore: missing_return
        builder: (context, state) {
          if (state is RecentsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RecentsLoadSuccess) {
            return RefreshIndicator(
              onRefresh: () {
                hideSnackBar(context);
                return (BlocProvider.of<RecentsBloc>(context)..add(RecentsRefreshed()))
                    .skip(1)
                    .firstWhere((state) => state is RecentsLoadSuccess || state is RecentsRefreshFailure);
              },
              child: ListView.separated(
                itemCount: state.recents.length,
                itemBuilder: (context, index) {
                  final recent = state.recents[index];
                  return RecentTile(
                    recent: recent,
                    onInfoTap: () {
                      showSnackBar(context, 'Tap info on "${recent.username}"');
                    },
                    onTap: () {
                      showSnackBar(context, 'Tap on "${recent.username}"');
                    },
                    onLongPress: () {
                      showSnackBar(context, 'LongPress on "${recent.username}"');
                    },
                    onDeleted: (recent) {
                      showSnackBar(context, '"${recent.username}" deleted');

                      BlocProvider.of<RecentsBloc>(context).add(
                        RecentsDelete(recent: recent),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                },
              ),
            );
          }
          if (state is RecentsInitialLoadFailure) {
            return Center(
              child: OutlineButton(
                onPressed: () => BlocProvider.of<RecentsBloc>(context).add(RecentsInitialLoaded()),
                child: Text('Refresh'),
              ),
            );
          }
        },
      ),
    );
  }
}

class RecentTile extends StatelessWidget {
  final Recent recent;
  final GestureTapCallback onInfoTap;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final void Function(Recent) onDeleted;

  RecentTile({
    Key key,
    @required this.recent,
    this.onInfoTap,
    this.onTap,
    this.onLongPress,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(recent),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(right: 16),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
      confirmDismiss: (direction) => _confirmDelete(context, recent),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(recent),
      direction: DismissDirection.endToStart,
      child: ListTile(
        leading: Icon(recent.direction.icon),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              recent.time.format(),
              style: DefaultTextStyle.of(context).style.apply(color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: GestureDetector(
                child: Icon(
                  Icons.info_outline,
                ),
                onTap: onInfoTap,
              ),
            ),
          ],
        ),
        title: Text(recent.username),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, Recent recent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirm delete"),
          content: new Text("Are you sure you want to delete \"${recent.username}\"?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: new Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              textColor: Colors.red,
              splashColor: Colors.red[100],
            ),
          ],
        );
      },
    );
  }
}

extension _DirectionConverting on Direction {
  IconData get icon {
    switch (this) {
      case Direction.incoming:
        return Icons.call_received;
      case Direction.outgoing:
        return Icons.call_made;
      default:
        return Icons.close;
    }
  }
}

extension _DateTimeFormatting on DateTime {
  String format() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    if (midnight.isBefore(this)) {
      return DateFormat.Hm().format(this);
    } else {
      return DateFormat.yMd().format(this);
    }
  }
}
