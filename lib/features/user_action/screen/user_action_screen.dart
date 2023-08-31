import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';

import '../bloc/user_action_bloc_cubit.dart';
import '../widgets/widgets.dart';

class UserActionScreen extends StatefulWidget {
  final Widget child;

  const UserActionScreen({
    super.key,
    required this.child,
  });

  @override
  State<UserActionScreen> createState() => _UserActionScreenState();
}

class _UserActionScreenState extends State<UserActionScreen> {
  final _converterCardSize = const Size(120, 120);
  final _stickyPadding = const EdgeInsets.all(8);

  get _screenSize => MediaQuery.of(context).size;

  get _defaultButtonOffset => _screenSize.bottomRight(Offset(
        -_converterCardSize.width - _stickyPadding.right,
        -_converterCardSize.width - kToolbarHeight - _stickyPadding.bottom,
      ));

  late final _convertButton = ActionConvertButton(
    stickyPadding: _stickyPadding,
    offset: _defaultButtonOffset,
    size: _converterCardSize,
    onTap: () => context.read<UserActionBlocCubit>().openConvertBbxUrl(),
  );

  final _availability = const [
    MainRoute.favorites,
    MainRoute.recents,
    MainRoute.contacts,
    MainRoute.keypad,
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserActionBlocCubit>();

    if (_isAvailableToShowing()) {
      if (!_convertButton.inserted && bloc.state.convertPbxUrl != null) {
        _showConverterButton(context);
      }
    } else {
      if (_convertButton.inserted) {
        _convertButton.remove();
      }
    }

    return BlocListener<UserActionBlocCubit, UserActionBlocState>(
      listener: (context, state) {
        if (state.uiAction != null) {
          switch (state.uiAction!) {
            case UiAction.showConvertedButton:
              if (_isAvailableToShowing()) {
                _showConverterButton(context);
              }
              break;
            case UiAction.showInviteDialog:
              if (_isAvailableToShowing()) {
                _showInviteDialog(context, state.inviteUrl!);
              } else {
                context.read<UserActionBlocCubit>().postponeDialogCountdown();
              }
              break;
            case UiAction.showConvertWeb:
              _navigateToWeb(state.convertPbxUrl!);
              break;
          }
        }
      },
      child: widget.child,
    );
  }

  bool _isAvailableToShowing() {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.last.matchedLocation;

    return _availability.map((e) => router.namedLocation(e)).contains(location);
  }

  void _showConverterButton(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _convertButton.insert(context);
    });
  }

  void _showInviteDialog(BuildContext context, String url) {
    final bloc = context.read<UserActionBlocCubit>();

    showDialog(
      context: context,
      builder: (context) => ActionInviteDialog(
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
    GoRouter.of(context).pushNamed(
      MainRoute.userAction,
      queryParameters: {'url': url},
    );
  }
}
