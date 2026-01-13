import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/orientations/orientations.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/repositories/contacts/contacts_repository.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/app/constants.dart';

import '../call.dart';

class CallShell extends StatefulWidget {
  const CallShell({required this.child, this.stickyPadding = kStickyOverlayPadding, super.key});

  final Widget child;
  final EdgeInsets stickyPadding;

  @override
  State<CallShell> createState() => _CallShellState();
}

class _CallShellState extends State<CallShell> {
  late final ThumbnailOverlayManager _thumbnailManager = ThumbnailOverlayManager(stickyPadding: widget.stickyPadding);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [_callDisplayListener(), _callScreenDisplayListener(), _callVideoListener()],
      child: widget.child,
    );
  }

  /// Listens to [CallState.display] changes and manages related UI transitions.
  ///
  /// Handles:
  /// - Orientation updates via [OrientationsBloc].
  /// - Navigation between main and call screens.
  /// - Showing or removing the floating thumbnail overlay via [_updateOverlayContent].
  BlocListener<CallBloc, CallState> _callDisplayListener() {
    return BlocListener<CallBloc, CallState>(
      listenWhen: (previous, current) => previous.display != current.display,
      listener: (context, state) => _onCallDisplayChanged(context, state),
    );
  }

  /// Listens for transitions to and from [CallDisplay.screen] to manage
  /// activity visibility and lockscreen behavior dynamically.
  ///
  /// - When entering the call screen (`CallDisplay.screen`), it restores
  ///   normal screen and lockscreen settings.
  /// - When leaving the call screen, it enables showing the activity
  ///   over the lock screen if needed.
  BlocListener<CallBloc, CallState> _callScreenDisplayListener() {
    return BlocListener<CallBloc, CallState>(
      listenWhen: (previous, current) =>
          previous.display != current.display &&
          (previous.display == CallDisplay.screen || current.display == CallDisplay.screen),
      listener: (context, state) => _onCallScreenDisplayChanged(state),
    );
  }

  BlocListener<CallBloc, CallState> _callVideoListener() {
    return BlocListener<CallBloc, CallState>(
      listenWhen: _shouldListenToVideoChanges,
      listener: (context, state) => _updateOverlayContent(context, state, context.router),
    );
  }

  void _onCallDisplayChanged(BuildContext context, CallState state) {
    final router = context.router;
    _updateOrientations(context, state.display);
    _handleNavigation(router, state);
    _updateOverlayContent(context, state, router);
  }

  void _onCallScreenDisplayChanged(CallState state) {
    final isCallScreen = state.display == CallDisplay.screen;
    _updateLockscreenBehavior(isCallScreen);
  }

  bool _shouldListenToVideoChanges(CallState previous, CallState current) {
    if (current.display != CallDisplay.screen) return false;

    final prevCall = previous.activeCalls.isEmpty ? null : previous.activeCalls.current;
    final currCall = current.activeCalls.isEmpty ? null : current.activeCalls.current;

    return (prevCall?.isCameraActive ?? false) != (currCall?.isCameraActive ?? false);
  }

  void _updateOrientations(BuildContext context, CallDisplay display) {
    final orientationsBloc = context.read<OrientationsBloc>();
    if (display == CallDisplay.screen) {
      orientationsBloc.add(const OrientationsChanged(PreferredOrientation.auto));
    } else {
      orientationsBloc.add(const OrientationsChanged(PreferredOrientation.portrait));
    }
  }

  void _handleNavigation(StackRouter router, CallState state) {
    final callScreenActive = router.isRouteActive(CallScreenPageRoute.name);
    final callScreenShouldDisplay = state.display == CallDisplay.screen;

    if (callScreenShouldDisplay && !callScreenActive) {
      _openCallScreen(router, state.activeCalls.isNotEmpty);
    }
    if (!callScreenShouldDisplay && callScreenActive) {
      _backToMainScreen(router);
    }
  }

  void _updateOverlayContent(BuildContext context, CallState state, StackRouter router) {
    final hasActiveCalls = state.activeCalls.isNotEmpty;

    if (!hasActiveCalls || state.display == CallDisplay.none || state.display == CallDisplay.noneScreen) {
      _hideOverlay();
      return;
    }

    switch (state.display) {
      case CallDisplay.overlay:
        _showActiveCallThumbnail(context, state, router);
        break;

      case CallDisplay.screen:
        final activeCall = state.activeCalls.current;
        if (activeCall.isCameraActive) {
          _showLocalCameraPreview(context, state);
        } else {
          _hideOverlay();
        }
        break;

      case CallDisplay.none:
      case CallDisplay.noneScreen:
        // Handled by the initial guard clause.
        break;
    }
  }

  void _showActiveCallThumbnail(BuildContext context, CallState state, StackRouter router) {
    if (state.activeCalls.isEmpty) {
      _hideOverlay();
      return;
    }

    final viewSource = PresenceViewParams.of(context).viewSource;
    final callBloc = context.read<CallBloc>();
    final contactResolver = DefaultContactResolver(contactsRepository: context.read<ContactsRepository>());

    _thumbnailManager.show(
      context,
      child: BlocBuilder<CallBloc, CallState>(
        bloc: callBloc,
        buildWhen: (previous, current) =>
            previous.activeCalls.isEmpty ||
            current.activeCalls.isEmpty ||
            previous.activeCalls.current != current.activeCalls.current,
        builder: (context, state) {
          if (state.activeCalls.isEmpty) {
            return const SizedBox.shrink();
          }

          final activeCall = state.activeCalls.current;
          final orientation = MediaQuery.of(context).orientation;

          return PresenceViewParams(
            viewSource: viewSource,
            child: CallActiveThumbnail(
              activeCall: activeCall,
              orientation: orientation,
              onTap: () => _openCallScreen(router, state.activeCalls.isNotEmpty),
              contactResolver: contactResolver,
            ),
          );
        },
      ),
    );
  }

  void _showLocalCameraPreview(BuildContext context, CallState state) {
    final callBloc = context.read<CallBloc>();

    _thumbnailManager.show(
      context,
      child: BlocBuilder<CallBloc, CallState>(
        bloc: callBloc,
        // Safety check: ensure lists are not empty before accessing .current using short-circuit evaluation
        buildWhen: (previous, current) =>
            previous.activeCalls.isEmpty ||
            current.activeCalls.isEmpty ||
            previous.activeCalls.current != current.activeCalls.current,
        builder: (context, state) {
          if (state.activeCalls.isEmpty) {
            return const SizedBox.shrink();
          }

          final activeCall = state.activeCalls.current;
          final orientation = MediaQuery.of(context).orientation;

          return LocalCameraPreviewThumbnail(
            orientation: orientation,
            frontCamera: activeCall.frontCamera,
            localStream: activeCall.localStream,
            onSwitchCameraPressed: activeCall.frontCamera == null
                ? null
                : () => callBloc.add(CallControlEvent.cameraSwitched(activeCall.callId)),
          );
        },
      ),
    );
  }

  void _hideOverlay() {
    _thumbnailManager.hide();
  }

  void _updateLockscreenBehavior(bool isCallScreen) {
    if (isCallScreen) {
      AndroidCallkeepUtils.activityControl.showOverLockscreen();
      AndroidCallkeepUtils.activityControl.wakeScreenOnShow();
    } else {
      AndroidCallkeepUtils.activityControl.showOverLockscreen(false);
      AndroidCallkeepUtils.activityControl.wakeScreenOnShow(false);
    }
  }

  void _openCallScreen(StackRouter router, bool hasActiveCalls) {
    if (hasActiveCalls) {
      // Use navigate to prevent duplicating CallScreenPageRoute in the stack.
      // For example, if the user is on a different route branch like LogRecordsConsoleScreenPageRoute,
      // navigate ensures CallScreenPageRoute is not added again.
      router.navigate(const CallScreenPageRoute());
    } else {
      _hideOverlay();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.call_ThumbnailAvatar_currentlyNoActiveCall), backgroundColor: Colors.grey),
      );
    }
  }

  /// Programmatic back navigation to the main screen.
  ///
  /// Uses [StackRouter.navigatePath] to `MainShellRoute` instead of `popUntil`.
  /// This avoids issues on iOS where `popUntil` executes prematurely while the app
  /// is backgrounded, and prevents router redirects bug associated with empty sub-routes.
  ///
  /// Detailed Context:
  /// 1. `router.navigate(const MainScreenPageRoute())` wasn't used to avoid a bug that triggers
  ///    redirect('') from an empty MainScreenPageRoute subroute to the initial (last remembered) flavor.
  /// 2. On iOS, using `popUntil` doesn't work when the app is collapsed because pushing routes isn't
  ///    allowed until the app resumes. As a result, `popUntil` is called too early.
  /// 3. Using `navigatePath` with a path-based approach fixes this by properly restoring state.
  void _backToMainScreen(StackRouter router) {
    router.navigatePath(MainShellRoute.name);
  }

  @override
  void dispose() {
    _thumbnailManager.dispose();
    super.dispose();
  }
}
