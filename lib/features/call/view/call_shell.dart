import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/orientations/orientations.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/view_params/presence_view_params.dart';

import '../call.dart';
import 'call_active_thumbnail.dart';

class CallShell extends StatefulWidget {
  const CallShell({
    super.key,
    this.stickyPadding = const EdgeInsets.symmetric(horizontal: kMinInteractiveDimension / 4),
    required this.child,
  });

  final EdgeInsets stickyPadding;
  final Widget child;

  @override
  State<CallShell> createState() => _CallShellState();
}

class _CallShellState extends State<CallShell> {
  ThumbnailAvatar? _avatar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [callDisplayListener(), callScreenDisplayListener()], child: widget.child);
  }

  /// Listens to [CallState.display] changes and manages related UI transitions.
  ///
  /// Handles:
  /// - Orientation updates via [OrientationsBloc].
  /// - Navigation between main and call screens.
  /// - Showing or removing the floating [ThumbnailAvatar] overlay.
  BlocListener<CallBloc, CallState> callDisplayListener() {
    return BlocListener<CallBloc, CallState>(
      listenWhen: (previous, current) => previous.display != current.display,
      listener: (context, state) async {
        final router = context.router;

        final orientationsBloc = context.read<OrientationsBloc>();
        if (state.display == CallDisplay.screen) {
          orientationsBloc.add(const OrientationsChanged(PreferredOrientation.call));
        } else {
          orientationsBloc.add(const OrientationsChanged(PreferredOrientation.regular));
        }

        final callScreenActive = router.isRouteActive(CallScreenPageRoute.name);
        final callScreenShouldDisplay = state.display == CallDisplay.screen;

        if (callScreenShouldDisplay && !callScreenActive) _openCallScreen(router, state.activeCalls.isNotEmpty);
        if (!callScreenShouldDisplay && callScreenActive) _backToMainScreen(router);

        switch (state.display) {
          case CallDisplay.overlay:
            _showThumbnailAvatar(context, state, router);
          case CallDisplay.screen:
          case CallDisplay.noneScreen:
            _removeThumbnailAvatar();
          case CallDisplay.none:
            _resetThumbnailAvatar();
        }
      },
    );
  }

  /// Creates (if needed) and inserts the [ThumbnailAvatar] overlay.
  void _showThumbnailAvatar(BuildContext context, CallState state, StackRouter router) {
    final avatar =
        _avatar ??
        ThumbnailAvatar(
          stickyPadding: widget.stickyPadding,
          onTap: () => _openCallScreen(router, state.activeCalls.isNotEmpty),
        );

    _avatar = avatar;

    if (!avatar.inserted) {
      avatar.insert(context, state);
    }
  }

  /// Removes the avatar from the UI and clears the reference.
  void _resetThumbnailAvatar() {
    _removeThumbnailAvatar();
    _avatar = null;
  }

  /// Listens for transitions to and from [CallDisplay.screen] to manage
  /// activity visibility and lockscreen behavior dynamically.
  ///
  /// - When entering the call screen (`CallDisplay.screen`), it restores
  ///   normal screen and lockscreen settings.
  /// - When leaving the call screen, it enables showing the activity
  ///   over the lock screen if needed.
  BlocListener<CallBloc, CallState> callScreenDisplayListener() {
    return BlocListener<CallBloc, CallState>(
      listenWhen: (previous, current) =>
          previous.display != current.display &&
          (previous.display == CallDisplay.screen || current.display == CallDisplay.screen),
      listener: (context, state) async {
        final isCallScreen = state.display == CallDisplay.screen;

        if (isCallScreen) {
          // Entering call screen - restore normal flags
          AndroidCallkeepUtils.activityControl.showOverLockscreen();
          AndroidCallkeepUtils.activityControl.wakeScreenOnShow();
        } else {
          // Leaving call screen - keep visible over lock screen
          AndroidCallkeepUtils.activityControl.showOverLockscreen(false);
          AndroidCallkeepUtils.activityControl.wakeScreenOnShow(false);
        }
      },
    );
  }

  void _removeThumbnailAvatar() {
    final avatar = _avatar;
    if (avatar != null) {
      if (avatar.inserted) {
        avatar.remove();
      }
    }
  }

  @override
  void dispose() {
    _removeThumbnailAvatar();
    super.dispose();
  }

  void _openCallScreen(StackRouter router, bool hasActiveCalls) {
    if (hasActiveCalls) {
      // Use navigate to prevent duplicating CallScreenPageRoute in the stack.
      // For example, if the user is on a different route branch like LogRecordsConsoleScreenPageRoute, navigate ensures CallScreenPageRoute is not added again.
      router.navigate(const CallScreenPageRoute());
    } else {
      // Handle scenario where no active call exists, ensuring the listener is properly removed and the thumbnail is correctly managed.
      _removeThumbnailAvatar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.call_ThumbnailAvatar_currentlyNoActiveCall), backgroundColor: Colors.grey),
      );
    }
  }

  /// Pops the stack until the main screen is reached.
  /// This is useful when the user is on a different route branch like LogRecordsConsoleScreenPageRoute.
  /// Uses only on programmatic back navigation, for events like `transferring`.
  /// But if user back manually using the back button hi'll be just popped to the previous screen.
  ///
  /// router.navigate(const MainScreenPageRoute()) didnt used to avoid bug
  /// that triggers redirect('') from empty MainScreenPageRoute subroute to
  /// initial(last remembered since restart) flavor that final and not changed across the app router lifecycle.
  /// example redirect('') will always redirect to contacts page even if user was on the calls or chat page.
  ///
  /// On iOS, using popUntil doesn't work when the app is collapsed because pushing routes isn`t allowed until the app resumes.
  /// As a result, popUntil is called too early, leaving the route not yet present in the stack once the app reopens.
  /// Using navigate with a path-based approach fixes this issue by properly restoring state and avoiding the redirect bug.
  ///
  /// MainShellRoute uses MainShellRoute.name as its path.
  void _backToMainScreen(StackRouter router) {
    router.navigatePath(MainShellRoute.name);
  }
}

class ThumbnailAvatar {
  ThumbnailAvatar({required this.stickyPadding, this.onTap});

  final EdgeInsets stickyPadding;
  final GestureTapCallback? onTap;
  Offset? _offset;
  OverlayEntry? _entry;

  bool get inserted => _entry != null;

  void insert(BuildContext context, CallState state) {
    assert(_entry == null);

    final activeCall = state.activeCalls.current;

    final entry = OverlayEntry(
      builder: (_) {
        return PresenceViewParams(
          viewSource: PresenceViewParams.of(context).viewSource,
          child: DraggableThumbnail(
            stickyPadding: stickyPadding,
            initialOffset: _offset,
            onOffsetUpdate: (offset) {
              _offset = offset;
            },
            onTap: onTap,
            child: CallActiveThumbnail(activeCall: activeCall),
          ),
        );
      },
    );
    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  void remove() {
    assert(_entry != null);

    _entry!.remove();
    _entry = null;
  }
}
