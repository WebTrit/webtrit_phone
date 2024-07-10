import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

import '../bloc/demo_cubit.dart';
import '../widgets/widgets.dart';

class DemoShell extends StatefulWidget {
  const DemoShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DemoShell> createState() => _DemoShellState();
}

class _DemoShellState extends State<DemoShell> with RouteAware {
  static const _converterCardSize = Size(120, 120);
  static const _stickyPadding = EdgeInsets.all(8);

  DemoConvertButton? _convertButton;

  Size get _screenSize => MediaQuery.of(context).size;

  EdgeInsets get _safePadding => MediaQuery.of(context).padding;

  Offset get _defaultButtonOffset => _screenSize.bottomRight(Offset(
        -_converterCardSize.width - _stickyPadding.right,
        -_converterCardSize.height - kBottomNavigationBarHeight - _stickyPadding.bottom - _safePadding.bottom,
      ));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _convertButton = DemoConvertButton(
      stickyPadding: _stickyPadding,
      offset: _defaultButtonOffset,
      size: _converterCardSize,
      onTap: () => context.read<DemoCubit>().openDemoWebScreen(),
    );
  }

  @override
  void dispose() {
    _convertButton?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DemoCubit, DemoCubitState>(
          listenWhen: (previous, current) =>
              previous.convertPbxUrl != current.convertPbxUrl ||
              previous.showConvertedButton != current.showConvertedButton,
          listener: _handleConvertedState,
          child: widget.child,
        ),
        BlocListener<DemoCubit, DemoCubitState>(
          listenWhen: (previous, current) => previous.openDemoWebScreen != current.openDemoWebScreen,
          listener: _handleDemoWebScreenState,
          child: widget.child,
        )
      ],
      child: widget.child,
    );
  }

  void _handleConvertedState(BuildContext context, DemoCubitState state) {
    if (state.showConvertedButton && state.convertPbxUrl != null) {
      _showConverterButton(context, state);
    }

    if (!state.showConvertedButton) {
      _hideConverterButton();
    }
  }

  void _handleDemoWebScreenState(BuildContext context, DemoCubitState state) {
    if (state.openDemoWebScreen) {
      context.router.push(DemoWebPageRoute(initialUri: Uri.parse(state.convertPbxUrl!)));
    }
  }

  void _showConverterButton(BuildContext context, DemoCubitState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!(_convertButton?.inserted ?? false)) {
        _convertButton?.insert(context);
      }
    });
  }

  void _hideConverterButton() {
    if (_convertButton?.inserted ?? false) {
      _convertButton?.remove();
    }
  }
}
