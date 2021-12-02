import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/widgets.dart';

class RecentsScaffold extends StatefulWidget {
  const RecentsScaffold({Key? key}) : super(key: key);

  @override
  RecentsScaffoldState createState() => RecentsScaffoldState();
}

class RecentsScaffoldState extends State<RecentsScaffold> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      appBar: MainAppBar(
        bottom: TabBar(
          tabs: RecentsVisibilityFilter.values
              .map((value) => Tab(child: Text(value.l10n(context), softWrap: false)))
              .toList(),
          controller: _tabController,
        ),
      ),
      body: BlocConsumer<RecentsBloc, RecentsState>(
        listener: (context, state) {
          if (state is RecentsLoadFailure) {
            context.showErrorSnackBar('Ups error happened ☹️');
          }
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

            return ListView.separated(
              itemCount: recentsFiltered.length,
              itemBuilder: (context, index) {
                final recent = recentsFiltered[index];
                return RecentTile(
                  recent: recent,
                  onInfoTap: () {
                    context.showSnackBar('Tap info on "${recent.number}"');
                  },
                  onTap: () {
                    context.read<CallBloc>().add(CallOutgoingStarted(number: recent.number, video: recent.video));
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
            );
          }
          throw StateError(''); // TODO fix if logic
        },
      ),
    );
  }
}
