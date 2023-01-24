import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../recents.dart';

class RecentsScaffold extends StatefulWidget {
  const RecentsScaffold({Key? key}) : super(key: key);

  @override
  RecentsScaffoldState createState() => RecentsScaffoldState();
}

class RecentsScaffoldState extends State<RecentsScaffold> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static final _recentsFilters = [RecentsVisibilityFilter.all, RecentsVisibilityFilter.missed];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _recentsFilters.length,
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
    final mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: MainAppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kMainAppBarBottomPaddingGap,
            ),
            child: ExtTabBar(
              width: mediaQueryData.size.width * 0.6,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: _recentsFilters.map((value) => Tab(child: Text(value.l10n(context), softWrap: false))).toList(),
              controller: _tabController,
            ),
          ),
        ),
      ),
      body: BlocBuilder<RecentsBloc, RecentsState>(
        builder: (context, state) {
          final recents = state.recents;
          if (recents == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            RecentsVisibilityFilter filter = RecentsVisibilityFilter.values[_tabController.index];
            final recentsFiltered = recents.where((recent) {
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

            return ListView.builder(
              itemCount: recentsFiltered.length,
              itemBuilder: (context, index) {
                final recent = recentsFiltered[index];
                return RecentTile(
                  recent: recent,
                  onInfoPressed: () {
                    context.goNamed(MainRoute.recent, params: {'$RecentId': recent.id.toString()});
                  },
                  onTap: () {
                    final callBloc = context.read<CallBloc>();
                    callBloc.add(CallControlEvent.started(
                      number: recent.number,
                      displayName: recent.name,
                      video: recent.video,
                    ));
                  },
                  onLongPress: () {
                    final callBloc = context.read<CallBloc>();
                    callBloc.add(CallControlEvent.started(
                      number: recent.number,
                      displayName: recent.name,
                      video: !recent.video,
                    ));
                  },
                  onDeleted: (recent) {
                    context.showSnackBar(context.l10n.recents_snackBar_deleted(recent.name));
                    context.read<RecentsBloc>().add(RecentsDeleted(recent));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
