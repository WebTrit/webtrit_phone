import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/outlined_button_styles.dart';
import 'package:webtrit_phone/utils/gravatar.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/number_cdr_tile.dart';

class NumberCdrsScreen extends StatefulWidget {
  const NumberCdrsScreen({
    required this.title,
    required this.videoVisible,
    super.key,
  });

  final Widget title;
  final bool videoVisible;

  @override
  State<NumberCdrsScreen> createState() => _NumberCdrsScreenState();
}

class _NumberCdrsScreenState extends State<NumberCdrsScreen> {
  late final cubit = context.read<NumberCdrsLogCubit>();
  late final scrollController = ScrollController();

  bool scrolledAway = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final position = scrollController.position.pixels;
      final scrollRemaining = maxScroll - position;

      const hystoryFetchScrollThreshold = 500.0;
      final shouldFetch = scrollRemaining < hystoryFetchScrollThreshold;
      final canFetch = !cubit.state.historyEndReached && !cubit.state.fetchingHistory;
      if (shouldFetch && canFetch) cubit.fetchHistory();

      const scrolledThreshold = 1000;
      final scrolledAway = position > scrolledThreshold;
      if (this.scrolledAway != scrolledAway) setState(() => this.scrolledAway = scrolledAway);
    });
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
  }

  void _initiateCall(BuildContext context, String number, String? name, bool video) {
    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(number: number, displayName: name, video: video));
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outlinedButtonStyles = theme.extension<OutlinedButtonStyles>();
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: theme.canvasColor.withAlpha(0)),
      body: Stack(
        children: [
          BlocBuilder<NumberCdrsLogCubit, NumberCdrsLogState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.records.isEmpty) {
                return const Center(child: Text('No CDRs available'));
              }

              return ScrollToTopOverlay(
                scrolledAway: scrolledAway,
                onScrollToTop: scrollToTop,
                child: ListView.builder(
                  controller: scrollController,
                  cacheExtent: 500,
                  shrinkWrap: true,
                  itemCount: state.records.length + 1,
                  padding: EdgeInsets.only(top: 200 + topPadding),
                  itemBuilder: (context, index) {
                    final historyIndicatorPosition = state.records.length;
                    if (index == historyIndicatorPosition) return HistoryFetchIndicator(state.fetchingHistory);
                    final cdr = state.records[index];

                    return FadeIn(
                      child: SizedBox(
                        key: Key(cdr.callId.toString()),
                        child: NumberCdrTile(cdr: cdr),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: EdgeInsets.only(top: topPadding),
                child: ContactInfoBuilder(
                    source: ContactSourcePhone(cubit.number),
                    builder: (context, contact) {
                      final number = cubit.number;
                      final title = contact?.displayTitle ?? number;
                      final email = contact?.emails.firstOrNull?.address;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: kAllPadding16,
                            alignment: Alignment.center,
                            child: LeadingAvatar(
                              username: title,
                              thumbnail: contact?.thumbnail,
                              thumbnailUrl: gravatarThumbnailUrl(email),
                              registered: contact?.registered,
                              radius: 50,
                            ),
                          ),
                          CopyToClipboard(
                            data: number,
                            child: Text(
                              number,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.outlineVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            title,
                            style: theme.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: outlinedButtonStyles?.neutral,
                                child: const AppIcon(Icons.call),
                                onPressed: () => _initiateCall(context, number, contact?.maybeName, false),
                              ),
                              if (widget.videoVisible) ...[
                                const SizedBox(
                                  width: 16,
                                ),
                                OutlinedButton(
                                  style: outlinedButtonStyles?.neutral,
                                  child: const AppIcon(Icons.videocam),
                                  onPressed: () => _initiateCall(context, number, contact?.maybeName, true),
                                ),
                              ]
                            ],
                          ),
                          const Divider(
                            height: 16,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
