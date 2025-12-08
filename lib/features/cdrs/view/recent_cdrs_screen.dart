import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/app/constants.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/missed_recent_cdrs_list.dart';
import '../widgets/full_recent_cdrs_list.dart';

class RecentCdrsScreen extends StatefulWidget {
  const RecentCdrsScreen({
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
    super.key,
  });

  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;

  final Widget? title;

  @override
  State<RecentCdrsScreen> createState() => _RecentCdrsScreenState();
}

class _RecentCdrsScreenState extends State<RecentCdrsScreen> with TickerProviderStateMixin {
  late final cubit = context.read<FullRecentCdrsCubit>();
  late final TabController _tabController = TabController(length: 2, vsync: this);

  bool scrolledAway = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
          child: Padding(
            padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
            child: ExtTabBar(
              width: mediaQueryData.size.width * 0.75,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: [
                Tab(text: l10n.recentsVisibilityFilter_all),
                Tab(text: l10n.recentsVisibilityFilter_missed),
              ],
              controller: _tabController,
            ),
          ),
        ),
        context: context,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FullRecentCdrsList(
            transferEnabled: widget.transferEnabled,
            videoEnabled: widget.videoEnabled,
            chatsEnabled: widget.chatsEnabled,
            smssEnabled: widget.smssEnabled,
          ),
          MissedRecentCdrsList(
            transferEnabled: widget.transferEnabled,
            videoEnabled: widget.videoEnabled,
            chatsEnabled: widget.chatsEnabled,
            smssEnabled: widget.smssEnabled,
          ),
        ],
      ),
    );
  }
}
