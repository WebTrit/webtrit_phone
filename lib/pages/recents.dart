import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({Key? key}) : super(key: key);

  @override
  _RecentsPageState createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      // TODO introduce FilteredRecentsBloc
      setState(() {});
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
          labelColor: themeData.textTheme.caption!.color,
        ),
      ),
      body: BlocConsumer<RecentsBloc, RecentsState>(
        listener: (context, state) {
          if (state is RecentsLoadFailure) {
            context.showErrorSnackBar('Ups error happened ☹️');
          }
        },
        buildWhen: (previous, current) {
          return current is! RecentsRefreshFailure;
        },
        builder: (context, state) {
          if (state is RecentsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RecentsLoadSuccess) {
            RecentsVisibilityFilter filter = RecentsVisibilityFilter.values[_tabController.index];
            final recentsFiltered = state.recents.where((recent) {
              if (filter == RecentsVisibilityFilter.missed) {
                return !recent.isComplete && recent.direction == Direction.incoming;
              } else if (filter == RecentsVisibilityFilter.incoming) {
                return recent.direction == Direction.incoming;
              } else if (filter == RecentsVisibilityFilter.outgoing) {
                return recent.direction == Direction.outgoing;
              } else {
                return true;
              }
            }).toList();

            return RefreshIndicator(
              onRefresh: () {
                context.hideCurrentSnackBar();
                return (context.read<RecentsBloc>()..add(const RecentsRefreshed()))
                    .stream
                    .firstWhere((state) => state is RecentsLoadSuccess || state is RecentsRefreshFailure);
              },
              child: ListView.separated(
                itemCount: recentsFiltered.length,
                itemBuilder: (context, index) {
                  final recent = recentsFiltered[index];
                  return RecentTile(
                    recent: recent,
                    onInfoTap: () {
                      context.showSnackBar('Tap info on "${recent.number}"');
                    },
                    onTap: () {
                      context.read<CallBloc>().add(CallOutgoingStarted(number: recent.number, video: true));
                    },
                    onLongPress: () {
                      context.showSnackBar('LongPress on "${recent.number}"');
                    },
                    onDeleted: (recent) {
                      context.showSnackBar('"${recent.number}" deleted');

                      context.read<RecentsBloc>().add(RecentsDelete(recent: recent));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
              ),
            );
          }
          if (state is RecentsInitialLoadFailure) {
            return Center(
              child: OutlinedButton(
                onPressed: () => context.read<RecentsBloc>().add(const RecentsInitialLoaded()),
                child: const Text('Refresh'),
              ),
            );
          }
          throw StateError(''); // TODO fix if logic
        },
      ),
    );
  }
}

class RecentTile extends StatelessWidget {
  final Recent recent;
  final GestureTapCallback? onInfoTap;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final void Function(Recent)? onDeleted;

  const RecentTile({
    Key? key,
    required this.recent,
    this.onInfoTap,
    this.onTap,
    this.onLongPress,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onDeleted = this.onDeleted;
    return Dismissible(
      key: ObjectKey(recent),
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
      confirmDismiss: (direction) => _confirmDelete(context, recent),
      onDismissed: onDeleted == null ? null : (direction) => onDeleted(recent),
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: LeadingAvatar(
          username: recent.number,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.call),
              onPressed: () {
                // TODO
              },
            ),
            IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.videocam),
              onPressed: () {
                // TODO
              },
            ),
          ],
        ),
        title: Text(
          recent.number,
        ),
        subtitle: Row(
          children: [
            Icon(
              recent.direction.icon(recent.isComplete),
              size: 16,
              color: recent.isComplete
                  ? (recent.direction == Direction.incoming ? Colors.blue : Colors.green)
                  : Colors.red,
            ),
            const Text(' · '),
            Text(
              recent.isComplete ? _formatDuration(recent.duration!) : 'Missed',
            ),
            const Text(' · '),
            Text(
              recent.time.format(context),
            ),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return [duration.inHours, duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  Future<bool?> _confirmDelete(BuildContext context, Recent recent) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm delete"),
          content: Text("Are you sure you want to delete \"${recent.number}\"?"),
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

extension _DirectionConverting on Direction {
  IconData icon(bool isComplete) {
    switch (this) {
      case Direction.incoming:
        return isComplete ? Icons.call_received : Icons.call_missed;
      case Direction.outgoing:
        return isComplete ? Icons.call_made : Icons.call_missed_outgoing;
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
      return AppLocalizations.of(context)!.recentTimeBeforeMidnight(this);
    } else {
      return AppLocalizations.of(context)!.recentTimeAfterMidnight(this);
    }
  }
}
