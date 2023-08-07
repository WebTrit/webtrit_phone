import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../recents.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({
    super.key,
    this.recentsFilters = const [RecentsVisibilityFilter.all, RecentsVisibilityFilter.missed],
  });

  final List<RecentsVisibilityFilter> recentsFilters;

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final activeFilter = context.read<RecentsBloc>().state.filter;
    final initialRecentsFiltersIndex = widget.recentsFilters.indexOf(activeFilter);

    _tabController = TabController(
      initialIndex: initialRecentsFiltersIndex == -1 ? 0 : initialRecentsFiltersIndex,
      length: widget.recentsFilters.length,
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
      final filter = widget.recentsFilters[_tabController.index];
      context.read<RecentsBloc>().add(RecentsFiltered(filter));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final appName = themeData.extension<ConstTexts>()?.appName;

    return Scaffold(
      appBar: MainAppBar(
        name: appName,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kMainAppBarBottomPaddingGap,
            ),
            child: ExtTabBar(
              width: mediaQueryData.size.width * 0.75,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: [
                for (final recentsFilter in widget.recentsFilters) Tab(text: recentsFilter.l10n(context)),
              ],
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
            final recentsFiltered = state.recentsFiltered!; // can not be null if state.recents is not null
            return ListView.builder(
              itemCount: recentsFiltered.length,
              itemBuilder: (context, index) {
                final recent = recentsFiltered[index];
                return RecentTile(
                  recent: recent,
                  onInfoPressed: () {
                    context.goNamed(MainRoute.recentsDetails, pathParameters: {
                      recentIdPathParameterName: recent.id.toString(),
                    });
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
