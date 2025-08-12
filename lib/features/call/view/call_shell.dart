import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/orientations/orientations.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../call.dart';
import 'call_active_thumbnail.dart';

final _logger = Logger('CallShell');

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
    return signalingListener(displayListener(widget.child));
  }

  Widget signalingListener(Widget child) {
    return BlocListener<CallBloc, CallState>(
      listenWhen: (previous, current) =>
          previous.callServiceState.signalingClientStatus != current.callServiceState.signalingClientStatus ||
          previous.callServiceState.lastSignalingDisconnectCode != current.callServiceState.lastSignalingDisconnectCode,
      listener: (context, state) {
        final signalingClientStatus = state.callServiceState.signalingClientStatus;
        final signalingDisconnectCode = state.callServiceState.lastSignalingDisconnectCode;

        // Listen to signaling session expired error
        if (signalingClientStatus == SignalingClientStatus.disconnect && signalingDisconnectCode is int) {
          final code = SignalingDisconnectCode.values.byCode(signalingDisconnectCode);
          if (code == SignalingDisconnectCode.sessionMissedError) {
            _logger.info('Signaling session listener: session is missing $signalingDisconnectCode');
            context.read<AppBloc>().add(const AppLogouted(checkTokenForError: true));
          }
        }
      },
      child: child,
    );
  }

  Widget displayListener(Widget child) {
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

        if (state.display == CallDisplay.overlay) {
          final avatar = _avatar;
          if (avatar != null) {
            if (!avatar.inserted) {
              avatar.insert(context, state);
            }
          } else {
            final avatar = ThumbnailAvatar(
              stickyPadding: widget.stickyPadding,
              onTap: () => _openCallScreen(router, state.activeCalls.isNotEmpty),
            );
            _avatar = avatar;
            avatar.insert(context, state);
          }
        } else {
          _removeThumbnailAvatar();
        }

        if (state.display == CallDisplay.none) {
          _avatar = null;
        }
      },
      child: child,
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
        SnackBar(
          content: Text(context.l10n.call_ThumbnailAvatar_currentlyNoActiveCall),
          backgroundColor: Colors.grey,
        ),
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
  /// On iOS, using popUntil doesn't work when the app is collapsed because pushing routes isn’t allowed until the app resumes.
  /// As a result, popUntil is called too early, leaving the route not yet present in the stack once the app reopens.
  /// Using navigate with a path-based approach fixes this issue by properly restoring state and avoiding the redirect bug.
  ///
  /// MainShellRoute uses MainShellRoute.name as its path.
  void _backToMainScreen(StackRouter router) {
    router.navigatePath(MainShellRoute.name);
  }
}

class ThumbnailAvatar {
  ThumbnailAvatar({
    required this.stickyPadding,
    this.onTap,
  });

  final EdgeInsets stickyPadding;
  final GestureTapCallback? onTap;
  Offset? _offset;
  OverlayEntry? _entry;

  bool get inserted => _entry != null;

  void insert(BuildContext context, CallState state) {
    assert(_entry == null);

    final activeCall = state.activeCalls.current;

    final entry = OverlayEntry(
      builder: (context) {
        return DraggableThumbnail(
          stickyPadding: stickyPadding,
          initialOffset: _offset,
          onOffsetUpdate: (offset) {
            _offset = offset;
          },
          onTap: onTap,
          child: CallActiveThumbnail(
            activeCall: activeCall,
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

enum StickySide { left, right }

class DraggableThumbnail extends StatefulWidget {
  const DraggableThumbnail({
    super.key,
    required this.child,
    required this.stickyPadding,
    this.initialStickySide = StickySide.right,
    this.initialOffset,
    this.onOffsetUpdate,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets stickyPadding;
  final StickySide initialStickySide;
  final Offset? initialOffset;
  final void Function(Offset details)? onOffsetUpdate;
  final GestureTapCallback? onTap;

  @override
  State<DraggableThumbnail> createState() => _DraggableThumbnailState();
}

class _DraggableThumbnailState extends State<DraggableThumbnail> {
  final _callCardKey = GlobalKey();
  bool _callCardPanning = false;

  late EdgeInsets _mediaQueryPadding;
  late Size _mediaQuerySize;
  late Rect _activeRect;
  late Rect _stickyRect;
  StickySide? _lastStickySide;
  Offset? _offset;

  @override
  void initState() {
    super.initState();

    _offset = widget.initialOffset;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mediaQueryPadding = MediaQuery.paddingOf(context);
    _mediaQuerySize = MediaQuery.sizeOf(context);
    _activeRect = _mediaQueryPadding.deflateRect(Offset.zero & _mediaQuerySize);
    _stickyRect = widget.stickyPadding.deflateRect(_activeRect);

    if (_offset != null && !_callCardPanning) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final callCardRect = _findCallCardRect();
        final translateX = _lastStickTranslateX(_stickyRect, callCardRect);
        final translateY = _boundTranslateY(_stickyRect, callCardRect);
        final offset = callCardRect.translate(translateX, translateY).topLeft;

        if (_offset != offset) {
          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double? left, top, right;
    {
      final offset = _offset;
      if (offset == null) {
        final initialPadding = widget.stickyPadding + _mediaQueryPadding;
        switch (widget.initialStickySide) {
          case StickySide.left:
            left = initialPadding.left;
            top = initialPadding.top;
            right = null;

          case StickySide.right:
            left = null;
            top = initialPadding.top;
            right = initialPadding.right;
        }
      } else {
        left = offset.dx;
        top = offset.dy;
        right = null;
      }
    }

    return AnimatedPositioned(
      key: _callCardKey,
      left: left,
      top: top,
      right: right,
      curve: Curves.ease,
      duration: _callCardPanning ? Duration.zero : kRadialReactionDuration,
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: (details) {
          setState(() {
            _callCardPanning = true;
          });
        },
        onPanUpdate: (details) {
          final callCardRect = _findCallCardRect(details.delta);
          final translateX = _boundTranslateX(_activeRect, callCardRect);
          final translateY = _boundTranslateY(_activeRect, callCardRect);
          final offset = callCardRect.translate(translateX, translateY).topLeft;

          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
          });
        },
        onPanEnd: (details) {
          final callCardRect = _findCallCardRect();
          final translateX = _stickTranslateX(_stickyRect, callCardRect);
          final translateY = _boundTranslateY(_stickyRect, callCardRect);
          final offset = callCardRect.translate(translateX, translateY).topLeft;

          widget.onOffsetUpdate?.call(offset);
          setState(() {
            _offset = offset;
            _callCardPanning = false;
          });
        },
        child: widget.child,
      ),
    );
  }

  Rect _findCallCardRect([Offset delta = Offset.zero]) {
    final callCardRenderBox = _callCardKey.currentContext?.findRenderObject()! as RenderBox;
    final offset = callCardRenderBox.localToGlobal(Offset.zero) + delta;
    final size = callCardRenderBox.size;
    if (!callCardRenderBox.hasSize) return Rect.zero;

    return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
  }

  double _stickTranslateX(Rect stickyRect, Rect translateRect) {
    if (translateRect.center.dx < stickyRect.center.dx) {
      _lastStickySide = StickySide.left;
      return stickyRect.left - translateRect.left;
    } else {
      _lastStickySide = StickySide.right;
      return stickyRect.right - translateRect.right;
    }
  }

  double _lastStickTranslateX(Rect stickyRect, Rect translateRect) {
    switch (_lastStickySide) {
      case StickySide.left:
        return stickyRect.left - translateRect.left;
      case StickySide.right:
        return stickyRect.right - translateRect.right;
      default:
        return 0;
    }
  }

  double _boundTranslateX(Rect boundRect, Rect translateRect) {
    if (boundRect.left > translateRect.left) {
      return boundRect.left - translateRect.left;
    } else if (boundRect.right < translateRect.right) {
      return boundRect.right - translateRect.right;
    } else {
      return 0;
    }
  }

  double _boundTranslateY(Rect boundRect, Rect translateRect) {
    if (boundRect.top > translateRect.top) {
      return boundRect.top - translateRect.top;
    } else if (boundRect.bottom < translateRect.bottom) {
      return boundRect.bottom - translateRect.bottom;
    } else {
      return 0;
    }
  }
}
