// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.bottom,
    required this.context,
    this.backgroundColor,
    this.flexibleSpace,
    this.elevation,
  });

  final BuildContext context;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final double? elevation;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kMinInteractiveDimension + bottomHeight);
  }

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  late final TransientDebouncer<SessionStatus> _debouncer;

  @override
  void initState() {
    super.initState();
    final initial = context.read<SessionStatusCubit>().state.status;
    _debouncer = TransientDebouncer<SessionStatus>(
      initial: initial,
      duration: kSignalingStatusDebounce,
      isTransient: (s) => s.signalingStatus.isTransientReconnecting && !s.hasPushTokenError,
      getLatest: () => context.read<SessionStatusCubit>().state.status,
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _updateDisplayedStatus(SessionStatus newStatus) {
    if (!mounted) return;
    _debouncer.update(newStatus, () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<SessionStatusCubit, SessionStatusState>(
      listener: (context, state) => _updateDisplayedStatus(state.status),
      child: AppBar(
        title: Builder(
          builder: (context) {
            Widget? widgetToShow;
            if (_debouncer.displayed.isEstablishing) {
              widgetToShow = Row(
                key: _debouncer.displayed.key,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      _debouncer.displayed.appBarl10n(context),
                      style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              );
            }
            widgetToShow ??= Row(mainAxisSize: MainAxisSize.max, children: [widget.title ?? SizedBox.shrink()]);

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                final r = animation.status == AnimationStatus.reverse;
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0, r ? -1 : 1),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeOut)),
                    ),
                    child: child,
                  ),
                );
              },
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              child: widgetToShow,
            );
          },
        ),
        bottom: widget.bottom,
        backgroundColor: widget.backgroundColor,
        flexibleSpace: widget.flexibleSpace,
        elevation: widget.elevation,
        centerTitle: false,
        actions: [
          if (_debouncer.displayed.isReady) ...[
            if (AppBarParams.of(context).pullableCallDialogs.isNotEmpty)
              CallPullBadge(pullableCallDialogs: AppBarParams.of(context).pullableCallDialogs),
            if (AppBarParams.of(context).systemNotificationsEnabled) SystemNotificationsBadge(),
          ],
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: _debouncer.displayed.color(context))),
            ),
            child: BlocBuilder<UserInfoCubit, UserInfoState>(
              builder: (context, userinfoState) {
                final info = userinfoState.userInfo;
                return IconButton(
                  key: mainAppBarKey,
                  constraints: const BoxConstraints.tightFor(
                    width: kMinInteractiveDimension,
                    height: kMinInteractiveDimension,
                  ),
                  padding: const EdgeInsets.all(2),
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      LeadingAvatar(
                        username: info?.name ?? info?.numbers.main,
                        thumbnailUrl: gravatarThumbnailUrl(info?.email),
                        radius: kMinInteractiveDimension / 2,
                        showLoading: true,
                      ),
                      BlocBuilder<MicrophoneStatusBloc, MicrophoneStatusState>(
                        builder: (context, microphoneStatusState) {
                          return Visibility(
                            visible:
                                microphoneStatusState.microphonePermissionGranted != null &&
                                !microphoneStatusState.microphonePermissionGranted!,
                            child: Positioned(
                              right: -8,
                              top: -2,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.mic_off, color: Colors.white, size: 14),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.router.navigate(const SettingsRouterPageRoute());
                  },
                );
              },
            ),
          ),
          const SizedBox(width: NavigationToolbar.kMiddleSpacing),
        ],
      ),
    );
  }
}
