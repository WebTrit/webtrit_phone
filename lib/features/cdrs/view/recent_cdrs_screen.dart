import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/recents/view/recents_screen_styles.dart';
import 'package:webtrit_phone/models/models.dart';
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
  /// Filters this screen offers, in the order their tabs and their lists are
  /// built - one source for both, so a tab cannot end up naming a list it
  /// does not open. The same filters the local-recents screen offers, hence
  /// the same tab ids.
  static const _filters = [RecentsVisibilityFilter.all, RecentsVisibilityFilter.missed];

  late final TabController _tabController = TabController(length: _filters.length, vsync: this);

  bool scrolledAway = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final themeData = Theme.of(context);
    final effectiveStyle = themeData.extension<RecentsScreenStyles>()?.primary;

    // The bar states its own height; deriving the inset from anything else is
    // how the body ends up sitting eight points below where the bar ends.
    final appBar = MainAppBar(
      title: widget.title,
      context: context,
      flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
          child: ExtTabBar(
            width: mediaQueryData.size.width * 0.75,
            height: kMainAppBarBottomControlHeight,
            tabs: [
              for (final filter in _filters)
                ExtTab(key: filter.tabKey, identifier: filter.tabId, text: filter.l10n(context)),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );

    return ThemedScaffold(
      background: effectiveStyle?.background,
      contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
      applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
      appBarTheme: effectiveStyle?.appBarTheme,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // No inset of its own: the body runs behind the bar, and Scaffold
      // already hands it a MediaQuery whose top padding is the bar plus the
      // status bar. A list with no padding of its own takes that figure, and
      // so does the refresh indicator. Computing it here a second time is
      // what let the two disagree - it read kToolbarHeight where MainAppBar
      // is built from kMinInteractiveDimension, eight points apart.
      body: TabBarView(controller: _tabController, children: [for (final filter in _filters) _listOf(filter)]),
    );
  }

  /// The list a filter's tab opens. Built from the same [_filters] the tabs
  /// are, so the pairing is by value rather than by position.
  Widget _listOf(RecentsVisibilityFilter filter) {
    return switch (filter) {
      RecentsVisibilityFilter.missed => MissedRecentCdrsList(
        transferEnabled: widget.transferEnabled,
        videoEnabled: widget.videoEnabled,
        chatsEnabled: widget.chatsEnabled,
        smssEnabled: widget.smssEnabled,
      ),
      // The server answers one list of call records; only the missed filter
      // has a narrowed variant, the rest show them all.
      _ => FullRecentCdrsList(
        transferEnabled: widget.transferEnabled,
        videoEnabled: widget.videoEnabled,
        chatsEnabled: widget.chatsEnabled,
        smssEnabled: widget.smssEnabled,
      ),
    };
  }
}
