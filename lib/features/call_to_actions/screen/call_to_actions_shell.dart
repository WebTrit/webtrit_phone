import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/models/models.dart';

import '../bloc/call_to_actions_cubit.dart';
import '../widgets/widgets.dart';

class CallToActionsShell extends StatefulWidget {
  const CallToActionsShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CallToActionsShell> createState() => _CallToActionsShellState();
}

class _CallToActionsShellState extends State<CallToActionsShell> with RouteAware {
  late final DemoActionOverlay _actionOverlay = DemoActionOverlay(
    screenSize: MediaQuery.of(context).size,
    safePadding: MediaQuery.of(context).padding,
    stickyPadding: const EdgeInsets.all(8),
  );

  @override
  void dispose() {
    _actionOverlay.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CallToActionsCubit, CallToActionsCubitState>(
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
    context.read<CallToActionsCubit>().changeLocale(state.locale);
  }

  void _listenActionsChanging(BuildContext context, CallToActionsCubitState state) {
    final callToAction = state.action;

    // Exit early if the call-to-action overlay should not be visible
    if (!state.isActionVisible) {
      _removeActionOverlay();
      return;
    }

    // Proceed only if there's a valid call-to-action
    if (callToAction != null) {
      _updateActionOverlay(context, callToAction);
    }
  }

  void _removeActionOverlay() {
    _actionOverlay.remove();
  }

  void _updateActionOverlay(BuildContext context, CallToAction action) {
    // Remove any existing overlay before inserting a new one
    _removeActionOverlay();

    final url = action.url;
    final button = DemoActionButton(title: action.title, description: action.description);

    _actionOverlay.insert(
      context: context,
      child: button,
      onTap: url != null ? () => _navigateToAction(context, url) : null,
    );
  }

  void _navigateToAction(BuildContext context, String url) {
    context.router.push(CallToActionsWebPageRoute(initialUrl: Uri.parse(url)));
  }
}
