import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/app_bar.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key key}) : super(key: key);

  @override
  _RecentsPageState createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> with PageSnackBarMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: RecentsVisibilityFilter.values.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        bottom: TabBar(
          tabs: RecentsVisibilityFilter.values
              .map((value) => Tab(child: Text(value.l10n(context), softWrap: false)))
              .toList(),
          controller: _tabController,
          labelColor: themeData.textTheme.caption.color,
        ),
      ),
      body: BlocConsumer<RecentsBloc, RecentsState>(
        listener: (context, state) {
          if (state is RecentsLoadFailure) {
            showErrorSnackBar(context, 'Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! RecentsRefreshFailure;
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
                return (context.read<RecentsBloc>()..add(RecentsRefreshed()))
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
                      context.read<CallBloc>().add(CallOutgoingStarted(username: recent.username));
                    },
                    onLongPress: () {
                      showSnackBar(context, 'LongPress on "${recent.username}"');
                    },
                    onDeleted: (recent) {
                      showSnackBar(context, '"${recent.username}" deleted');

                      context.read<RecentsBloc>().add(RecentsDelete(recent: recent));
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
                onPressed: () => context.read<RecentsBloc>().add(RecentsInitialLoaded()),
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
              recent.time.format(context),
              style: TextStyle(color: Colors.grey),
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
        title: Text(
          recent.username,
          style: TextStyle(color: recent.isComplete ? null : Colors.red),
        ),
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
            new TextButton(
              child: new Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new TextButton(
              child: new Text("Yes".toUpperCase()),
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
  String format(BuildContext context) {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    if (midnight.isBefore(this)) {
      return AppLocalizations.of(context).recentTimeBeforeMidnight(this);
    } else {
      return AppLocalizations.of(context).recentTimeAfterMidnight(this);
    }
  }
}
