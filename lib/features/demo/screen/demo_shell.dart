import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/main/models/models.dart';

import '../bloc/demo_cubit.dart';
import '../widgets/widgets.dart';

class DemoShell extends StatefulWidget {
  const DemoShell({
    super.key,
    required this.child,
    required this.isConnectVoIPFlow,
    required this.isInviteFriends,
    required this.mainFlavor,
  });

  final Widget child;
  final bool isConnectVoIPFlow;
  final bool isInviteFriends;
  final MainFlavor mainFlavor;

  @override
  State<DemoShell> createState() => _DemoShellState();
}

class _DemoShellState extends State<DemoShell> with RouteAware {
  static const _converterCardSize = Size(120, 120);
  static const _stickyPadding = EdgeInsets.all(8);

  Size get _screenSize => MediaQuery.of(context).size;

  Offset get _defaultButtonOffset => _screenSize.bottomRight(Offset(
        -_converterCardSize.width - _stickyPadding.right,
        -_converterCardSize.width - kToolbarHeight - _stickyPadding.bottom,
      ));

  late final DemoConvertButton _convertButton;

  @override
  void initState() {
    super.initState();
    final userActionBloc = context.read<DemoCubit>();
    if (widget.isConnectVoIPFlow) userActionBloc.enableConnectVoIP();
    if (widget.isInviteFriends) userActionBloc.enableInviteFriendFlow();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _convertButton = DemoConvertButton(
      stickyPadding: _stickyPadding,
      offset: _defaultButtonOffset,
      size: _converterCardSize,
      onTap: () => context.read<DemoCubit>().openConvertBbxUrl(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DemoCubit>();

    if (_isAvailableToShow(context)) {
      if (!_convertButton.inserted && bloc.state.convertPbxUrl != null) {
        _showConverterButton(context);
      }
    } else if (_convertButton.inserted) {
      _convertButton.remove();
    }

    return BlocListener<DemoCubit, DemoCubitState>(
      listener: (context, state) {
        if (state.uiAction == null) return;
        switch (state.uiAction!) {
          case DemoAction.showConvertedButton:
            if (_isAvailableToShow(context)) {
              _showConverterButton(context);
            }
            break;
          case DemoAction.showInviteDialog:
            if (_isAvailableToShow(context)) {
              if (state.inviteUrl != null) _showInviteDialog(context, state.inviteUrl!);
            } else {
              bloc.postponeDialogCountdown();
            }
            break;
          case DemoAction.showConvertWeb:
            _navigateToWeb(state.convertPbxUrl!);
            break;
        }
      },
      child: widget.child,
    );
  }

  bool _isAvailableToShow(BuildContext context) {
    return widget.mainFlavor != MainFlavor.keypad && context.router.isRouteActive(MainScreenPageRoute.name);
  }

  void _showConverterButton(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _convertButton.insert(context);
    });
  }

  void _showInviteDialog(BuildContext context, String url) {
    final bloc = context.read<DemoCubit>();

    showDialog(
      context: context,
      builder: (context) => DemoInviteDialog(
        onInvite: () {
          Navigator.pop(context);
          _navigateToWeb(url);
          bloc.postponeDialogCountdown();
        },
        onHide: () {
          Navigator.pop(context);
          bloc.postponeDialogCountdown();
        },
      ),
    );
  }

  void _navigateToWeb(String url) {
    context.router.push(DemoWebPageRoute(initialUri: Uri.parse(url)));
  }
}
