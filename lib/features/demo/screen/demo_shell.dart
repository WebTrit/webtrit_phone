import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';

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
          listener: _listenActionsChanging,
          child: widget.child,
        ),
      ],
      child: BlocListener<AppBloc, AppState>(
        listener: _listenLocaleChanging,
        listenWhen: (AppState previous, AppState current) => previous.locale != current.locale,
        child: widget.child,
      ),
    );
  }

  void _listenLocaleChanging(BuildContext context, AppState state) {
    context.read<DemoCubit>().updateConfiguration(locale: state.locale);
  }

  void _listenActionsChanging(BuildContext context, DemoCubitState state) {
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
