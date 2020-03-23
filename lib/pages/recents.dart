import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';

class RecentsPage extends StatelessWidget {
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
            _showErrorSnackBar(context, 'Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! RecentsRefreshFailure;
        },
        // ignore: missing_return
        builder: (context, state) {
          if (state is RecentsInitial) {
            return Center(
              child: Icon(
                Icons.history,
                size: 120,
              ),
            );
          }
          if (state is RecentsLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RecentsLoadSuccess) {
            return RefreshIndicator(
              onRefresh: () {
                _hideSnackBar(context);
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
                      _showSnackBar(context, 'Tap info on "${recent.username}"');
                    },
                    onTap: () {
                      _showSnackBar(context, 'Tap on "${recent.username}"');
                    },
                    onLongPress: () {
                      _showSnackBar(context, 'LongPress on "${recent.username}"');
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
          if (state is RecentsLoadFailure) {
            return Center(
              child: OutlineButton(
                onPressed: () => BlocProvider.of<RecentsBloc>(context).add(RecentsFetched()),
                child: Text('Refresh'),
              ),
            );
          }
        },
      ),
    );
  }

  void _hideSnackBar(BuildContext context) {
    Scaffold.of(context).removeCurrentSnackBar();
  }

  void _showSnackBar(BuildContext context, String data) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(data),
    ));
  }

  void _showErrorSnackBar(BuildContext context, String data) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(data),
    ));
  }
}

class RecentTile extends StatelessWidget {
  final Recent recent;
  final GestureTapCallback onInfoTap;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  RecentTile({
    Key key,
    @required this.recent,
    this.onInfoTap,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
