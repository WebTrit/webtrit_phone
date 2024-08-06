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
  late final _demoActionButtonController = DemoActionOverlayController(context);

  @override
  void dispose() {
    _demoActionButtonController.removeAllOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DemoCubit, DemoCubitState>(
          listener: _handleConvertedState,
          child: widget.child,
        ),
      ],
      child: widget.child,
    );
  }

  void _handleConvertedState(BuildContext context, DemoCubitState state) {
    _demoActionButtonController.hideAllOverlay();
    for (var it in state.flavorActions) {
      _demoActionButtonController.addOverlay(
        id: it.url,
        child: DemoActionButton(
          title: it.title,
          description: it.description,
        ),
        onTap: () => context.router.push(DemoWebPageRoute(
          initialUrl: Uri.parse(it.url),
        )),
      );
    }
  }
}
